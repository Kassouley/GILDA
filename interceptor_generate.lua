local io_interceptor = require("io_interceptor")

local interceptor_generate = {}

-- COMMON --
local function get_include_str(includes_table)
    local _inc_str = ""
    for _, inc in ipairs(includes_table) do
        _inc_str = _inc_str.."#include \""..inc.."\"\n"
    end
    return _inc_str.."\n"
end

local function get_macro_string(interceptor_name)
    local interceptor_name_lower = string.lower(interceptor_name)
    local interceptor_name_upper = string.upper(interceptor_name)
    local api_id_t = interceptor_name.."_api_id_t"
    local api_data_t = interceptor_name.."_api_data_t"

    return {
        _INTERCEPTOR_NAME = interceptor_name,
        _INTERCEPTOR_NAME_LOWER = interceptor_name_lower,
        _INTERCEPTOR_NAME_UPPER = interceptor_name_upper,
        _INTERCEPTOR_DIR = interceptor_name.."_interceptor",

        _API_DATA_S = interceptor_name.."_api_data_s",
        _API_DATA_T = api_data_t,
        _API_ID_T = api_id_t,

        _INTERCEPT_TABLE_T = interceptor_name.."_intercept_table_t",
        _INTERCEPT_TABLE_DECL = interceptor_name.."_itcp_table",
        _INTERCEPT_FUNC_PREFIX = "fn_",

        _ITM_SRC = interceptor_name.."_intercept_table_mgr.cpp",
        _ITM_HEAD = interceptor_name.."_intercept_table_mgr.h",
        _ITM_HEADDEF = interceptor_name_upper.."_INTERCEPT_TABLE_MGR_H",
        _ITM_LOAD_TABLE_DECL = "load_"..interceptor_name.."_itcp_table",

        _IF_SRC = interceptor_name.."_intercepted_functions.cpp",
        _IF_HEAD = interceptor_name.."_intercepted_functions.h",
        _IF_HEADDEF = interceptor_name_upper.."_INTERCEPTED_FUNCTIONS_H",
        _IF_GET_FUNAME_TYPE = "static const char*",
        _IF_GET_FUNAME_DECL = "get_"..interceptor_name.."_funame_by_id",
        _IF_FUN_ID_PREFIX = interceptor_name_upper.."_API_ID_",

        _CB_SRC = interceptor_name.."_callback.cpp",
        _CB_HEAD = interceptor_name.."_callback.h",
        _CB_HEADDEF = interceptor_name_upper.."_CALLBACK_H",
        _CB_DECL = interceptor_name.."_callback",
        _CB_ARG1_TYPE = "bool",
        _CB_ARG1_NAME = "is_enter",
        _CB_ARG2_TYPE = api_id_t,
        _CB_ARG2_NAME = "func_id",
        _CB_ARG3_TYPE = api_data_t,
        _CB_ARG3_NAME = "data",
        _CB_ARGS = "bool is_enter, "..api_id_t.." func_id, "..api_data_t.." data",
        _STORED_CB_DECL = "stored_"..interceptor_name.."_callback",
        _SET_CB_DECL = "set_"..interceptor_name.."_interceptor_callback",
        _CB_FUNC_DECL = interceptor_name.."_callback_function",

        _HANDLE_MGR_HEAD = "handler_manager.h"
    }
end

-- COMMON --

-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER SOURCE --
local function get_itcp_tbl_mgr_src_content_1(MACRO_STRING, includes_table)
    return  "#include \""..MACRO_STRING._ITM_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._HANDLE_MGR_HEAD.."\"\n"..
            get_include_str(interceptor_data.includes)..
            MACRO_STRING._INTERCEPT_TABLE_T.." "..MACRO_STRING._INTERCEPT_TABLE_DECL..";\n\n"..
            "void "..MACRO_STRING._ITM_LOAD_TABLE_DECL.."() {\n"..
            "\tvoid *handle = load_handle(\""..interceptor_data.lib.."\");\n"
end
local function get_itcp_tbl_mgr_src_content_2(MACRO_STRING, f)
    return "\tHANDLE("..MACRO_STRING._INTERCEPT_TABLE_DECL..", "..f.name..", handle);\n"
end
local function get_itcp_tbl_mgr_src_content_3()
    return "};\n\n"
end
-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER SOURCE --


-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER HEADER --
local function get_itcp_tbl_mgr_hdr_content_1(MACRO_STRING, interceptor_data)
    return  "#ifndef "..MACRO_STRING._ITM_HEADDEF.."\n"..
            "#define "..MACRO_STRING._ITM_HEADDEF.."\n\n"..
            get_include_str(interceptor_data.includes)..
            "void "..MACRO_STRING._ITM_LOAD_TABLE_DECL.."();\n\n"..
            "struct "..MACRO_STRING._INTERCEPT_TABLE_T.." {\n"
end
local function get_itcp_tbl_mgr_hdr_content_2(MACRO_STRING, f)
    return "\ttypeof(&"..f.name..") "..MACRO_STRING._INTERCEPT_FUNC_PREFIX..f.name..";\n"
end
local function get_itcp_tbl_mgr_hdr_content_3()
    return  "};\n"..
            "#endif"
end
-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER HEADER --

local function generate(MACRO_STRING, interceptor_data, function_to_intercept)
    local _ctnt_file_1 = get_itcp_tbl_mgr_src_content_1(MACRO_STRING, interceptor_data)
    
    local _ctnt_file_2 = get_itcp_tbl_mgr_hdr_content_1(MACRO_STRING, interceptor_data)
    
    local _ctnt_file_3_auto = get_itcp_fnct_src_content_1(MACRO_STRING, interceptor_data)
    local _ctnt_file_3_man = nil
    local _content_autogen = ""
    local _content_mangen = ""

    local _ctnt_file_4_1 = get_itcp_fnct_hdr_content_1(MACRO_STRING, interceptor_data)
    local _ctnt_file_4_2 = get_itcp_fnct_hdr_content_2a(MACRO_STRING)
    local _ctnt_file_4_3 = get_itcp_fnct_hdr_content_3a(MACRO_STRING)
    local _ctnt_file_4_4 = get_itcp_fnct_hdr_content_4a(MACRO_STRING)


    for i, f in ipairs(function_to_intercept) do
        _ctnt_file_4_2 = _ctnt_file_4_2..get_itcp_fnct_hdr_content_2b(MACRO_STRING, f, i)
        _ctnt_file_4_3 = _ctnt_file_4_3..get_itcp_fnct_hdr_content_3b(MACRO_STRING, f)
                                        
        local names_param = {}
        local types_param = {}
        for _, arg in ipairs(f.args) do
            local type_param, name_param = io_interceptor.parse_variable_declaration(arg)
            table.insert(types_param, type_param)
            table.insert(names_param, name_param)
            _ctnt_file_4_4 = _ctnt_file_4_4.get_itcp_fnct_hdr_content_4b(arg)
        end
        local names_param_str = table.concat(names_param, ", ")
        _ctnt_file_4_4 = _ctnt_file_4_4..get_itcp_fnct_hdr_content_4c(f)
        
        
        _ctnt_file_1 = _ctnt_file_1..get_itcp_tbl_mgr_src_content_2(MACRO_STRING, f)
        _ctnt_file_2 = _ctnt_file_2..get_itcp_tbl_mgr_hdr_content_2(MACRO_STRING, f)
    
        local _content_aux = get_itcp_fnct_src_content_2(f, MACRO_STRING)
        if f.gen == "AUTOGEN" then
            _content_autogen = _content_autogen.._content_aux
        else
            _content_mangen = _content_mangen.._content_aux
        end
    end
    _ctnt_file_1 = _ctnt_file_1..get_itcp_tbl_mgr_src_content_3()
    _ctnt_file_2 = _ctnt_file_2..get_itcp_tbl_mgr_hdr_content_3()

    _ctnt_file_4_2 = _ctnt_file_4_2..get_itcp_fnct_hdr_content_2c()
    _ctnt_file_4_3 = _ctnt_file_4_3..get_itcp_fnct_hdr_content_3c()
    _ctnt_file_4_4 = _ctnt_file_4_4..get_itcp_fnct_hdr_content_4d(MACRO_STRING)

    local _ctnt_file_4 = _ctnt_file_4_1..
                         _ctnt_file_4_2..
                         _ctnt_file_4_3..
                         _ctnt_file_4_4..
                         get_itcp_fnct_hdr_content_5()

    _ctnt_file_3_auto = _ctnt_file_3_auto.._content_autogen 
    if _content_mangen ~= "" then
        _ctnt_file_3_man = _ctnt_file_3_auto.._content_mangen
    end
end

-- AUTOGEN INTERCEPT_TABLE_MGR --
local function generate_intercept_table_mgr(MACRO_STRING, interceptor_data, function_to_intercept)
    local _content_source = get_intercept_table_mgr_source_content(MACRO_STRING, interceptor_data, function_to_intercept)
    local _content_header = get_intercept_table_mgr_header_content(MACRO_STRING, interceptor_data, function_to_intercept)
    local source_path = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._ITM_SRC
    local header_path = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._ITM_HEAD
    io_interceptor.write_n_close(source_path, _content_source)
    io_interceptor.write_n_close(header_path, _content_header)
end

-- AUTOGEN CONTENT INTERCEPTED_FUNCTIONS SOURCE --
local function get_itcp_fnct_src_content_1(MACRO_STRING, interceptor_data)
    return  "#include \""..MACRO_STRING._IF_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._ITM_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._CB_HEAD.."\"\n"..
            get_include_str(interceptor_data.includes)..
            "extern "..MACRO_STRING._INTERCEPT_TABLE_T.." "..MACRO_STRING._INTERCEPT_TABLE_DECL..";\n\n"
end
local function get_itcp_fnct_src_content_2(f, MACRO_STRING, names_param_str)
    local function_header = f.return_type.." "..f.name.."("..table.concat(f.args, ", ")..") {\n"
    local function_body = "\t"..MACRO_STRING._CB_FUNC_DECL.."(1, \""..f.name.."\");\n"
                          
    if f.return_type ~= "void" then
        function_body = function_body ..
                        "\t"..f.return_type.." ret = "..MACRO_STRING._INTERCEPT_TABLE_DECL.."."..MACRO_STRING._INTERCEPT_FUNC_PREFIX..f.name.."("..names_param_str..");\n"..
                        "\t"..MACRO_STRING._CB_FUNC_DECL.."(0, \""..f.name.."\");\n"..
                        "\treturn ret;\n"
    else
        function_body = function_body ..
                        "\t"..MACRO_STRING._INTERCEPT_TABLE_DECL.."."..MACRO_STRING._INTERCEPT_FUNC_PREFIX..f.name.."("..names_param_str..");\n"..
                        "\t"..MACRO_STRING._CB_FUNC_DECL.."(0, \""..f.name.."\");\n"..
                        "\treturn;\n"
    end
    
    function_body = function_body.."}\n\n"
    return function_header..function_body
end
-- AUTOGEN CONTENT INTERCEPTED_FUNCTIONS SOURCE --


-- AUTOGEN CONTENT INTERCEPTED_FUNCTIONS HEADER --
local function get_itcp_fnct_hdr_content_1(MACRO_STRING, interceptor_data)
    return  "#ifndef "..MACRO_STRING._IF_HEADDEF.."\n"..
            "#define "..MACRO_STRING._IF_HEADDEF.."\n\n"..
            get_include_str(interceptor_data.includes)
end
local function get_itcp_fnct_hdr_content_2a(MACRO_STRING)
    return  "// "..MACRO_STRING._INTERCEPTOR_NAME_UPPER.." API ID enum\n"..
            "enum "..MACRO_STRING._API_ID_T.." {\n"
end
local function get_itcp_fnct_hdr_content_2b(MACRO_STRING, f, i)
    return  "\t"..MACRO_STRING._IF_FUN_ID_PREFIX..f.name.." = "..i..",\n"
end
local function get_itcp_fnct_hdr_content_2b()
    return  "};\n\n"
end
local function get_itcp_fnct_hdr_content_3a(MACRO_STRING)
    return  "// Return "..MACRO_STRING._INTERCEPTOR_NAME_UPPER.." API function name for a given ID\n"..
            MACRO_STRING._IF_GET_FUNAME_TYPE.." "..MACRO_STRING._IF_GET_FUNAME_DECL.."("..MACRO_STRING._API_ID_T.." id) {\n"..
            "\tswitch(id) {\n"
end
local function get_itcp_fnct_hdr_content_3b(MACRO_STRING, f)
    return "\t\tcase "..MACRO_STRING._IF_FUN_ID_PREFIX..f.name.." : return \""..f.name.."\";\n"
end
local function get_itcp_fnct_hdr_content_3c()
    return  "\t}\n"..
            "\treturn NULL;\n"..
            "}\n\n"
end
local function get_itcp_fnct_hdr_content_4a(MACRO_STRING)
    return  "// "..MACRO_STRING._INTERCEPTOR_NAME_UPPER.." API data\n"..
            "typedef struct "..MACRO_STRING._API_DATA_S.." {\n"..
            "\tuint64_t corrId;\n"..
            "\tbool is_enter;\n"..
            "\tunion {\n"..
            "\t\tstruct {\n"
end
local function get_itcp_fnct_hdr_content_4b(arg)
    return "\t\t\t"..arg..";\n"
end
local function get_itcp_fnct_hdr_content_4c(f)
    return "\t\t} "..f.name..";\n"
end
local function get_itcp_fnct_hdr_content_4d(MACRO_STRING)
    return  "\t} args;\n"..
            "} "..MACRO_STRING._API_DATA_T..";\n\n"
end
local function get_itcp_fnct_hdr_content_5()
    return  "#endif"
end

-- AUTOGEN INTERCEPTED_FUNCTIONS --
local function generate_intercepted_functions(MACRO_STRING, interceptor_data, function_to_intercept)
    local _content_autogen, _content_mangen = get_intercepted_functions_source_content(MACRO_STRING, interceptor_data, function_to_intercept)
    local _content_header = get_intercepted_functions_header_content(MACRO_STRING, interceptor_data, function_to_intercept)
    local autogen_source_path = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._IF_SRC
    local autogen_header_path = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._IF_HEAD
    local mangen_source_path  = MANGENDIR.. "/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._IF_SRC
    
    if _content_mangen ~= nil then
        io_interceptor.mkdir(MANGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR)
        io_interceptor.write_n_close(mangen_source_path, _content_mangen)
    end
    io_interceptor.write_n_close(autogen_source_path, _content_autogen)
    io_interceptor.write_n_close(autogen_header_path, _content_header)
    return 
end

local function get_callback_header_content(MACRO_STRING)
    local _content = "#ifndef "..MACRO_STRING._CB_HEADDEF.."\n"..
                     "#define "..MACRO_STRING._CB_HEADDEF.."\n\n"..
                     "void "..MACRO_STRING._CB_FUNC_DECL.."("..MACRO_STRING._CB_ARGS..");\n"..
                     "void "..MACRO_STRING._SET_CB_DECL.."(void (*"..MACRO_STRING._CB_DECL..")("..MACRO_STRING._CB_ARGS.."));\n\n"..
                     "#endif"

    return _content
end

local function get_callback_source_content(MACRO_STRING)
    return  "#include <stdio.h>\n"..
            "#include <stdlib.h>\n"..
            "#include \""..MACRO_STRING._IF_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._CB_HEAD.."\"\n\n"..
            "void (*"..MACRO_STRING._STORED_CB_DECL..")("..MACRO_STRING._CB_ARGS..");\n\n"..
            "void "..MACRO_STRING._SET_CB_DECL.."(void (*"..MACRO_STRING._CB_DECL..")("..MACRO_STRING._CB_ARGS..")) {\n"..
                "\t"..MACRO_STRING._STORED_CB_DECL.." = "..MACRO_STRING._CB_DECL..";\n"..
            "}\n\n"..
            "void "..MACRO_STRING._CB_FUNC_DECL.."("..MACRO_STRING._CB_ARGS..") {\n"..
            "\tif ("..MACRO_STRING._STORED_CB_DECL..") {\n"..
                "\t\t"..MACRO_STRING._STORED_CB_DECL.."("..MACRO_STRING._CB_ARG1_NAME..", "..MACRO_STRING._CB_ARG2_NAME..", "..MACRO_STRING._CB_ARG3_NAME..");\n"..
            "\t} else {\n"..
                "\t\tfprintf(stderr, \"No "..MACRO_STRING._INTERCEPTOR_NAME.." callback function has been set.\\n\");\n"..
            "\t}\n"..
            "}"
end


local function generate_callback(MACRO_STRING)
    local _content_source = get_callback_source_content(MACRO_STRING)
    local _content_header = get_callback_header_content(MACRO_STRING)
    local source_path = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._CB_SRC
    local header_path = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR.."/"..MACRO_STRING._CB_HEAD
    io_interceptor.write_n_close(source_path, _content_source)
    io_interceptor.write_n_close(header_path, _content_header)
end

-- COMMAND --
function interceptor_generate.command(config_data, interceptor_list)
    io_interceptor.mkdir(GENDIR)
    io_interceptor.mkdir(COREDIR)
    io_interceptor.mkdir(AUTOGENDIR)
    io_interceptor.mkdir(MANGENDIR)

    for _, interceptor_name in ipairs(interceptor_list) do
        local interceptor_data = config_data[interceptor_name]
        if interceptor_data == nil then
            print("Warning: Skipping "..interceptor_name..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..interceptor_name..", config file not complete")
        else
            local MACRO_STRING = get_macro_string(interceptor_name)
            local function_to_intercept = io_interceptor.parseCSV(interceptor_data.input_csv)
            
            io_interceptor.mkdir(AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR)
            generate_intercepted_functions(MACRO_STRING, interceptor_data, function_to_intercept)
            generate_intercept_table_mgr(MACRO_STRING, interceptor_data, function_to_intercept)
            generate_callback(MACRO_STRING)
        end                  
        -- os.execute("make -B -C ./output LFLAGS=\""..config_data.compilation_flag.."\"")
    end
end

return interceptor_generate
