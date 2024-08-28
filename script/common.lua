--- common module providing various utility functions for file handling, string manipulation, and more.
-- This module includes functions for managing environment variables, file operations,
-- JSON parsing, string trimming, splitting, and more.
-- @module common

local json = require("json")

local common = {}

--- Substitutes environment variables in a string.
-- Replaces occurrences of `$VAR` in the string with the corresponding environment variable.
-- @param str The string containing environment variables.
-- @return The string with environment variables substituted.
function common.sub_env_var(str)
    return str:gsub("%$([%w_]+)", function(env_var)
        return os.getenv(env_var) or ""
    end)
end

--- Creates a directory, including any necessary parent directories.
-- @param dirname The name of the directory to create.
function common.mkdir(dirname)
    local dirname = common.sub_env_var(dirname)
    os.execute("mkdir -p " .. dirname)
end

--- Checks if a file exists.
-- @param name The name of the file to check.
-- @return `true` if the file exists, `false` otherwise.
function common.file_exists(file)
    local file = common.sub_env_var(file)
    if type(file) ~= "string" then return false end
    return os.rename(file, file) and true or false
end

--- Scans a directory and returns a list of subdirectories.
-- @param dir The directory to scan.
-- @return A table containing the names of subdirectories within the given directory.
function common.scandir(dir)
    local dir = common.sub_env_var(dir)
    local subdirectories = {}
    local command = "find \"" .. dir .. "\" -maxdepth 1 -type d"
    for line in io.popen(command):lines() do
        if line ~= dir then
            table.insert(subdirectories, string.match(line, "[^/]+$"))
        end
    end
    return subdirectories
end

--- Loads and decodes a JSON file.
-- Reads a JSON file from the specified path and decodes it into a Lua table.
-- @param __input_path__ The path to the JSON file.
-- @return A table representing the JSON data.
function common.load_json(__input_path__)
    if __input_path__ == nil then
        error("Missing JSON input file")
        return nil
    end
    local infile = io.open(__input_path__, "r")
    if infile == nil then
        error("JSON input file " .. __input_path__ .. " can't be opened")
        return nil
    end
    local data = infile:read("*a")
    infile:close()
    return JSON:decode(data)
end

--- Writes content to a file and closes it.
-- @param filename The name of the file to write to.
-- @param content The content to write to the file.
function common.write_n_close(filename, content)
    local filename = common.sub_env_var(filename)
    local file = io.open(filename, "w")
    if not file then
        error("Error: Unable to open file " .. filename)
        return nil
    end
    file:write(content)
    file:close()
end

--- Checks if a filename has a specific extension.
-- @param filename The filename to check.
-- @param ext The extension to check for.
-- @return `true` if the filename has the specified extension, `false` otherwise.
function common.has_extension(filename, ext)
    return filename:sub(-#ext) == ext
end

--- Trims leading and trailing whitespace from a string and replaces multiple spaces with a single space.
-- @param s The string to trim.
-- @return The trimmed string.
function common.trim(s)
    s = s:match("^%s*(.-)%s*$")
    s = s:gsub("%s+", " ")
    return s
end

--- Splits a string outside of specified scope delimiters.
-- Splits the string based on a separator, but only outside of a specified scope (e.g., parentheses).
-- @param str The string to split.
-- @param sep The separator to use (default is comma).
-- @param scope_open The opening scope character (default is "(").
-- @param scope_close The closing scope character (default is ")").
-- @return A table containing the split parts of the string.
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
            table.insert(result, common.trim(str:sub(start_index, i-1)))
            start_index = i + 1
        end
    end
    
    table.insert(result, common.trim(str:sub(start_index)))
    
    return result
end

--- Splits a string by a delimiter.
-- @param str The string to split.
-- @param delimiter The delimiter to split by.
-- @return A table containing the split parts of the string.
function common.split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end
    return result
end

--- Alternates and concatenates elements from two arrays.
-- Combines elements from two arrays into a single string, alternating between elements of the two arrays.
-- @param arr1 The first array.
-- @param arr2 The second array.
-- @param sep The separator to use between elements (default is space).
-- @return A string with elements from both arrays concatenated alternately.
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

--- Deep copies a table.
-- Recursively copies all elements from one table to another.
-- @param o The table to copy.
-- @param seen Internal table used to track already copied elements (optional).
-- @return The copied table.
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
    else
        no = o
    end
    return no
end

--- Splits a file path into its directory and filename components.
-- @param filepath The file path to split.
-- @return The directory part and the filename part of the file path.
function common.split_path(filepath)
    local dir, filename = string.match(filepath, "(.-)([^\\/]-%.?[^%.\\/]*)$")
    return dir, filename
end

--- Requires a Lua module from a specific file path.
-- Loads and executes a Lua file from the given path, allowing dynamic module loading.
-- @param file_path The file path of the Lua module to load.
-- @return The result of the module execution.
function common.require_from_path(file_path)
    local file_path = common.sub_env_var(file_path)
    return assert(loadfile(file_path))()
end

return common
