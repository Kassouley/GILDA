local script_dir = debug.getinfo(1, "S").source:match("@(.*[\\/]?.*)") or ""
script_dir = script_dir:gsub('\\', '/'):match("(.*[\\/])") or ""
local paths = {
    '',
    'script/',
    'script/commands/',
    'script/contents/',
    'script/json/'
}

for _, path in ipairs(paths) do
    package.path = package.path .. ';' .. script_dir .. path .. '?.lua'
end

local common = require("common")

-- Function to parse command-line arguments
local function parse_options(args)
    local options = { force = false, all = false, sub_target = {}, gen_options = {}, output_dir = "csv/" }
    local i = 1
    while i <= #args do
        local arg = args[i]
        if arg == '-f' or arg == '--force' then
            options.force = true
        elseif arg == '-a' or arg == '--all' then
            options.all = true
        elseif arg == '--all-gen' then
            options.gen_options["script"] = true
            options.gen_options["plugin"] = true
            options.gen_options["mkf"] = true
            options.gen_options["tools"] = true
        elseif arg == '--tool-gen' then
            options.gen_options["tools"] = true
        elseif arg == '--script-gen' then
            options.gen_options["script"] = true
        elseif arg == '--make-gen' then
            options.gen_options["mkf"] = true
        elseif arg == '--plugin-gen' then
            options.gen_options["plugin"] = true
        elseif arg == '--plugin-gen' then
            options.gen_options["plugin"] = true
        elseif arg == '--config-gen' then
            options.gen_options["config"] = true
        elseif arg == '--no-mangen' then
            options.gen_options["no_mangen"] = true
        elseif arg == '-o' or arg == '--output-dir' then
            i = i + 1
            options.output_dir = args[i] or "csv/"
        else
            -- Process non-option arguments
            if i == 1 then
                options.command = arg
            elseif i == 2 then
                options.target = arg
            else
                table.insert(options.sub_target, arg)
            end
        end
        i = i + 1
    end
    return options
end

-- Main function
function main()
    local options = parse_options(arg)

    if not options.command then
        print("Usage: lua "..arg[0].." [gen <config file> | clean <directory> | parse <domain> <header_file1> [<header_file2> ...]] [options]")
        return
    end

    local command = options.command
    local target = options.target
    local sub_target = options.sub_target or {}

    if command == "gen" then
        local config_file = target
        -- If no config file is specified, use 'config.json' in PWD
        if not config_file or not common.file_exists(config_file) then
            config_file = "config.json"
            if not common.file_exists(config_file) then
                print("Error: config file not found.")
                return
            end
        end
        local config_data = common.load_json(config_file)
        local gilda_gen = require("gilda_gen")

        if #sub_target == 0 then
            for key, value in pairs(config_data) do
                if type(value) == 'table' and key ~= "details" then
                    table.insert(sub_target, key)
                end
            end
        end
        gilda_gen.command(config_data, sub_target, options)

    elseif command == "clean" then
        local gilda_clean = require("gilda_clean")
        -- For 'clean' command, the target is expected to be a directory
        local directory = target
        gilda_clean.command(directory, sub_target, options)

    elseif command == "parse" then
        local gilda_parse = require("gilda_parse")
        -- For 'parse' command, the target is expected to be a domain and a list of header files
        local domain = target
        local header_files = sub_target
        local output_dir = options.output_dir
        gilda_parse.command(domain, header_files, output_dir, options)

    else    
        print("Error: command "..command.." not available.")
        return
    end
end

-- Run the main function
main()
