local common = require("common")
local FileManager = require("FileManager")

local files = {
    atm_src = FileManager:new("_ATM_SRC_PATH", "api_table_mgr_c"),
    atm_hdr = FileManager:new("_ATM_HEAD_PATH", "api_table_mgr_h"),
    if_src  = FileManager:new("_IF_SRC_PATH", "intercepted_functions_c"),
    if_hdr  = FileManager:new("_IF_HEAD_PATH", "intercepted_functions_h"),
    cb_src  = FileManager:new("_CB_SRC_PATH", "callback_c"),
    cb_hdr  = FileManager:new("_CB_HEAD_PATH", "callback_h"),
    i_src   = FileManager:new("_INTERCEPTOR_SRC_PATH", "interceptor_c"),
    i_hdr   = FileManager:new("_INTERCEPTOR_HEAD_PATH", "interceptor_h"),
    hm_src  = FileManager:new("_HANDLER_MGR_SRC_PATH", "handler_manager_c"),
    hm_hdr  = FileManager:new("_HANDLER_MGR_HEAD_PATH", "handler_manager_h"),
    log_src = FileManager:new("_LOGGER_SRC_PATH", "logger_c"),
    log_hdr = FileManager:new("_LOGGER_HEAD_PATH", "logger_h"),
    f_man   = FileManager:new("_F_MAN_SRC_PATH", "functions_c"),
    f_auto  = FileManager:new("_F_AUTO_SRC_PATH", "functions_c"),
    env_src = FileManager:new("_ENV_SRC_PATH", "env_c"),
    env_hdr = FileManager:new("_ENV_HEAD_PATH", "env_h"),
    tools   = FileManager:new("_TOOL_SRC_PATH", "tools_c"),
    mkf     = FileManager:new("_MAKEFILE_PATH", "makefile"),
    script  = FileManager:new("_SCRIPT_PATH", "script_sh")
}

local gilda_gen = {}

local function get_include_str(includes_table)
    return "\n#include \""..table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

local function parse_variable_declaration(declaration)
    local pattern1 = "^%s*([%w%s_]+)%s*([%*%s]+)%s*([%w_]+)%s*$"
    local return_type, pointer_symbol, variable_name = declaration:match(pattern1)
    if return_type and variable_name and pointer_symbol then
        local type_str = return_type .. pointer_symbol
        return type_str, variable_name
    end

    local pattern2 = "^%s*([%w%s_]+)%s*([%*%s]+)%s*(%(.+%))%s*$"
    local return_type, pointer_symbol, variable_name = declaration:match(pattern2)
    if return_type and variable_name and pointer_symbol then
        local cb_name, cb_args = variable_name:match("^%(%*?([%w_]+)%)%((.+)%)")
        local cb_type = return_type .. pointer_symbol .. "(*) (" .. cb_args .. ")" 
        return cb_type, cb_name
    else
        return nil, nil
    end
end

local function generate_domain_contents(interceptor_data, function_to_intercept)
    local includes_str = get_include_str(interceptor_data.includes)
    local handler = interceptor_data.lib

    for _, file in pairs(files) do
        file:reset_subcontent()
    end
    
    for _, f in ipairs(function_to_intercept) do
        local names_param = {}
        local types_param = {}
        local api_data_t_lines = {}
        local cb_get_args_lines = {}
        
        for _, arg in ipairs(f.args) do
            local type_param, name_param = parse_variable_declaration(arg)
            table.insert(types_param, type_param)
            table.insert(names_param, name_param)

            table.insert(api_data_t_lines, files.if_hdr.getter.api_data_t_line(arg))
            table.insert(cb_get_args_lines, files.cb_hdr.getter.cb_get_args_line(f.name, name_param, type_param))
        end
        local names_param_str = table.concat(names_param, ", ")

        files.atm_src:add_subcontent("load_table_block", "\n", f.name)
        files.atm_src:add_subcontent("enable_domain_block", "\n", f.name)
        files.atm_src:add_subcontent("disable_domain_block", "\n", f.name)

        files.atm_hdr:add_subcontent("typedef_block", "", f)
        files.atm_hdr:add_subcontent("api_tbl_block", "", f.name)

        files.if_src:add_subcontent("func_blk", "", f, names_param_str)

        files.if_hdr:add_subcontent("func_proto_block", "\n", f)
        files.if_hdr:add_subcontent("api_data_t_block", "\n", f.return_type, f.name, table.concat(api_data_t_lines,"\n"))
        files.if_hdr:add_subcontent("api_id_enum_block", "\n", f.name)
        files.if_hdr:add_subcontent("get_funame_block", "\n", f.name)
        files.if_hdr:add_subcontent("get_funid_block", "\n", f.name)

        files.cb_hdr:add_subcontent("cb_get_args_block", "\n", f.return_type, f.name, table.concat(cb_get_args_lines,"\n"))
    
        if f.gen == "AUTOGEN" then
            files.f_auto:add_subcontent("func_blk", "", f, names_param_str)
        else
            files.f_man:add_subcontent("func_blk", "", f, names_param_str)
        end
    end
    
    files.atm_src:generate_file(includes_str, handler)
    files.atm_hdr:generate_file(includes_str)
    files.if_src:generate_file(includes_str)
    files.if_hdr:generate_file(includes_str)
    files.cb_src:generate_file()
    files.cb_hdr:generate_file(includes_str)
    files.f_auto:generate_file(includes_str)
    if files.f_man.subcontents.func_blk then
        common.mkdir(S._MANGEN_DOMAIN_DIR)
        files.f_man:generate_file(includes_str)
    end
end

local function generate_common_contents(config_data)
    local domain_list = common.scandir(S._AUTOGENDIR_PATH)
    for _, domain in ipairs(domain_list) do
        domain = domain:sub(1, -#("_"..S._TOOLS_NAME)-1)
        local interceptor_data = config_data[domain]
        S._CURRENT_DOMAIN = domain
        files.env_src:add_subcontent("set_enabled_block", "\n")
        files.env_hdr:add_subcontent("set_enabled_block", "\n")
        files.i_src:add_subcontent("load_block", "\n")
        files.i_src:add_subcontent("enable_case_block", "\n")
        files.i_src:add_subcontent("disable_case_block", "\n")
        files.i_hdr:add_subcontent("domain_name_block", "\n")
        files.i_hdr:add_subcontent("include_block", "\n")
        files.i_hdr:add_subcontent("enum_block", ",\n")

        if no_sample == false then
            files.tools:add_subcontent("subcontent", "\n")
            files.tools:add_subcontent("callback_block", "\n")
            files.mkf:add_subcontent("include_flag", " ", interceptor_data.include_path)
            files.mkf:add_subcontent("compile_flag", " ", interceptor_data.compile_flag)
            files.script:add_subcontent("case_opt", "\n")
            files.script:add_subcontent("init_opt_block", "\n")
            files.script:add_subcontent("enabled_block", "\n")
            files.script:add_subcontent("help_block", "\n")
        end
    end
    
    files.env_src:generate_file()
    files.env_hdr:generate_file()
    files.i_src:generate_file()
    files.i_hdr:generate_file()
    files.hm_src:generate_file()
    files.hm_hdr:generate_file()
    files.log_src:generate_file()
    files.log_hdr:generate_file()
    if no_sample == false then
        files.tools:generate_file()
        files.mkf:generate_file()
        files.script:generate_file()
        os.execute("chmod u+x "..S._SCRIPT_PATH)
    end
end

function parse_function_csv(filename)
    local functions = {}
    -- Read the CSV file
    for line in io.lines(filename) do
        local parts = {}
        for part in line:gmatch("[^;]+") do
            table.insert(parts, part)
        end
        -- Construct function table
        local func = {
            gen = parts[1],
            return_type = parts[2],
            name = parts[3],
            args = {}
        }
        -- Extract arguments
        for i = 4, #parts do
            table.insert(func.args, parts[i]) 
        end
        table.insert(functions, func)
    end
    return functions
end

-- COMMAND --
function gilda_gen.command(config_data, domain_list)
    no_sample = false
    if common.file_exists(S._GENDIR) then
        no_sample = true
    end
    common.mkdir(S._COREDIR_PATH)
    common.mkdir(S._UTILSDIR_PATH)
    common.mkdir(S._TOOLSDIR_PATH)

    for _, domain in ipairs(domain_list) do
        local interceptor_data = config_data[domain]
        if interceptor_data == nil then
            print("Warning: Skipping "..domain..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..domain..", config file not complete")
        else
            local function_to_intercept = parse_function_csv(interceptor_data.input_csv)
            S._CURRENT_DOMAIN = domain
            common.mkdir(S._AUTOGEN_DOMAIN_DIR)
            generate_domain_contents(interceptor_data, function_to_intercept)
        end                  
    end
    generate_common_contents(config_data)
end

return gilda_gen
