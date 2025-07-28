local common = {}

local json = require("json")
local lfs = require("lfs")

--- Loads and decodes a JSON file.
-- Reads a JSON file from the specified path and decodes it into a Lua table.
-- @param __input_path__ The path to the JSON file.
-- @return A table representing the JSON data.
function common.load_json(__input_path__)
    local infile = lfs.open_file(__input_path__, "r")
    local data = infile:read("*a")
    infile:close()
    return JSON:decode(data)
end

function common.get_function_signature(f)
    local t = {}
    for i, v in ipairs(f.fparam) do
        t[i] = v
    end
    if f.ftype.ctype ~= "void" or f.ftype:is_generic_ptr() then
        table.insert(t, f.ftype)
    end
    return t
end

return common