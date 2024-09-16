import clang.cindex
import sys
import csv
import subprocess

# Set the path to your libclang library
clang.cindex.Config.set_library_file('/opt/rocm/lib/llvm/lib/libclang.so')

def preprocess_file(header_file):
    """ Preprocess the file using cpp command and return the preprocessed file content. """
    cpp_command = ['cpp', '-E', '-I/opt/rocm/include', '-D __HIP_PLATFORM_AMD__', header_file]
    preprocessed_file = subprocess.run(cpp_command, stdout=subprocess.PIPE, universal_newlines=True)
    return preprocessed_file.stdout

def extract_typedefs_structs_and_functions(preprocessed_code):
    index = clang.cindex.Index.create()
    translation_unit = index.parse('tmp.c', unsaved_files=[('tmp.c', preprocessed_code)], args=['-I/usr/include', '-I/usr/local/include'])

    typedefs = set()
    structs_unions = set()
    function_prototypes = set()
    opaque_types = set()

    def extract_fields(node):
        fields = []
        for field in node.get_children():
            if field.kind == clang.cindex.CursorKind.FIELD_DECL:
                fields.append((field.type.spelling, field.spelling))
        return fields

    def is_forward_declared(node):
        """ Check if the struct/union is forward-declared (i.e., has no definition). """
        return not node.is_definition()

    def visit_node(node):
        if node.kind == clang.cindex.CursorKind.TYPEDEF_DECL:
            true_type = node.underlying_typedef_type.spelling
            if node.underlying_typedef_type.kind == clang.cindex.TypeKind.POINTER:
                pointee_type = node.underlying_typedef_type.get_pointee()
                if pointee_type.kind == clang.cindex.TypeKind.RECORD and is_forward_declared(pointee_type.get_declaration()):
                    opaque_types.add(node.spelling)
            typedefs.add((node.spelling, true_type))
        elif node.kind in (clang.cindex.CursorKind.STRUCT_DECL, clang.cindex.CursorKind.UNION_DECL):
            if not is_forward_declared(node):
                fields = extract_fields(node)
                if fields:
                    structs_unions.add((node.spelling, tuple(fields)))
        elif node.kind == clang.cindex.CursorKind.FUNCTION_DECL:
            if node.is_definition():
                return
            return_type = node.result_type.spelling
            function_name = node.spelling
            parameters = tuple((param.type.spelling, param.spelling) for param in node.get_arguments())
            function_prototypes.add((return_type, function_name, parameters))
        for child in node.get_children():
            visit_node(child)

    visit_node(translation_unit.cursor)

    return typedefs, structs_unions, function_prototypes, opaque_types

def write_typedefs_csv(typedefs, output_file):
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=";")
        for typedef in typedefs:
            writer.writerow(typedef)

def write_structs_unions_csv(structs_unions, output_file):
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=";")
        for struct_union in structs_unions:
            row = [struct_union[0]]
            for field in struct_union[1]:
                row.append(field[0])
                row.append(field[1])
            writer.writerow(row)

def write_functions_csv(functions, output_file):
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=";")
        for function in functions:
            row = ["AUTOGEN", function[0], function[1]]  # return type and function name
            for param in function[2]:
                row.append(param[0])  # parameter type
                row.append(param[1])  # parameter name
            writer.writerow(row)

def write_opaque_types_csv(opaque_types, output_file):
    """ Write opaque types to a CSV file. """
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=";")
        for opaque_type in opaque_types:
            writer.writerow([opaque_type])

def main():
    if len(sys.argv) < 4:
        print(f"Usage: python {sys.argv[0]} <domain_name> <output_dir> <header_file>")
        sys.exit(1)

    domain_name = sys.argv[1]
    output_dir = sys.argv[2]
    header_files = sys.argv[3:]

    all_typedefs = set()
    all_structs_unions = set()
    all_function_prototypes = set()
    all_opaque_types = set()

    for header_file in header_files:
        preprocessed_code = preprocess_file(header_file)
        typedefs, structs_unions, function_prototypes, opaque_types = extract_typedefs_structs_and_functions(preprocessed_code)
        all_typedefs.update(typedefs)
        all_structs_unions.update(structs_unions)
        all_function_prototypes.update(function_prototypes)
        all_opaque_types.update(opaque_types)

    # Write the CSV files
    write_typedefs_csv(all_typedefs, f'{output_dir}/{domain_name}_typedefs.csv')
    write_structs_unions_csv(all_structs_unions, f'{output_dir}/{domain_name}_structs_unions.csv')
    write_functions_csv(all_function_prototypes, f'{output_dir}/{domain_name}_function.csv')
    write_opaque_types_csv(all_opaque_types, f'{output_dir}/{domain_name}_opaque_types.csv')

    print("CSV files generated successfully.")

if __name__ == '__main__':
    main()
