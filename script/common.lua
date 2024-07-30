package.path = package.path .. ';./script/json/?.lua'
local json = require("json")

local common = {}

function common.mkdir(dirname)
    os.execute("mkdir -p "..dirname)
end

function common.file_exists(name)
    if type(name)~="string" then return false end
    return os.rename(name,name) and true or false
end

function common.scandir(dir)
    local subdirectories = {}
    local command = "find \"" .. dir .. "\" -maxdepth 1 -type d"
    for line in io.popen(command):lines() do
        if line ~= dir then
            table.insert(subdirectories, string.match(line, "[^/]+$"))
        end
    end
    return subdirectories
end

function common.load_json(__input_path__)
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

function common.write_n_close(filename, content)
    local file = io.open(filename, "w")
    if not file then
        error("Error: Unable to open file " .. filename)
        return nil
    end
    file:write(content)
    file:close()
end

function common.has_extension(filename, ext)
    return filename:sub(-#ext) == ext
end

function common.trim(s)
    s = s:match("^%s*(.-)%s*$")
    s = s:gsub("%s+", " ")
    return s
end

function common.split_outside_scope(str, sep, scope_open, scope_close)
    local result = {}
    local scope_level = 0
    local start_index = 1
    sep = sep or ","
    scope_open = scope_open or "("
    scope_close = scope_close or ")"
    
    for i = 1, #str do
        local char = str:sub(i, i)
        
        if char == scope_open then
            scope_level = scope_level + 1
        elseif char == scope_close then
            scope_level = scope_level - 1
        elseif char == sep and scope_level == 0 then
            table.insert(result, common.trim(str:sub(start_index, i-1)))  -- trim spaces
            start_index = i + 1
        end
    end
    
    table.insert(result, common.trim(str:sub(start_index)))  -- add the last part and trim spaces
    
    return result
end

return common
