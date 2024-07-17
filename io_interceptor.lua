package.path = package.path .. ';./json/?.lua'
local io_interceptor = {}

local json = require("json")

function io_interceptor.mkdir(dirname)
    os.execute("mkdir -p "..dirname)
end


function io_interceptor.write_n_close(filename, content)
    local file = io.open(filename, "w")
    if not file then
        error("Error: Unable to open file " .. filename)
        return nil
    end
    file:write(content)
    file:close()
end

function io_interceptor.parse_variable_declaration(declaration)
    local pattern1 = "^%s*([%w%s_]+)%s*([%*%s]+)%s*([%w_]+)%s*$"
    local base_type, pointer_symbol, variable_name = declaration:match(pattern1)
    if base_type and variable_name and pointer_symbol then
        local type_str = base_type .. pointer_symbol
        return type_str, variable_name
    end

    local pattern2 = "^%s*([%w%s_]+)%s*([%*%s]+)%s*(%(.+%))%s*$"
    local base_type, pointer_symbol, variable_name = declaration:match(pattern2)
    if base_type and variable_name and pointer_symbol then
        local type_str = base_type .. pointer_symbol
        return type_str, variable_name:match("^%(%*?([%w_]+)%)%(.+%)")
    else
        return nil, nil
    end
end

function io_interceptor.parseCSV(filename)
    local functions = {}
    -- Read the CSV file
    for line in io.lines(filename) do
        local parts = {}
        for part in line:gmatch("[^;]+") do
            table.insert(parts, part)
        end
        -- Construct function table
        local func = {
            gen = parts[1],
            return_type = parts[2],
            name = parts[3],
            args = {}
        }
        -- Extract arguments
        for i = 4, #parts do
            table.insert(func.args, parts[i]) 
        end
        table.insert(functions, func)
    end
    return functions
end

function io_interceptor.load_json(__input_path__)
    if __input_path__ == nil then
        error ("Missing JSON input file")
        return nil
    end
    local infile = io.open (__input_path__, "r")
    if infile == nil then
        error ("JSON input file "..__input_path__.." can't be opened")
        return nil
    end
    local data = infile:read ("*a")
    infile:close ()
    return JSON:decode(data)
end

return io_interceptor