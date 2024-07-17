local io_interceptor = require("io_interceptor")
local interceptor_generate = require("interceptor_generate")
local interceptor_build = require("interceptor_build")
local interceptor_clean = require("interceptor_clean")

function main()
    if #arg < 2 then
        print("Usage: lua "..arg[0].." [gen | build] <config file>")
        return
    end

    local command = arg[1]
    local config_file = arg[2]
    local interceptors = {}
    for i = 3, #arg do
        table.insert(interceptors, arg[i])
    end
    local config_data = io_interceptor.load_json(config_file)

    if #interceptors == 0 and command ~= "clean" then
        for key, _ in pairs(config_data) do
            table.insert(interceptors, key)
        end
    end

    if command == "gen" then
        interceptor_generate.command(config_data, interceptors)
    elseif command == "build" then
        interceptor_build.command(config_data, interceptors)
    elseif command == "clean" then
        interceptor_clean.command(interceptors)
    else    
        print("Error : command "..arg[1].." not available.")
        return
    end
end

WORKDIR=os.getenv("PWD")
GENDIR=WORKDIR.."/gen"
COREDIR=GENDIR.."/core"
LIBDIR=GENDIR.."/lib"
BUILDDIR=GENDIR.."/build"
AUTOGENDIR=COREDIR.."/autogen"
MANGENDIR=COREDIR.."/mangen"
-- Run the main function
main()

