local io_interceptor = require("io_interceptor")
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

local function get_include_str(includes_table)
    return "\n#include \""..table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

-- COMMON --

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
            local type_param, name_param = io_interceptor.parse_variable_declaration(arg)
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
        io_interceptor.mkdir(S:_MANGEN_DOMAIN_DIR())
        files.f_man:generate_file(includes_str)
    end
end

local function generate_common_contents(config_data)
    local domain_list = scandir(S:_AUTOGENDIR_PATH())
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
        files.tools:add_subcontent("subcontent", "\n")
        files.tools:add_subcontent("callback_block", "\n")
        files.mkf:add_subcontent("include_flag", " ", interceptor_data.include_path)
        files.mkf:add_subcontent("compile_flag", " ", interceptor_data.compile_flag)
        files.script:add_subcontent("case_opt", "\n")
        files.script:add_subcontent("init_opt_block", "\n")
        files.script:add_subcontent("enabled_block", "\n")
        files.script:add_subcontent("help_block", "\n")
    end
    
    files.env_src:generate_file()
    files.env_hdr:generate_file()
    files.i_src:generate_file()
    files.i_hdr:generate_file()
    files.hm_src:generate_file()
    files.hm_hdr:generate_file()
    files.log_src:generate_file()
    files.log_hdr:generate_file()
    files.tools:generate_file()
    files.mkf:generate_file()
    files.script:generate_file()
    os.execute("chmod u+x "..S._SCRIPT_PATH)
end

-- COMMAND --
function interceptor_generate.command(config_data, domain_list)
    io_interceptor.mkdir(S:_COREDIR_PATH())
    io_interceptor.mkdir(S:_UTILSDIR_PATH())
    io_interceptor.mkdir(S:_TOOLSDIR_PATH())

    for _, domain in ipairs(domain_list) do
        local interceptor_data = config_data[domain]
        if interceptor_data == nil then
            print("Warning: Skipping "..domain..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..domain..", config file not complete")
        else
            local function_to_intercept = io_interceptor.parseCSV(interceptor_data.input_csv)
            S._CURRENT_DOMAIN = domain
            io_interceptor.mkdir(S:_AUTOGEN_DOMAIN_DIR())
            generate_domain_contents(interceptor_data, function_to_intercept)
        end                  
    end
    generate_common_contents(config_data)
end

return interceptor_generate
