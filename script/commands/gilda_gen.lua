local common = require("common")
local parser = require("parser")
local c_manager = require("c_manager")

local gilda_gen = {}

local function init_content(details)
    local contents = {}
    for key , file in pairs(details) do
        contents[key] = common.require_from_path(file)
    end
    return contents
end

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


local function set_domain_contents(content_domain, gilda_data, data_csv, options)
    if options.gen_options.no_mangen ~= true and has_mangen(data_csv.function_csv) then
        common.mkdir(S._MANGEN_DOMAIN_DIR)
        content_domain.f.man:set_do_gen(true)
    else
        content_domain.f.man:set_do_gen(false)
    end
    if content_domain.dplg ~= nil and ptions.gen_options.plugin then
        content_domain.dplg.src:set_do_gen(true)
        content_domain.dplg.hdr:set_do_gen(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    for _, f in ipairs(data_csv.function_csv) do
        local param = {}
        local cparam = {}

        for i = 1, #f.pname do
            local i_ptype = f.ptype[i]
            local i_pname = f.pname[i]
            local i_param = c_manager.concat_param(i_ptype, i_pname)
            table.insert(param, i_param)
            table.insert(cparam, c_manager.get_real_cparam(i_ptype, i_pname, data_csv))
        end
        local concat_param = table.concat(param, ", ")

        for _, content in pairs(content_domain) do
            for _, file in pairs(content) do
                if file.generate_subcontents ~= nil then
                    file:generate_subcontents(f, concat_param, cparam)
                end
            end
        end
    end
end

local function set_common_contents(content_common, config_data, options)
    if content_common.tools ~= nil and options.gen_options.tools then
        content_common.tools.src:set_do_gen(true)
        common.mkdir(S._TOOLSDIR_PATH)
    end
    if content_common.plg ~= nil and options.gen_options.plugin then
        content_common.plg.src:set_do_gen(true)
        content_common.plg.hdr:set_do_gen(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    local domain_list = common.scandir(S._AUTOGENDIR_PATH)
    for _, domain in ipairs(domain_list) do
        domain = domain:sub(1, -#("_"..S._TOOLS_NAME)-1)
        local gilda_data = config_data[domain]
        S._CURRENT_DOMAIN = domain

        for _, content in pairs(content_common) do
            for _, file in pairs(content) do
                if file.generate_subcontents ~= nil then
                    file:generate_subcontents()
                end
            end
        end
    end
end


local function set_other_contents(content_other, config_data, options)
    if options.gen_options.mkf then
        content_other.mk.f:set_do_gen(true)
    end
    if options.gen_options.script then
        content_other.script.f:set_do_gen(true)
    end

    for key, domain in pairs(config_data) do
        if key ~= "details" then
            S._CURRENT_DOMAIN = key
            for _, content in pairs(content_other) do
                for _, file in pairs(content) do
                    if file.generate_subcontents ~= nil then
                        file:generate_subcontents(domain)
                    end
                end
            end
        end
    end
    
    if options.gen_options.script then
        os.execute("chmod u+x "..S._SCRIPT_PATH)
    end
end

local function generate_files(files, data)
    for _, file in pairs(files) do
        for _, f in pairs(file) do
            f:generate_file(data)
        end
    end
end

-- COMMAND --
function gilda_gen.command(config_data, domain_list, options)
    S = common.require_from_path(config_data.details.string).new()

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
            local content_domain = init_content(config_data.details.domain_content)
            set_domain_contents(content_domain, gilda_data, data_csv, options)
	    local data = {
	    	include = get_include_str(gilda_data.includes),
		handle = gilda_data.lib == "" and "RTLD_NEXT" or "\""..gilda_data.lib.."\""
	    }
            generate_files(content_domain, data)
        end                  
    end

    local content_common = init_content(config_data.details.common_content)
    set_common_contents(content_common, config_data, options)
    generate_files(content_common)

    local content_other = init_content(config_data.details.other)
    set_other_contents(content_other, config_data, options)
    generate_files(content_other)

end

return gilda_gen
