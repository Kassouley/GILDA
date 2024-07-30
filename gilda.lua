package.path = package.path .. ';./script/?.lua'
package.path = package.path .. ';./script/commands/?.lua'
package.path = package.path .. ';./script/contents/source/?.lua'
package.path = package.path .. ';./script/contents/header/?.lua'
package.path = package.path .. ';./script/contents/?.lua'

local io_interceptor = require("io_interceptor")
local interceptor_generate = require("interceptor_generate")
local interceptor_clean = require("interceptor_clean")
local StringGenerator = require("string_generator")

-- Function to parse command-line arguments
local function parse_args(args)
    local options = { force = false, all = false }
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
                table.insert(options.interceptors, arg)
            end
        end
        i = i + 1
    end
    return options
end

-- Main function
function main()
    local args = parse_args(arg)

    if not args.command or not args.target then
        print("Usage: lua "..arg[0].." [gen <config file> | clean <directory>] [options]")
        return
    end

    local command = args.command
    local target = args.target
    local interceptors = args.interceptors or {}
    
    
    if command == "gen" then
        -- For 'gen' command, the target is expected to be a config file
        local config_file = target
        local config_data = io_interceptor.load_json(config_file)
        S = StringGenerator.new(config_data)

        if #interceptors == 0 then
            for key, value in pairs(config_data) do
                if type(value) == 'table' then
                    table.insert(interceptors, key)
                end
            end
        end
        interceptor_generate.command(config_data, interceptors)

    elseif command == "clean" then
        -- For 'clean' command, the target is expected to be a directory
        local directory = target
        interceptor_clean.command(directory, interceptors, args)

    else    
        print("Error: command "..command.." not available.")
        return
    end
end

-- Run the main function
main()
