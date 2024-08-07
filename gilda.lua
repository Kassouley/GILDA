local script_dir = debug.getinfo(1, "S").source:match("@(.*[\\/]?.*)") or ""
script_dir = script_dir:gsub('\\', '/')
script_dir = script_dir:match("(.*[\\/])") or ""

package.path = package.path .. ';' .. script_dir .. '/script/?.lua'
package.path = package.path .. ';' .. script_dir .. '/script/commands/?.lua'
package.path = package.path .. ';' .. script_dir .. '/script/contents/source/?.lua'
package.path = package.path .. ';' .. script_dir .. '/script/contents/header/?.lua'
package.path = package.path .. ';' .. script_dir .. '/script/contents/?.lua'
package.path = package.path .. ';' .. script_dir .. './script/json/?.lua'


local common = require("common")
local StringGenerator = require("StringGenerator")

-- Function to parse command-line arguments
local function parse_args(args)
    local options = { force = false, all = false, sub_target = {} }
    local i = 1
    while i <= #args do
        local arg = args[i]
        if arg == '-f' or arg == '--force' then
            options.force = true
        elseif arg == '-a' or arg == '--all' then
            options.all = true
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
    local args = parse_args(arg)

    if not args.command then
        print("Usage: lua "..arg[0].." [gen <config file> | clean <directory> | parse <output_csv_file> <header_file1> [<header_file2> ...]] [options]")
        return
    end

    local command = args.command
    local target = args.target
    local sub_target = args.sub_target or {}

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
        S = StringGenerator.new(config_data)
        local gilda_gen = require("gilda_gen")

        if #sub_target == 0 then
            for key, value in pairs(config_data) do
                if type(value) == 'table' then
                    table.insert(sub_target, key)
                end
            end
        end
        gilda_gen.command(config_data, sub_target)

    elseif command == "clean" then
        local gilda_clean = require("gilda_clean")
        -- For 'clean' command, the target is expected to be a directory
        local directory = target
        gilda_clean.command(directory, sub_target, args)

    elseif command == "parse" then
        local gilda_parse = require("gilda_parse")
        -- For 'parse' command, the target is expected to be an output CSV file
        local output_csv_file = target
        local header_files = sub_target
        gilda_parse.command(output_csv_file, header_files)

    else    
        print("Error: command "..command.." not available.")
        return
    end
end

-- Run the main function
main()
