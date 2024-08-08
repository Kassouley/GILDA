local common = require("common")
local parser = require("parser")
local c_manager = require("c_manager")
local FileManager = require("FileManager")

local function init_file(details)
    local files = {}
    for _, file in ipairs(details) do
        files[file.key] = FileManager:new(file.path, file.name, file.default_gen)
    end
    return files
end

local domain_file_details = {
    {default_gen = true, key = "atm_src", path = "_ATM_SRC_PATH", name = "api_table_mgr_c"},
    {default_gen = true, key = "atm_hdr", path = "_ATM_HEAD_PATH", name = "api_table_mgr_h"},
    {default_gen = true, key = "if_src", path = "_IF_SRC_PATH", name = "intercepted_functions_c"},
    {default_gen = true, key = "if_hdr", path = "_IF_HEAD_PATH", name = "intercepted_functions_h"},
    {default_gen = true, key = "cb_src", path = "_CB_SRC_PATH", name = "callback_c"},
    {default_gen = true, key = "cb_hdr", path = "_CB_HEAD_PATH", name = "callback_h"},
    {default_gen = false, key = "f_man", path = "_F_MAN_SRC_PATH", name = "functions_c"},
    {default_gen = true, key = "f_auto", path = "_F_AUTO_SRC_PATH", name = "functions_c"},
    {default_gen = true, key = "plg_src", path = "_PLUG_SRC_PATH", name = "plugin_c"}
    -- {default_gen = true, key = "plg_hdr", path = "_PLUG_HEAD_PATH", name = "plugin_h"} -- TODO DIRECTORY PLUG WITH INDEPENDANT PLUG
}

local common_file_details = {
    {default_gen = true, key = "hm_src", path = "_HANDLER_MGR_SRC_PATH", name = "handler_manager_c"},
    {default_gen = true, key = "hm_hdr", path = "_HANDLER_MGR_HEAD_PATH", name = "handler_manager_h"},
    {default_gen = true, key = "i_src", path = "_INTERCEPTOR_SRC_PATH", name = "interceptor_c"},
    {default_gen = true, key = "i_hdr", path = "_INTERCEPTOR_HEAD_PATH", name = "interceptor_h"},
    {default_gen = true, key = "log_src", path = "_LOGGER_SRC_PATH", name = "logger_c"},
    {default_gen = true, key = "log_hdr", path = "_LOGGER_HEAD_PATH", name = "logger_h"},
    {default_gen = true, key = "env_src", path = "_ENV_SRC_PATH", name = "env_c"},
    {default_gen = true, key = "env_hdr", path = "_ENV_HEAD_PATH", name = "env_h"},
    {default_gen = true, key = "cid_src", path = "_CID_SRC_PATH", name = "cid_c"},
    {default_gen = true, key = "cid_hdr", path = "_CID_HEAD_PATH", name = "cid_h"},
    {default_gen = false, key = "tools", path = "_TOOL_SRC_PATH", name = "tools_c"},
    {default_gen = false, key = "mkf", path = "_MAKEFILE_PATH", name = "makefile"},
    {default_gen = false, key = "script", path = "_SCRIPT_PATH", name = "script_sh"}
}

local files_common = init_file(common_file_details)
local files_domain = init_file(domain_file_details)

local gilda_gen = {}


local function has_mangen(array)
    for _, f in ipairs(array) do
        if f.gen == "MANGEN" then
            return true
        end
    end
    return false
end

local function get_include_str(includes_table)
    return "\n#include \""..table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

local function get_c_param_content(ptype, pname, data)
    local decl, nb_ptr = c_manager.get_real_type(data, ptype)
    if type(decl) == 'table' then
        print(ptype .. " " .. pname)
        for _, pair in ipairs(decl) do
            get_c_param_content(pair.type, pair.name, data)
        end
    else
        return "test"
    end
end

local function add_includes_and_handlers(gilda_data)
    local includes_str = get_include_str(gilda_data.includes)
    local handler = gilda_data.lib
    files_domain.atm_src:add_single_subcontent("include", includes_str)
    files_domain.atm_src:add_single_subcontent("handler", handler)
    files_domain.atm_hdr:add_single_subcontent("include", includes_str)
    files_domain.atm_hdr:add_single_subcontent("handler", handler)
    files_domain.cb_hdr:add_single_subcontent("include", includes_str)
    files_domain.if_src:add_single_subcontent("include", includes_str)
    files_domain.if_hdr:add_single_subcontent("include", includes_str)
    files_domain.f_auto:add_single_subcontent("include", includes_str)
    files_domain.f_auto:add_single_subcontent("include", includes_str)
    files_domain.f_man:add_single_subcontent("include", includes_str)
end

local function concat_param(ptype, pname)
    local pos = ptype:find("%(%*%)")
    if pos then
        return ptype:sub(1, pos+1) .. pname .. ptype:sub(pos + 2)
    end
    local pos_array = ptype:find("%[%d*%]")
    if pos_array then
        local base_type = ptype:sub(1, pos_array - 1) 
        local array_size = ptype:sub(pos_array) 
        return base_type .. " " .. pname .. array_size
    end
    return ptype.." "..pname
end

local function set_domain_contents(gilda_data, data_csv, options)
    if has_mangen(data_csv.function_csv) then
        files_domain.f_man:set_do_generate(true)
    end

    for _, f in pairs(files_domain) do
        f:reset_subcontent()
    end
    
    add_includes_and_handlers(gilda_data)

    for _, f in ipairs(data_csv.function_csv) do
        local names_param = {}
        local types_param = {}
        local api_data_t_lines = {}
        local cb_get_args_lines = {}
        local param = {}
        
        local fname = f.fname
        local ftype = f.ftype
        local pname = f.pname
        local ptype = f.ptype
        for i = 1, #pname do
            local i_ptype = ptype[i]
            local i_pname = pname[i]
            local i_param = concat_param(i_ptype, i_pname)
            table.insert(param, i_param)
            table.insert(api_data_t_lines, files_domain.if_hdr.getter.api_data_t_line(i_param))
            table.insert(cb_get_args_lines, files_domain.cb_hdr.getter.cb_get_args_line(fname, i_ptype, i_pname))
            -- get_c_param_content(i_ptype, i_pname, data_csv)
        end
        local concat_pname = table.concat(pname, ", ")
        local concat_param = table.concat(param, ", ")

        files_domain.atm_src:add_subcontent("load_table_block", "\n", fname)
        files_domain.atm_src:add_subcontent("enable_domain_block", "\n", fname)
        files_domain.atm_src:add_subcontent("disable_domain_block", "\n", fname)

        files_domain.atm_hdr:add_subcontent("typedef_block", "", ftype, fname, concat_param)
        files_domain.atm_hdr:add_subcontent("api_tbl_block", "", fname)

        files_domain.if_src:add_subcontent("func_blk", "", ftype, fname, concat_pname, concat_param)

        files_domain.if_hdr:add_subcontent("func_proto_block", "\n", ftype, fname, concat_param)
        files_domain.if_hdr:add_subcontent("api_data_t_block", "\n", ftype, fname, table.concat(api_data_t_lines,"\n"))
        files_domain.if_hdr:add_subcontent("api_id_enum_block", "\n", fname)
        files_domain.if_hdr:add_subcontent("get_funame_block", "\n", fname)
        files_domain.if_hdr:add_subcontent("get_funid_block", "\n", fname)

        files_domain.cb_hdr:add_subcontent("cb_get_args_block", "\n", ftype, fname, table.concat(cb_get_args_lines,"\n"))
    
        if f.gen == "AUTOGEN" then
            files_domain.f_auto:add_subcontent("func_blk", "", ftype, fname, concat_pname, concat_param)
        else
            files_domain.f_man:add_subcontent("func_blk", "", ftype, fname, concat_pname, concat_param)
        end
    end
end

local function set_common_contents(config_data, options)
    if options.gen_options.mkf then
        files_common.mkf:set_do_generate(true)
    end
    if options.gen_options.script then
        files_common.script:set_do_generate(true)
    end
    if options.gen_options.tools then
        files_common.tools:set_do_generate(true)
        common.mkdir(S._TOOLSDIR_PATH)
    end

    local domain_list = common.scandir(S._AUTOGENDIR_PATH)
    for _, domain in ipairs(domain_list) do
        domain = domain:sub(1, -#("_"..S._TOOLS_NAME)-1)
        local gilda_data = config_data[domain]
        S._CURRENT_DOMAIN = domain
        files_common.env_src:add_subcontent("set_enabled_block", "\n")
        files_common.env_hdr:add_subcontent("set_enabled_block", "\n")
        files_common.i_src:add_subcontent("load_block", "\n")
        files_common.i_src:add_subcontent("enable_case_block", "\n")
        files_common.i_src:add_subcontent("disable_case_block", "\n")
        files_common.i_hdr:add_subcontent("domain_name_block", "\n")
        files_common.i_hdr:add_subcontent("include_block", "\n")
        files_common.i_hdr:add_subcontent("enum_block", ",\n")
        files_common.tools:add_subcontent("subcontent", "\n")
        files_common.tools:add_subcontent("callback_block", "\n")
        files_common.mkf:add_subcontent("include_flag", " ", gilda_data.include_path)
        files_common.mkf:add_subcontent("compile_flag", " ", gilda_data.compile_flag)
        files_common.script:add_subcontent("case_opt", "\n")
        files_common.script:add_subcontent("init_opt_block", "\n")
        files_common.script:add_subcontent("enabled_block", "\n")
        files_common.script:add_subcontent("help_block", "\n")
    end
end


local function generate_domain_files()
    for _, f in pairs(files_domain) do
        f:generate_file()
    end
end

local function generate_common_files()
    for _, f in pairs(files_common) do
        f:generate_file()
    end
end

-- COMMAND --
function gilda_gen.command(config_data, domain_list, options)
    common.mkdir(S._COREDIR_PATH)
    common.mkdir(S._UTILSDIR_PATH)
    for _, domain in ipairs(domain_list) do
        local gilda_data = config_data[domain]
        if gilda_data == nil then
            print("Warning: Skipping "..domain..", doesn't exist in config file")
        elseif gilda_data.input_csv == "" or gilda_data.lib == "" then
            print("Warning: Skipping "..domain..", config file not complete")
        else
            local data_csv = {
                function_csv = parser.parse_function_csv(gilda_data.function_csv),
                typedef_csv = parser.parse_typedef_csv(gilda_data.typedef_csv),
                struct_csv = parser.parse_struct_csv(gilda_data.struct_csv)
            }
            S._CURRENT_DOMAIN = domain
            common.mkdir(S._AUTOGEN_DOMAIN_DIR)
            set_domain_contents(gilda_data, data_csv, options)
            generate_domain_files()
        end                  
    end

    set_common_contents(config_data, options)
    generate_common_files()
end

return gilda_gen
