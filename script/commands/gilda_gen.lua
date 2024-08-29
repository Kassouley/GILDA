local common = require("common")
local parser = require("parser")
local c_manager = require("c_manager")

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

-- Processes files based on function data and generates subcontent.
-- @param contents A table of content objects.
-- @param domain_data The data for the current domain.
-- @param data_csv A table of parsed CSV data.
local function process_files(contents, domain_data, data_csv)
    for _, f in ipairs(data_csv.function_csv) do
        local param = {}
        local cparam = {}

        for i = 1, #f.pname do
            local i_param = c_manager.concat_param(f.ptype[i], f.pname[i])
            table.insert(param, i_param)
            table.insert(cparam, c_manager.get_real_cparam(f.ptype[i], f.pname[i], data_csv))
        end
        local concat_param = table.concat(param, ", ")

        for _, content in pairs(contents) do
            for _, file in pairs(content) do
                if file.generate_subcontents then
                    file:generate_subcontents(f, concat_param, cparam)
                end
            end
        end
    end
end

-- Sets up domain-specific contents and manages generation based on options.
-- @param content_domain A table of domain-specific content objects.
-- @param gilda_data Data specific to the current domain.
-- @param data_csv A table of parsed CSV data.
-- @param options Options controlling the generation process.
local function set_domain_contents(content_domain, gilda_data, data_csv, options)
    if not options.gen_options.no_mangen and has_mangen(data_csv.function_csv) then
        common.mkdir(S._MANGEN_DOMAIN_DIR)
        content_domain.f.man:set_do_gen(true)
    else
        content_domain.f.man:set_do_gen(false)
    end

    if options.gen_options.plugin then
        content_domain.dplg.src:set_do_gen(true)
        content_domain.dplg.hdr:set_do_gen(true)
        common.mkdir(S._PLUGDIR_PATH)
    end

    process_files(content_domain, gilda_data, data_csv)
end

-- Sets up common contents and processes them based on options.
-- @param content_common A table of common content objects.
-- @param config_data Configuration data.
-- @param options Options controlling the generation process.
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
        domain = domain:sub(1, -#("_" .. S._TOOLS_NAME) - 1)
        S._CURRENT_DOMAIN = domain

        for _, content in pairs(content_common) do
            for _, file in pairs(content) do
                if file.generate_subcontents then
                    file:generate_subcontents()
                end
            end
        end
    end
end

-- Sets up other contents and processes them based on options.
-- @param content_other A table of other content objects.
-- @param config_data Configuration data.
-- @param options Options controlling the generation process.
local function set_other_contents(content_other, config_data, options)
    if options.gen_options.mkf then
        content_other.mk.f:set_do_gen(true)
    end
    if options.gen_options.script then
        content_other.script.f:set_do_gen(true)
    end

    for key, domain in pairs(config_data.domain_list) do
        S._CURRENT_DOMAIN = key
        for _, content in pairs(content_other) do
            for _, file in pairs(content) do
                if file.generate_subcontents then
                    file:generate_subcontents(domain)
                end
            end
        end
    end
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

-- Parses CSV data using the provided parser function.
-- @param data The raw CSV data.
-- @param parser_function The function to parse the CSV data.
-- @return The parsed data, or "N/A" if the input data is empty.
local function parse_csv(data, parser_function)
    return data == "" and "N/A" or parser_function(data)
end

--- Main command function for generating content and managing files.
-- This function processes configuration data, sets up content and files,
-- and generates content based on provided options.
-- @param config_data Configuration data for the content generation.
-- @param domains A list of domains to process.
-- @param options Options controlling the generation process.
function gilda_gen.command(config_data, domains, options)
    local domain_list = {}
    if #domains == 0 then
        domain_list = config_data.domain_list
    else
        for _, d in pairs(domains) do
            table.insert(domain_list, d)
        end
    end

    S = common.require_from_path(config_data.details.string).new()

    common.mkdir(S._COREDIR_PATH)
    common.mkdir(S._UTILSDIR_PATH)

    for domain_name, domain in pairs(domain_list) do
        local domain = domain

        local include_header_list = domain.includes

        if not domain then
            print("Warning: Skipping " .. domain_name .. ", doesn't exist in config file")
        elseif domain.function_csv == "" then
            print("Warning: Skipping " .. domain_name .. ", config file not complete")
        else
            local data_csv = {
                function_csv = parse_csv(domain.function_csv, parser.parse_function_csv),
                typedef_csv = parse_csv(domain.typedef_csv, parser.parse_typedef_csv),
                struct_csv = parse_csv(domain.struct_csv, parser.parse_struct_csv),
            }
            S._CURRENT_DOMAIN = domain_name
            S._HANDLE = domain.lib == "" and "RTLD_NEXT" or "handle"
            common.mkdir(S._AUTOGEN_DOMAIN_DIR)
            local content_domain = init_content(config_data.details.domain_content)
            set_domain_contents(content_domain, domain, data_csv, options)
            local data = {
                include = get_include_str(include_header_list),
                handle = domain.lib
            }
            generate_files(content_domain, data)
        end                  
    end

    local content_common = init_content(config_data.details.common_content)
    set_common_contents(content_common, config_data, options)
    generate_files(content_common)

    local content_other = init_content(config_data.details.other)
    set_other_contents(content_other, config_data, options)
    generate_files(content_other, config_data)
    
    if options.gen_options.script then
        os.execute("chmod u+x " .. S._SCRIPT_PATH)
    end
end

return gilda_gen
