local script_dir = debug.getinfo(1, "S").source:match("@(.*[\\/]?.*)") or ""
script_dir = script_dir:gsub('\\', '/'):match("(.*[\\/])") or ""
local paths = {
    './',
    '../../',
    '../../Class/',
    '../../utils/',
    '../../utils/json/',
    '../../utils/Lua_INI_Parser/',
}

for _, path in ipairs(paths) do
    package.path = package.path .. ';' .. script_dir .. path .. '?.lua'
end

local common = require("common")
local lfs = require("lfs")
local parser = require("parser")
local StringManager = require("StringManager")
local Script = require("Script")


-- Creates a string for include directives from a table of include paths.
-- @param includes_table A table of include paths.
-- @return A string of include directives formatted for C.
local function get_include_str(includes_table)
    return "\n#include \"" .. table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

local function generate_domain_contents(script_table, data_csv, template_path, output_path, options)
    for _, script_class in pairs(script_table) do
        local script = script_class:new(options.gen_options, template_path, output_path)
        if script then
            for _, f in ipairs(data_csv.function_csv) do
                script:generate_subcontents(f)
            end
            script:generate_file()
        end
    end
end

local function generate_common_contents(script_table, domain_list, template_path, output_path, options)
    for _, script_class in pairs(script_table) do
        local script = script_class:new(options.gen_options, template_path, output_path)
        if script then
            for domain_name, domain in pairs(domain_list) do
                S:set_current_domain(domain_name)
                S:set_handle(domain.lib == "" and "RTLD_NEXT" or "handle")
                S:set_handle_path(domain.lib)
                S:set_include_str(get_include_str(domain.includes))
                script:generate_subcontents()
            end
            script:generate_file()
        end
    end
end


local function get_script_content(config_data)
    local script = {
        common = {},
        domain = {}
    }
    local template_path = lfs.get_cleaned_path(config_data.details.template_path)
    local output_dir = lfs.get_cleaned_path(config_data.details.output_dir)
    local files_list = lfs.scanfile(template_path, "f")
    for _, file in pairs(files_list) do
        if lfs.is_file(file) then
            if lfs.has_extension(file, ".lua") then
                local script_class, script_type = lfs.require_from_path(file)
                if script_type == "COMMON" then
                    table.insert(script.common, script_class)
                elseif script_type == "DOMAIN" then
                    table.insert(script.domain, script_class)
                else
                    error("Script type invalid for "..file)
                end
            else
                local tmp = string.gsub(file, template_path, "")
                local output_path = lfs.concat_path(output_dir, tmp)
                local new_dir, basename = lfs.split_path(output_path)
                if lfs.file_exists(output_path) then
                    print("Warning: No copy for '"..output_path.."', file already exists.")
                else
                    lfs.mkdir(new_dir)
                    lfs.copy_file(file, output_path)
                    print("Success: '"..output_path.."' has been copied.")
                end
            end
        end
    end
    return script
end


--- Main command function for generating content and managing files.
-- This function processes configuration data, sets up content and files,
-- and generates content based on provided options.
-- @param config_data Configuration data for the content generation.
-- @param domains A list of domains to process.
-- @param options Options controlling the generation process.
local function proccess_gen(arguments_values, options_values)
    local config_file = arguments_values[1]
    -- If no config file is specified, use 'config.json' in PWD
    if not config_file or not lfs.file_exists(config_file) then
        config_file = "config.json"
        if not lfs.file_exists(config_file) then
            print("Error: config file not found.")
            return
        end
    end
    local config_data = common.load_json(config_file)
    local domain_list = config_data.domain_list
    local template_path = lfs.get_cleaned_path(config_data.details.template_path)
    local output_dir = lfs.get_cleaned_path(config_data.details.output_dir)
    S = StringManager.new(config_data.details.string)
    
    local script = get_script_content(config_data)

    for domain_name, domain in pairs(domain_list) do
        if not domain then
            print("Warning: Skipping " .. domain_name .. ", doesn't exist in config file")
        elseif domain.function_csv == "" then
            print("Warning: Skipping " .. domain_name .. ", config file not complete")
        else
            local data_csv = parser.parse_interception_csv({
                function_csv = domain.function_csv,
                typedef_csv = domain.typedef_csv,
                struct_csv = domain.struct_csv
            })
            
            S:set_current_domain(domain_name)
            S:set_handle(domain.lib == "" and "RTLD_NEXT" or "handle")
            S:set_handle_path(domain.lib)
            S:set_include_str(get_include_str(domain.includes))
            generate_domain_contents(script.domain, data_csv, template_path, output_dir, options_values)
        end
    end
    generate_common_contents(script.common, domain_list, template_path, output_dir, options_values)
    
end


local function mangen_gen_cb(script, _) script.options_values.gen_options.force_mangen = true end
local function script_gen_cb(script, _) script.options_values.gen_options.force_script_gen = true end
local function tool_gen_cb(script, _) script.options_values.gen_options.force_tool_gen = true end
local function no_mangen_cb(script, _) script.options_values.gen_options.no_mangen = true end
local function plugin_gen_cb(script, value) 
    if value and value ~= "" then
        script.options_values.gen_options.plugin_gen = value:split(",")
    elseif value and value == "" then
        script.options_values.gen_options.plugin_gen = "all"
    end
end
local function all_cb(script, _) 
    mangen_gen_cb(script, _)
    script_gen_cb(script, _)
    tool_gen_cb(script, _)
    plugin_gen_cb(script, "all")
end

-- Main script logic
local attribute = {
    name = "gilda gen",
    version = "1.0",
    default_options_values = {
        gen_options = {
            force_mangen = false,
            force_script_gen = false,
            force_tool_gen = false,
            plugin_gen = false,
            no_mangen = false
        }
    }
}
local script = Script:new(attribute)

script:set_desc([[Generate source code, build scripts, and run scripts for an LD_PRELOAD C library.]])

script:set_execute_function(proccess_gen)

script:add_argument("config_file", true, false, "Specify the config file that contains data about the generation.")

script:add_option("force-tool-gen", "t", nil, 
[[                  
                        Generate main intercept tool based on template LUA content script]], 
                        false, tool_gen_cb)

script:add_option("force-script-gen", "s", nil, 
[[                  
                        Generate a default bash "run" script based on template LUA content script]], 
                        false, script_gen_cb)
                        
script:add_option("plugin-gen", "p", "<plugin-name | all>", 
[[                  
                        Generate all plugin code based on the template LUA content scripts]], 
                        false, plugin_gen_cb)

script:add_option("force-mangen", "s", nil, 
[[                  
                        Generate all files that contains MANGEN function]], 
                        false, mangen_gen_cb)
                        
script:add_option("no-mangen", nil, nil, 
[[                  
                        Do not generate the manual category of domain interception]], 
                        false, no_mangen_cb)
                        
script:add_option("all", "a", nil, 
[[                  
                        Generate all (plugins, script and tool)]], 
                        false, all_cb)

return script
