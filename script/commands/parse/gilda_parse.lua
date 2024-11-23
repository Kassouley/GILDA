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
local Script = require("Script")

local function proccess_parse(arguments_values, options_values)
    local header_file = arguments_values[1]
    local output_dir = options_values.output or "csv/"
    local domain_name = options_values.domain or lfs.remove_extension(header_file)

    lfs.mkdir(lfs.concat_path(output_dir, domain_name))

    os.execute("python3 "..script_dir.."./header_parser.py "..domain_name.." "..output_dir.."/"..domain_name.." "..header_file)
end

local function domain_cb(script, value) 
    script.options_values.domain = value
end

local function output_cb(script, value) 
    script.options_values.output = value
end

-- Main script logic
local attribute = {
    name = "gilda parse",
    version = "1.0"
}
local script = Script:new(attribute)

script:set_desc([[Parse the functions and type from an header file (.h) into CSV domain.]])

script:set_execute_function(proccess_parse)

script:add_argument("headers_file", false, false, "Path to the header file to parse.")

script:add_option("domain", "d", "<domain_name>", 
[[                  
                        Specify the name of the domain for this parse. If not specify, take the name of the header as domain name.]], 
                        true, domain_cb)

                        
script:add_option("output", "o", "<output_dir>", 
[[                  
                        Specify the directory where the CSV will be generated.]], 
                        true, output_cb)

return script