local io_interceptor = require("io_interceptor")

local files = {
    f1_s = require("intercept_table_mgr_c"),
    f1_h = require("intercept_table_mgr_h"),
    f2_s = require("intercepted_functions_c"),
    f2_h = require("intercepted_functions_h"),
    f3_s = require("callback_c"),
    f3_h = require("callback_h"),
    f4_s = require("interceptor_c"),
    f4_h = require("interceptor_h"),
    f5_s = require("handler_manager_c"),
    f5_h = require("handler_manager_h"),
    f6_s = require("logger_c"),
    f6_h = require("logger_h"),
    f7_s = require("functions_c")
    -- f7_h = require("functions_h")
}

local interceptor_generate = {}

-- COMMON --

function scandir(dir)
    local subdirectories = {}
    local command = "find \"" .. dir .. "\" -maxdepth 1 -type d"
    for line in io.popen(command):lines() do
        if line ~= dir then
            table.insert(subdirectories, string.match(line, "[^/]+$"))
        end
    end
    return subdirectories
end

local function generate_file(filepath, content)
    print("Content generated in '"..filepath.."'")
    io_interceptor.write_n_close(filepath, content)
end

local function get_include_str(includes_table)
    return "\n#include \""..table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

local function add_contents(contents, content, sep)
    if sep == nil then
        sep = ""
    end
    if contents == nil then
        contents = content
    else
        contents = contents..sep..content
    end
end
-- COMMON --

local function generate_contents(interceptor_data, function_to_intercept)
    local includes_str = get_include_str(interceptor_data.includes)
    local handler = interceptor_data.lib

    local subcontents = {
        f1_s = {}, -- Intercept_table_manager source
        f1_h = {}, -- Intercept_table_manager header
        f2_s_auto = {}, -- Intercepted_functions source autogen
        f2_s_man = {}, -- Intercepted_functions source mangen
        f2_h = {}, -- Intercepted_functions header
        f3_s = {}, -- Callback source
        f3_h = {}, -- Callback header
        f7_s = {}, -- Functions source
        f7_h = {} -- Functions header
    }
    
    for i, f in ipairs(function_to_intercept) do
        local names_param = {}
        local types_param = {}
        local api_data_t_lines = {}
        local cb_get_args_lines = {}
        
        for _, arg in ipairs(f.args) do
            local type_param, name_param = io_interceptor.parse_variable_declaration(arg)
            table.insert(types_param, type_param)
            table.insert(names_param, name_param)

            table.insert(api_data_t_lines, files.f2_h.api_data_t_line(arg))
            table.insert(cb_get_args_lines, files.f3_h.cb_get_args_line(f.name, name_param, type_param))
        end
        local names_param_str = table.concat(names_param, ", ")

        add_contents(subcontents.f1_s.load_table_block, files.f1_s.handle_line(f.name), "\n")
        add_contents(subcontents.f1_s.enable_domain_block, files.f1_s.enable_domain_line(f.name), "\n")
        add_contents(subcontents.f1_s.disable_domain_block, files.f1_s.disable_domain_line(f.name), "\n")
        
        add_contents(subcontents.f1_h.typedef_block, files.f1_h.typedef_line(f))
        add_contents(subcontents.f1_h.intercept_table_block, files.f1_h.itcp_tbl_line(f.name))
        
        add_contents(subcontents.f7_s.func_blk, files.f7_s.func_blk(f, names_param_str))
        if f.gen == "AUTOGEN" then
            add_contents(subcontents.f2_s_auto.func_blk, files.f2_s.func_blk(f, names_param_str))
        else
            add_contents(subcontents.f2_s_man.func_blk, files.f2_s.func_blk(f, names_param_str))
        end

        add_contents(subcontents.f2_h.api_data_t_block, files.f2_h.api_data_t_block(f.return_type, f.name, table.concat(api_data_t_lines,"\n")))
        add_contents(subcontents.f2_h.api_id_enum_block, files.f2_h.api_id_enum_block(f.name, i), "\n")
        add_contents(subcontents.f2_h.get_funame_block, files.f2_h.get_funame_block(f.name), "\n")
        add_contents(subcontents.f2_h.get_funid_block, files.f2_h.get_funid_block(f.name), "\n")

        add_contents(subcontents.f3_h.get_args_block, files.f3_h.cb_get_args_block(f.return_type, f.name, table.concat(cb_get_args_lines,"\n")))
    end

    return {
        file1_content = files.f1_s.content(includes_str, handler, subcontents.f1_s),
        file2_content = files.f1_h.content(includes_str, subcontents.f1_h),
        file3_content_auto = files.f2_s.content(includes_str, subcontents.f2_s_auto),
        file3_content_man = subcontents.f2_s_man.func_blk and files.f2_s.content(includes_str, subcontents.f2_s_man) or "",
        file4_content = files.f2_h.content(includes_str, subcontents.f2_h),
        file5_content = files.f3_s.content(),
        file6_content = files.f3_h.content(includes_str, subcontents.f3_h),
        file7_content = files.f7_s.content(includes_str, subcontents.f7_s)
    }
end

-- COMMAND --
function interceptor_generate.command(config_data, domain_list)
    io_interceptor.mkdir(S._COREDIR)
    io_interceptor.mkdir(S._UTILSDIR)
    local include_flag = ""
    local compile_flag = ""

    for _, domain in ipairs(domain_list) do
        local interceptor_data = config_data[domain]
        if interceptor_data == nil then
            print("Warning: Skipping "..domain..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..domain..", config file not complete")
        else
            local function_to_intercept = io_interceptor.parseCSV(interceptor_data.input_csv)
            S._CURRENT_DOMAIN = domain
            local contents = generate_contents(interceptor_data, function_to_intercept)
            io_interceptor.mkdir(S:_AUTOGEN_DOMAIN_DIR(domain))
            generate_file(S:_ITM_SRC_PATH(domain), contents.file1_content)
            generate_file(S:_ITM_HEAD_PATH(domain), contents.file2_content)
            generate_file(S:_IF_AUTO_SRC_PATH(domain), contents.file3_content_auto)
            generate_file(S:_IF_HEAD_PATH(domain), contents.file4_content)
            generate_file(S:_CB_SRC_PATH(domain), contents.file5_content)
            generate_file(S:_CB_HEAD_PATH(domain), contents.file6_content)
            generate_file(S:_F_SRC_PATH(domain), contents.file7_content)
            if contents.file3_content_man ~= "" then
                io_interceptor.mkdir(S:_MANGEN_DOMAIN_DIR(domain))
                generate_file(S:_IF_MAN_SRC_PATH(domain), contents.file3_content_man)
            end
            add_contents(include_flag, table.concat(interceptor_data.includes, " -I"), " ")
            add_contents(compile_flag, interceptor_data.compile_flag, " ")
        end                  
    end

    local domain_list = scandir(S._AUTOGENDIR)
    local subcontents = {
        f4_s = {}, -- Interceptor source
        f4_h = {}, -- Interceptor header
        f5_s = {}, -- Handler_manager source
        f5_h = {}, -- Handler_manager header
        f6_s = {}, -- Logger source
        f6_h = {}  -- Logger header
    }
    for _, domain in ipairs(domain_list) do
        domain = domain:sub(1, -#("_"..S._TOOLS_NAME)-1)
        S._CURRENT_DOMAIN = domain
        add_contents(subcontents.f4_s.load_block, files.f4_s.load_line(), "\n")
        add_contents(subcontents.f4_s.enable_case_block, files.f4_s.enable_case_line(), "\n")
        add_contents(subcontents.f4_s.disable_case_block, files.f4_s.disable_case_line(), "\n")
        add_contents(subcontents.f4_h.include_block, files.f4_h.include_line(), "\n")
        add_contents(subcontents.f4_h.enum_block, files.f4_h.enum_line(), ",\n")
    end
    generate_file(S:_INTERCEPTOR_SRC_PATH(), files.f4_s.content(subcontents.f4_s))
    generate_file(S:_INTERCEPTOR_HEAD_PATH(), files.f4_h.content(subcontents.f4_h))
    generate_file(S:_HANDLER_MGR_SRC_PATH(), files.f5_s.content())
    generate_file(S:_HANDLER_MGR_HEAD_PATH(), files.f5_h.content())
    generate_file(S:_LOGGER_SRC_PATH(), files.f6_s.content())
    generate_file(S:_LOGGER_HEAD_PATH(), files.f6_h.content())

end

return interceptor_generate
