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

require("string_ext")
local lfs = require("lfs")
local Script = require("Script")

local function process_preprocess(arguments_values, options_values)
    local header_files = arguments_values
    local output_file = options_values.output or lfs.basename(arguments_values[1])
    local compil = options_values.compil or ""
    
    -- Build the shell command
    local command = "cpp -E " .. table.concat(header_files, " ") .. " " .. compil
    
    -- Capture the output of the command
    local command_output = ""
    local handle = io.popen(command)
    if handle then
        command_output = handle:read("*a")
        handle:close()
    end

    -- Replace substrings in the captured output
    command_output = command_output:gsub("#.-\n", "")
    command_output = command_output:gsub("__attribute__%s*%(%b()%)", "")
    command_output = command_output:gsub("%s+", " ")
    command_output = command_output:gsub(";", ";\n")
    command_output = command_output:gsub("{", "{\n")
    
    -- Write the modified output to the output file
    local output_handle = lfs.open_file(output_file, "w")
    output_handle:write(command_output)
    output_handle:close()
end



local function output_cb(script, value) 
    script.options_values.output = value
end

local function compil_cb(script, value) 
    script.options_values.compil = value
end

-- Main script logic
local attribute = {
    name = "gilda pre",
    version = "1.0"
}
local script = Script:new(attribute)

script:set_desc([[Prepocess the header file that need to be parsed into CSV.]])

script:set_execute_function(process_preprocess)

script:add_argument("headers_file", false, true, "Path to the header files to preprocess.")

                        
script:add_option("output", "o", "<output_file>", 
[[                  
                        Specify the file where the preprocessed header will be generated.]], 
                        true, output_cb)

                        
script:add_option("compil", nil, "=<compilation_option>", 
[[                  
                        Add some options to the preprocessing process.]], 
                        true, compil_cb)

return script