local script_dir = debug.getinfo(1, "S").source:match("@(.*[\\/]?.*)") or ""
script_dir = script_dir:gsub('\\', '/'):match("(.*[\\/])") or ""
local paths = {
    '',
    './',
    './commands/',
    './contents/source/',
    './contents/header/',
    './contents/',
    './json/'
}


c_types = {
    ["void"] = "",
    ["char"] = "%c",
    ["signed char"] = "%hhd",
    ["unsigned char"] = "%hhu",
    ["short"] = "%hd",
    ["signed short"] = "%hd",
    ["unsigned short"] = "%hu",
    ["short int"] = "%hd",
    ["signed short int"] = "%hd",
    ["unsigned short int"] = "%hu",
    ["int"] = "%d",
    ["signed int"] = "%d",
    ["unsigned int"] = "%u",
    ["long"] = "%ld",
    ["signed long"] = "%ld",
    ["unsigned long"] = "%lu",
    ["long int"] = "%ld",
    ["signed long int"] = "%ld",
    ["unsigned long int"] = "%lu",
    ["long long"] = "%lld",
    ["signed long long"] = "%lld",
    ["unsigned long long"] = "%llu",
    ["long long int"] = "%lld",
    ["signed long long int"] = "%lld",
    ["unsigned long long int"] = "%llu",
    ["float"] = "%f",
    ["double"] = "%lf",
    ["long double"] = "%Lf",
    ["string"] = "%s",
    ["enum"] = "%d",
}

local function _clean_keyword(declaration)
    local keywords = {
        "const", "volatile", "static", "extern", "inline", "register", "restrict",
        "struct", "union", "enum"
    }
    local is = {}
    local cleaned_declaration = declaration or "void"
    for _, keyword in ipairs(keywords) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if cleaned_declaration:find(pattern) then
            cleaned_declaration = cleaned_declaration:gsub(pattern, "")
            
            if keyword == "struct" then
                is.struct = true
            elseif keyword == "union" then
                is.union = true
            elseif keyword == "enum" then
                is.enum = true
            end
        end
    end
    return is, cleaned_declaration
end


local function _is_c_type(_type)
    return c_types[_type] ~= nil
end

local function _count_pointers(_type)
    local pointer_count = 0
    local cleaned_type = _type
    cleaned_type = cleaned_type:gsub("%s*%*", function()
        pointer_count = pointer_count + 1
        return ""
    end)
    cleaned_type = cleaned_type:gsub("%s*%[%d*%]", function()
        pointer_count = pointer_count + 1
        return ""
    end)
    return pointer_count, common.trim(cleaned_type)
end

local function print_type(ctype, name, ptr)
    print(ptr)
    print(ctype.." "..name..":")
end

local function print_struct(name, ptr)
    print(ptr)
    print(name..":")
end

local function _get_real_type(data, _type, _var, pointer_count)
    local is, cleaned_type = _clean_keyword(decl)
    local cnt_tmp, cleaned_type = _count_pointers(cleaned_type)
    pointer_count = (pointer_count or 0) + cnt_tmp
    if _is_c_type(cleaned_type) or is.enum then
        print_type(cleaned_type, _var, pointer_count)
    elseif is.struct then
        return {
            type = cleaned_type, 
            format = c_types[cleaned_type],
            nb_ptr = pointer_count}
        return data.struct_csv[cleaned_type], pointer_count
    else
        return _get_real_type(data, data.typedef_csv[cleaned_type], _var, pointer_count)
    end
end

for _, path in ipairs(paths) do
    package.path = package.path .. ';' .. script_dir .. path .. '?.lua'
end

local common = require("common")
local parser = require("parser")

local function_csv = "../csv/hsa/hsa_function.csv"
local struct_csv = "../csv/hsa/hsa_structs_unions.csv"
local typedef_csv = "../csv/hsa/hsa_typedefs.csv"

local data_csv = {
    function_csv = parser.parse_function_csv(function_csv),
    typedef_csv = parser.parse_typedef_csv(typedef_csv),
    struct_csv = parser.parse_struct_csv(struct_csv)
}

for i,j in pairs(data_csv.typedef_csv) do
    print(i, j)
    _get_real_type(data_csv.typedef_csv, i)
end
