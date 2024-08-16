local common = require("common")
local parser = require("parser")
local c_manager = require("c_manager")
local ContentManager = require("ContentManager")
local string_content = require("string_content")

local function init_content(details)
    local contents = {}
    for key , content in pairs(details) do
        contents[key] = ContentManager:new(content.path, content.do_gen)
    end
    return contents
end

local content_common
local content_domain

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


local function add_includes_and_handlers(gilda_data)
    local includes_str = get_include_str(gilda_data.includes)
    local handler = gilda_data.lib
    content_domain.atm.src:add_single_subcontent("include", includes_str)
    content_domain.atm.src:add_single_subcontent("handler", handler)
    content_domain.atm.hdr:add_single_subcontent("include", includes_str)
    content_domain.atm.hdr:add_single_subcontent("handler", handler)
    content_domain.cb.hdr:add_single_subcontent("include", includes_str)
    content_domain.ifl.src:add_single_subcontent("include", includes_str)
    content_domain.ifl.hdr:add_single_subcontent("include", includes_str)
    content_domain.f.auto:add_single_subcontent("include", includes_str)
    content_domain.f.man:add_single_subcontent("include", includes_str)
end

local function set_domain_contents(gilda_data, data_csv, options)
    if has_mangen(data_csv.function_csv) then
        common.mkdir(S._MANGEN_DOMAIN_DIR)
        content_domain.f.man:set_do_generate(true)
    else
        content_domain.f.man:set_do_generate(false)
    end
    if options.gen_options.plugin then
        content_domain.dplg.src:set_do_generate(true)
        content_domain.dplg.hdr:set_do_generate(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    for _, file in pairs(content_domain) do
        for _, f in pairs(file) do
            f:reset_subcontent()
        end
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
        local cparam = {}
        for i = 1, #pname do
            local i_ptype = ptype[i]
            local i_pname = pname[i]
            local i_param = c_manager.concat_param(i_ptype, i_pname)
            table.insert(param, i_param)
            table.insert(api_data_t_lines, content_domain.ifl.hdr.getter.api_data_t_line(i_param))
            table.insert(cb_get_args_lines, content_domain.cb.hdr.getter.cb_get_args_line(fname, i_ptype, i_pname))
            table.insert(cparam, c_manager.get_real_cparam(i_ptype, i_pname, data_csv))
        end
        local concat_pname = table.concat(pname, ", ")
        local concat_param = table.concat(param, ", ")

        content_domain.atm.src:add_subcontent("load_table_block", "\n", fname)
        content_domain.atm.src:add_subcontent("enable_domain_block", "\n", fname)
        content_domain.atm.src:add_subcontent("disable_domain_block", "\n", fname)

        content_domain.atm.hdr:add_subcontent("typedef_block", "", ftype, fname, concat_param)
        content_domain.atm.hdr:add_subcontent("api_tbl_block", "", fname)

        content_domain.ifl.src:add_subcontent("func_blk", "", ftype, fname, concat_pname, concat_param)

        content_domain.ifl.hdr:add_subcontent("func_proto_block", "\n", ftype, fname, concat_param)
        content_domain.ifl.hdr:add_subcontent("api_data_t_block", "\n", ftype, fname, table.concat(api_data_t_lines,"\n"))
        content_domain.ifl.hdr:add_subcontent("api_id_enum_block", "\n", fname)
        content_domain.ifl.hdr:add_subcontent("get_funame_block", "\n", fname)
        content_domain.ifl.hdr:add_subcontent("get_funid_block", "\n", fname)

        content_domain.cb.hdr:add_subcontent("cb_get_args_block", "\n", ftype, fname, table.concat(cb_get_args_lines,"\n"))
        
        content_domain.dplg.src:add_subcontent("case_block", "\n", fname)
        content_domain.dplg.hdr:add_subcontent("prcss_args_blk", "\n", fname, cparam)
    
        if f.gen == "AUTOGEN" then
            content_domain.f.auto:add_subcontent("func_blk", "", ftype, fname, concat_pname, concat_param)
        else
            content_domain.f.man:add_subcontent("func_blk", "", ftype, fname, concat_pname, concat_param)
        end
    end
end

local function set_common_contents(config_data, options)
    if options.gen_options.mkf then
        content_common.mk.f:set_do_generate(true)
    end
    if options.gen_options.script then
        content_common.script.f:set_do_generate(true)
    end
    if options.gen_options.tools then
        content_common.tools.src:set_do_generate(true)
        common.mkdir(S._TOOLSDIR_PATH)
    end
    if options.gen_options.plugin then
        content_common.plg.src:set_do_generate(true)
        content_common.plg.hdr:set_do_generate(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    local domain_list = common.scandir(S._AUTOGENDIR_PATH)
    for _, domain in ipairs(domain_list) do
        domain = domain:sub(1, -#("_"..S._TOOLS_NAME)-1)
        local gilda_data = config_data[domain]
        S._CURRENT_DOMAIN = domain
        content_common.env.src:add_subcontent("set_enabled_block", "\n")
        content_common.env.hdr:add_subcontent("set_enabled_block", "\n")
        content_common.i.src:add_subcontent("load_block", "\n")
        content_common.i.src:add_subcontent("enable_case_block", "\n")
        content_common.i.src:add_subcontent("disable_case_block", "\n")
        content_common.i.hdr:add_subcontent("domain_name_block", "\n")
        content_common.i.hdr:add_subcontent("include_block", "\n")
        content_common.i.hdr:add_subcontent("enum_block", ",\n")
        content_common.tools.src:add_subcontent("subcontent", "\n")
        content_common.plg.src:add_subcontent("callback_block", "\n")
        content_common.plg.hdr:add_subcontent("include_block", "\n")
        content_common.plg.hdr:add_subcontent("proto_block", "\n")
        content_common.mk.f:add_subcontent("include_flag", " ", gilda_data.include_path)
        content_common.mk.f:add_subcontent("compile_flag", " ", gilda_data.compile_flag)
        content_common.script.f:add_subcontent("case_opt", "\n")
        content_common.script.f:add_subcontent("init_opt_block", "\n")
        content_common.script.f:add_subcontent("enabled_block", "\n")
        content_common.script.f:add_subcontent("help_block", "\n")
    end
end


local function generate_files(files)
    for _, file in pairs(files) do
        for _, f in pairs(file) do
            f:generate_file()
        end
    end
end

-- COMMAND --
function gilda_gen.command(config_data, domain_list, options)
    S = string_content.new()
    common.mkdir(S._COREDIR_PATH)
    common.mkdir(S._UTILSDIR_PATH)

    content_common = init_content(config_data.details.common_content)
    content_domain = init_content(config_data.details.domain_content)

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
            generate_files(content_domain)
        end                  
    end

    set_common_contents(config_data, options)
    generate_files(content_common)
end

return gilda_gen
