local common = require("common")

local c_manager = {}

c_manager.c_types = {
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
    local found_struct = false
    local cleaned_declaration = declaration or "void"
    for _, keyword in ipairs(keywords) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if cleaned_declaration:find(pattern) then
            cleaned_declaration = cleaned_declaration:gsub(pattern, "")
            
            if keyword == "struct" or keyword == "union" then
                found_struct = true
            end
            if keyword == "enum" then
                cleaned_declaration = "enum"
            end
        end
    end
    return found_struct, cleaned_declaration
end


local function _is_c_type(_type)
    return c_manager.c_types[_type:gsub("%s*%*$", "")] ~= nil
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


function c_manager.get_real_type(data, decl, pointer_count)
    local is_struct, cleaned_decl = _clean_keyword(decl)
    local cnt_tmp, cleaned_decl = _count_pointers(cleaned_decl)
    pointer_count = (pointer_count or 0) + cnt_tmp
    if _is_c_type(cleaned_decl) then
        return cleaned_decl or "void", pointer_count
    elseif is_struct then
        return data.struct_csv[cleaned_decl] or "void", pointer_count
    else
        cleaned_decl, pointer_count = c_manager.get_real_type(data, data.typedef_csv[cleaned_decl], pointer_count)
        return cleaned_decl or "void", pointer_count
    end
end

return c_manager