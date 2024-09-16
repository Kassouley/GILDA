local common = require("common")
local parser = require("parser")

--- `gilda_gen` module for generating content and managing files based on configuration data.
-- This module provides functionality for processing configuration data, generating content,
-- and handling file operations in a specified format.
-- @module gilda_gen

local gilda_gen = {}

-- Initializes content from a set of file paths.
-- @param details A table where keys are content identifiers and values are file paths.
-- @return A table of content loaded from the specified file paths.
local function init_content(details)
    local contents = {}
    for key, file in pairs(details) do
        contents[key] = common.require_from_path(file)
    end
    return contents
end

-- Checks if any file in the array has a generation type of "MANGEN".
-- @param array A table of file objects to check.
-- @return A boolean indicating whether "MANGEN" type files are present.
local function has_mangen(array)
    for _, f in ipairs(array) do
        if f.gen == "MANGEN" then
            return true
        end
    end
    return false
end

-- Creates a string for include directives from a table of include paths.
-- @param includes_table A table of include paths.
-- @return A string of include directives formatted for C.
local function get_include_str(includes_table)
    return "\n#include \"" .. table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

-- Generates files based on provided data.
-- @param files A table of content objects to generate files for.
-- @param data Data to be used in file generation.
local function generate_files(files, data)
    for _, file in pairs(files) do
        for _, f in pairs(file) do
            f:generate_file(data)
        end
    end
end

-- Helper function to generate contents for a list of files.
-- @param content_table A table of content objects.
-- @param generate_data The data passed to the generate_subcontents function.
local function generate_subcontents(content_table, generate_data)
    for _, content in pairs(content_table) do
        for _, file in pairs(content) do
            if file.generate_subcontents then
                file:generate_subcontents(generate_data)
            end
        end
    end
end

-- Sets up domain-specific contents and manages generation based on options.
-- @param data_csv A table of parsed CSV data.
-- @param options Options controlling the generation process.
local function set_domain_contents(config_data, data_csv, options)
    local content_domain = init_content(config_data.details.domain_content)
    local gen_options = options.gen_options

    common.mkdir(S._AUTOGEN_DOMAIN_DIR)
    if not gen_options.no_mangen and has_mangen(data_csv.function_csv) then
        common.mkdir(S._MANGEN_DOMAIN_DIR)
        content_domain.f.man:set_do_gen(true)
    else
        content_domain.f.man:set_do_gen(false)
    end

    if gen_options.plugin then
        content_domain.dplg.src:set_do_gen(true)
        content_domain.dplg.hdr:set_do_gen(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    for _, f in ipairs(data_csv.function_csv) do
        generate_subcontents(content_domain, f)
    end
    generate_files(content_domain)
end

-- Sets up common contents and processes them based on options.
-- @param options Options controlling the generation process.
local function set_common_contents(config_data, options)
    local content_common = init_content(config_data.details.common_content)
    local gen_options = options.gen_options

    if content_common.tools and gen_options.tools then
        content_common.tools.src:set_do_gen(true)
        common.mkdir(S._TOOLSDIR_PATH)
    end

    if content_common.plg and gen_options.plugin then
        content_common.plg.src:set_do_gen(true)
        content_common.plg.hdr:set_do_gen(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    if gen_options.script then
        content_common.sh.f:set_do_gen(true)
    end

    local domain_list = common.scandir(S._AUTOGENDIR_PATH)
    for _, domain in ipairs(domain_list) do
        S._CURRENT_DOMAIN = domain:sub(1, -#("_" .. S._TOOLS_NAME) - 1)
        generate_subcontents(content_common)
    end
    generate_files(content_common)

    if options.gen_options.script then
        os.execute("chmod u+x " .. S._SCRIPT_PATH)
    end
end

-- Sets up other contents and processes them based on options.
-- @param config_data Configuration data.
-- @param options Options controlling the generation process.
local function set_other_contents(config_data, options)
    local content_other = init_content(config_data.details.other)

    if options.gen_options.mkf then
        content_other.mk.f:set_do_gen(true)
    end

    generate_files(content_other, config_data)
end


--- Main command function for generating content and managing files.
-- This function processes configuration data, sets up content and files,
-- and generates content based on provided options.
-- @param config_data Configuration data for the content generation.
-- @param domains A list of domains to process.
-- @param options Options controlling the generation process.
function gilda_gen.command(config_data, domains, options)
    local domain_list = (#domains == 0) and config_data.domain_list or domains
    S = common.require_from_path(config_data.details.string).new()

    common.mkdir(S._COREDIR_PATH)
    common.mkdir(S._UTILSDIR_PATH)

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
            S._CURRENT_DOMAIN = domain_name
            S._HANDLE = domain.lib == "" and "RTLD_NEXT" or "handle"
            S._HANDLE_PATH = domain.lib
            S._INCLUDE_STR = get_include_str(domain.includes)
            set_domain_contents(config_data, data_csv, options)
            
        end                  
    end
    set_common_contents(config_data, options)
    set_other_contents(config_data, options)
    
end

return gilda_gen
