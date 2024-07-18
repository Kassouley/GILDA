local io_interceptor = require("io_interceptor")

local files = {
    file1 = require("content_intercept_table_mgr_source"),
    file2 = require("content_intercept_table_mgr_header"),
    file3 = require("content_intercepted_functions_source"),
    file4 = require("content_intercepted_functions_header"),
    file5 = require("content_callback_source"),
    file6 = require("content_callback_header")
}

local interceptor_generate = {}

-- COMMON --

local function generate_file(filepath, content)
    io_interceptor.write_n_close(filepath, content)
end

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
        _CB_GET_ARGS_PREFIX = "GET_CB_ARGS_DATA_",

        _HANDLE_MGR_HEAD = "handler_manager.h"
    }
end

-- COMMON --

local function generate_contents(MACRO_STRING, interceptor_data, function_to_intercept)
    local includes_str = get_include_str(interceptor_data.includes)
    local handler = interceptor_data.lib

    local contents = {
        file_1 = {}, -- Intercept_table_manager source
        file_2 = {}, -- Intercept_table_manager header
        file_3_auto = {}, -- Intercepted_functions source autogen
        file_3_man = {}, -- Intercepted_functions source mangen
        file_4 = {}, -- Intercepted_functions header
        file_5 = {}, -- Callback source
        file_6 = {} -- Callback header
    }
    
    local ctnt_file_4_2 = {} -- Intercepted_functions header
    local ctnt_file_4_3 = {} -- Intercepted_functions header
    local ctnt_file_4_4 = {} -- Intercepted_functions header

    table.insert(contents.file_1, files.file1.content_1(MACRO_STRING, includes_str, handler))
    table.insert(contents.file_2, files.file2.content_1(MACRO_STRING, includes_str))
    table.insert(contents.file_3_auto, files.file3.content_1(MACRO_STRING, includes_str))
    table.insert(contents.file_3_man, files.file3.content_1(MACRO_STRING, includes_str))
    table.insert(contents.file_4, files.file4.content_1(MACRO_STRING, includes_str))
    table.insert(contents.file_5, files.file5.content_1(MACRO_STRING))
    table.insert(contents.file_6, files.file6.content_1(MACRO_STRING, includes_str))
    
    
    table.insert(ctnt_file_4_2, files.file4.content_2a(MACRO_STRING))
    table.insert(ctnt_file_4_3, files.file4.content_3a(MACRO_STRING))
    table.insert(ctnt_file_4_4, files.file4.content_4a(MACRO_STRING))

    for i, f in ipairs(function_to_intercept) do
        local names_param = {}
        local types_param = {}
        
        table.insert(ctnt_file_4_4, files.file4.content_4b())
        table.insert(contents.file_6, files.file6.content_2(MACRO_STRING, f))
        
        for _, arg in ipairs(f.args) do
            local type_param, name_param = io_interceptor.parse_variable_declaration(arg)
            table.insert(types_param, type_param)
            table.insert(names_param, name_param)
            table.insert(contents.file_6, files.file6.content_3(MACRO_STRING, f.name, name_param, type_param))
            table.insert(ctnt_file_4_4, files.file4.content_4c(arg))
        end
        local names_param_str = table.concat(names_param, ", ")
        
        table.insert(contents.file_1, files.file1.content_2(MACRO_STRING, f))
        table.insert(contents.file_2, files.file2.content_2(MACRO_STRING, f))
        if f.gen == "AUTOGEN" then
            table.insert(contents.file_3_auto, files.file3.content_2(f, MACRO_STRING, names_param_str))
        else
            table.insert(contents.file_3_man,  files.file3.content_2(f, MACRO_STRING, names_param_str))
        end
        table.insert(ctnt_file_4_2, files.file4.content_2b(MACRO_STRING, f, i))
        table.insert(ctnt_file_4_3, files.file4.content_3b(MACRO_STRING, f))
        table.insert(ctnt_file_4_4, files.file4.content_4d(f))
        table.insert(contents.file_6, files.file6.content_4())
    end

    table.insert(contents.file_1, files.file1.content_3())
    table.insert(contents.file_2, files.file2.content_3())

    table.insert(ctnt_file_4_2, files.file4.content_2c())
    table.insert(ctnt_file_4_3, files.file4.content_3c())
    table.insert(ctnt_file_4_4, files.file4.content_4e(MACRO_STRING))
    
    table.insert(contents.file_4, table.concat(ctnt_file_4_2))
    table.insert(contents.file_4, table.concat(ctnt_file_4_3))
    table.insert(contents.file_4, table.concat(ctnt_file_4_4))
    table.insert(contents.file_4, files.file4.content_5())
    
    table.insert(contents.file_6, files.file6.content_5())

    local ret = {
        file1_content = table.concat(contents.file_1),
        file2_content = table.concat(contents.file_2),
        file3_content_auto = table.concat(contents.file_3_auto),
        file3_content_man = "",
        file4_content = table.concat(contents.file_4),
        file5_content = table.concat(contents.file_5),
        file6_content = table.concat(contents.file_6)
    }

    if #contents.file_3_man ~= 1 then
        ret.file3_content_man = table.concat(contents.file_3_man)
    end

    return ret
end

-- COMMAND --
function interceptor_generate.command(config_data, interceptor_list)
    io_interceptor.mkdir(GENDIR)
    io_interceptor.mkdir(COREDIR)

    for _, interceptor_name in ipairs(interceptor_list) do
        local interceptor_data = config_data[interceptor_name]
        if interceptor_data == nil then
            print("Warning: Skipping "..interceptor_name..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..interceptor_name..", config file not complete")
        else
            local MACRO_STRING = get_macro_string(interceptor_name)
            local function_to_intercept = io_interceptor.parseCSV(interceptor_data.input_csv)
            
            local contents = generate_contents(MACRO_STRING, interceptor_data, function_to_intercept)
            local autogen_dirname = AUTOGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR
            io_interceptor.mkdir(autogen_dirname)
            generate_file(autogen_dirname.."/"..MACRO_STRING._ITM_SRC, contents.file1_content)
            generate_file(autogen_dirname.."/"..MACRO_STRING._ITM_HEAD, contents.file2_content)
            generate_file(autogen_dirname.."/"..MACRO_STRING._IF_SRC, contents.file3_content_auto)
            generate_file(autogen_dirname.."/"..MACRO_STRING._IF_HEAD, contents.file4_content)
            generate_file(autogen_dirname.."/"..MACRO_STRING._CB_SRC, contents.file5_content)
            generate_file(autogen_dirname.."/"..MACRO_STRING._CB_HEAD, contents.file6_content)
            if contents.file3_content_man ~= "" then
                local mangen_dirname = MANGENDIR.."/"..MACRO_STRING._INTERCEPTOR_DIR
                io_interceptor.mkdir(mangen_dirname)
                generate_file(mangen_dirname.."/"..MACRO_STRING._IF_SRC, contents.file3_content_man)
            end
        end                  
    end
end

return interceptor_generate
