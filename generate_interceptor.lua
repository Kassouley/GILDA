package.path = package.path .. ';./script/?.lua'
package.path = package.path .. ';./script/commands/?.lua'
package.path = package.path .. ';./script/contents/?.lua'

local io_interceptor = require("io_interceptor")
local interceptor_generate = require("interceptor_generate")
local interceptor_build = require("interceptor_build")
local interceptor_clean = require("interceptor_clean")

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
                options.config_file = arg
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

    if not args.command or not args.config_file then
        print("Usage: lua "..arg[0].." [gen | build | clean] <config file> [options]")
        return
    end

    local command = args.command
    local config_file = args.config_file
    local interceptors = args.interceptors or {}
    local config_data = io_interceptor.load_json(config_file)

    if #interceptors == 0 and command ~= "clean" then
        for key, value in pairs(config_data) do
            if type(value) == 'table' then
                table.insert(interceptors, key)
            end
        end
    end

    if command == "gen" then
        interceptor_generate.command(config_data, interceptors)
    elseif command == "build" then
        interceptor_build.command(config_data, interceptors, args)
    elseif command == "clean" then
        interceptor_clean.command(interceptors, args)
    else    
        print("Error: command "..command.." not available.")
        return
    end
end

-- Directory definitions

-- Run the main function
main()
