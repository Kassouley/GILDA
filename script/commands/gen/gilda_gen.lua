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

local lfs = require("lfs")
local StringManager = require("StringManager")
local Script = require("Script")

Content = require("Content")
common = require("common")
CurrentFile = "Unknown"

local function replace_string_holder(str)
    local content = str:gsub("%$%$([%s%S]-)%$%$", function(match)
        -- Check if match contains '@'
        local func, args = match:match("([^@]+)@([%s%S]+)")
        if func then
            -- If function exists in S, call S[func](args)
            if S[func] then 
                return S[func](S, args)
            else
                error("Function '" .. func .. "' not found in StringManager or string ini file.")
            end
        else
            -- Otherwise, call S:STRING(match)
            return S:STRING(match)
        end
    end)
    return content
end


local function is_domain_file(filename)
    return filename:match("%$%$DOMAIN@.-%$%$") ~= nil
end

local function get_domain_filename(dir, filename)
    return lfs.concat_path(dir, replace_string_holder(filename))
end

local function write_content(input, output)
    local new_dir, _ = lfs.split_path(output)
    lfs.mkdir(new_dir)
    local file = lfs.open_file(input, "r")
    local content = file:read("*all")
    file:close()
    file = lfs.open_file(output, "w")
    file:write(replace_string_holder(content))
    file:close()
    print("Success: '"..output.."' has been generated.")
end


local function generate(config_data)
    local template_path = lfs.get_cleaned_path(config_data.details.template_path)
    local output_dir = lfs.get_cleaned_path(config_data.details.output_dir)
    local files_list = lfs.scanfile(template_path, "f")

    for _, filename in pairs(files_list) do
        if lfs.is_file(filename) then
            CurrentFile = filename
            local relative_path = string.gsub(filename, template_path, "")
            if is_domain_file(relative_path) then
                for domain_name, domain in pairs(config_data.domain_list) do
                    S:set_domain(domain, domain_name)

                    local absolute_path = get_domain_filename(output_dir, relative_path)
                    write_content(filename, absolute_path)
                end
            else
                local absolute_path = get_domain_filename(output_dir, relative_path)
                write_content(filename, absolute_path)
            end
        end
    end
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
    S = StringManager.new(config_data)
    generate(config_data)
end


local function force_cpy_cb(script, _) script.options_values.force_copy = true end
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

script:add_option("force-copy", "c", nil, 
[[                  
                        Force the copy of non-lua content script even if they already exist]], 
                        false, force_cpy_cb)

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
