local cb_hdr = {}

function cb_hdr.content_1(MACRO_STRING, includes_str)
    return string.format([[
#ifndef %s
#define %s

#include "%s"
%s
#define IS_ENTER 1
#define IS_EXIT 0

void %s(%s);
void %s(void (*%s)(%s));

]],
        MACRO_STRING._CB_HEADDEF,
        MACRO_STRING._CB_HEADDEF,
        MACRO_STRING._IF_HEAD,
        includes_str,
        MACRO_STRING._CB_FUNC_DECL, MACRO_STRING._CB_ARGS,
        MACRO_STRING._SET_CB_DECL, MACRO_STRING._CB_DECL, MACRO_STRING._CB_ARGS
    )
end

function cb_hdr.content_2(MACRO_STRING, f)
    return string.format("#define %s%s(%s) { \\\n", MACRO_STRING._CB_GET_ARGS_PREFIX, f.name, MACRO_STRING._CB_DATA_NAME)
end

function cb_hdr.content_3(MACRO_STRING, name, arg, arg_type)
    return string.format("\t%s.args.%s.%s = (%s)%s; \\\n", MACRO_STRING._CB_DATA_NAME, name, arg, arg_type, arg)
end

function cb_hdr.content_4()
    return "};\n\n"
end

function cb_hdr.content_5()
    return "#endif"
end

return cb_hdr
