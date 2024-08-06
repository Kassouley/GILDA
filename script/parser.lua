local parser = {}

function parser.parse_function_csv(filename)
    local fcnts = {}
    -- Read the CSV file
    for line in io.lines(filename) do
        local parts = common.split(line, ";")
        -- Construct function table
        if parts[1] ~= "NOGEN" then
            local f = {
                gen = parts[1],
                ftype = parts[2],
                fname = parts[3],
                ptype = {},
                pname = {}
            }
            -- Extract arguments
            for i = 4, #parts,2 do
                table.insert(f.ptype, parts[i]) 
                table.insert(f.pname, parts[i+1]) 
            end
            table.insert(fcnts, f)
        end
    end
    return functions
end

function parser.parse_typedef_csv(filename)
    local typedef = {}
    for line in io.lines(filename) do
        local parts = common.split(line, ",")
        if #parts == 2 then
            local key = common.trim(parts[1])
            local value = common.trim(parts[2])
            typedef[key] = value
        end
    end
    return typedef
end

function parser.parse_struct_csv(filename)
    local struct = {}

    for line in io.lines(filename) do
        local parts = common.split(line, ",")
        local key = parts[1]
        local values = {}
        for i = 2, #parts, 2 do
            if parts[i] and parts[i + 1] then
                table.insert(values, {type = common.trim(parts[i]), name = common.trim(parts[i + 1])})
            end
        end
        struct[key] = values
    end
    return struct
end

return parser
