local json = require("json")

local common = {}

function common.sub_env_var(str)
    return str:gsub("%$([%w_]+)", function(env_var)
        return os.getenv(env_var) or ""
    end)
end

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

-- Function to split a string by a delimiter
function common.split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end
    return result
end

function common.alternate_concat(arr1, arr2, sep)
    sep = sep or " "
    local result = {}
    local len1 = #arr1
    local len2 = #arr2
    local max_len = math.max(len1, len2)

    for i = 1, max_len do
        if i <= len1 then
            table.insert(result, arr1[i])
        end
        if i <= len2 then
            table.insert(result, arr2[i])
        end
    end

    return table.concat(result, sep)
end


function common.deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end

    local no
    if type(o) == 'table' then
        no = {}
        seen[o] = no

        for k, v in next, o, nil do
        no[common.deepcopy(k, seen)] = common.deepcopy(v, seen)
        end
        setmetatable(no, common.deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    return no
end

-- Function to require a Lua module from a specific file path
function common.require_from_path(file_path)
    return assert(loadfile(common.sub_env_var(file_path)))()
end

  
return common
