local script_dir = debug.getinfo(1, "S").source:match("@(.*[\\/]?.*)") or ""
script_dir = script_dir:gsub('\\', '/'):match("(.*[\\/])") or ""
local paths = {
    '',
    '../',
    './Class/',
    './utils/',
    './utils/json/',
}

for _, path in ipairs(paths) do
    package.path = package.path .. ';' .. script_dir .. path .. '?.lua'
end

require("string_ext")
local common = require("common")
local lfs = require("lfs")
local Script = require("Script")

local function run_nm_command(binary_path)
    local command = "nm -D --defined-only -C " .. binary_path
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end

local function get_nm_functions(binary_path)
    local nm_output = run_nm_command(binary_path)
    local functions = {}
    local deduplicated = {}

    for line in nm_output:gmatch("[^\r\n]+") do
        local func_name = line:match("T ([^%s@]+)%(.*%)") or line:match("T ([^%s@]+)@@") or line:match("T ([^%s@]+)")
        if func_name and not deduplicated[func_name] then
            table.insert(functions, func_name)
            deduplicated[func_name] = true
        end
    end

    return functions
end

local function get_csv_functions(csv_path)
    local functions = {}
    local deduplicated = {}

    local file = lfs.open_file(csv_path, "r")
    
    for line in file:lines() do
        local parsed_line = line:trim():split(";")
        local func_name = parsed_line[4]
        if func_name and not deduplicated[func_name] then
            table.insert(functions, func_name)
            deduplicated[func_name] = true
        end
    end
    file:close()

    return functions
end

local function compare_functions(nm_functions, csv_functions)
    local nm_set, csv_set = {}, {}
    local missing, extra = {}, {}

    for _, func in ipairs(nm_functions) do
        nm_set[func] = true
    end
    for _, func in ipairs(csv_functions) do
        csv_set[func] = true
    end

    for _, func in ipairs(csv_functions) do
        if not nm_set[func] then
            table.insert(extra, func)
        end
    end

    for _, func in ipairs(nm_functions) do
        if not csv_set[func] then
            table.insert(missing, func)
        end
    end

    -- Generate report
    local report = {
        missing = missing,
        extra = extra
    }

    return report
end

-- Function to print the report
local function print_report(report)
    print("Missing functions:")
    for _, func in ipairs(report.missing) do
        print("  - " .. func)
    end

    print("Extra functions:")
    for _, func in ipairs(report.extra) do
        print("  - " .. func)
    end
end

-- Main function to integrate all steps
local function analyze_functions(binary_path, csv_path)
    local nm_functions = get_nm_functions(binary_path)
    local csv_functions = get_csv_functions(csv_path)

    local report = compare_functions(nm_functions, csv_functions)
    print_report(report)
end


local function process_checker(positional_args, optional_args)
    if not lfs.file_exists(positional_args[1]) then
        print("Error: the file "..positional_args[1].." doesn't exists.")
    elseif not lfs.file_exists(positional_args[2]) then
        print("Error: the file "..positional_args[2].." doesn't exists.")
    else
        analyze_functions(positional_args[2], positional_args[1])
    end
end

-- Main script logic
local attribute = {
    name = "gilda check",
    version = "1.0",
}
local script = Script:new(attribute)

script:set_desc([[Show the missing or extra functions between the CSV function file and the shared library in input.]])

script:set_execute_function(process_checker)

script:add_argument("csv functions file", false, false, "CSV file that contains functions to intercept.")
script:add_argument("shared library file", false, false, "Shared library (.so) file that contains the symbol of the function to intercept.")

return script
