--- c_manager module for managing C types and their Lua representations.
-- This module provides utilities for handling C types, cleaning type keywords,
-- counting pointers, and resolving real C types from typedefs and structs.
-- @module c_manager

local common = require("common")

local c_manager = {}

--- A table mapping C types to their respective Lua format strings.
-- This table is used to translate C types into C format strings.
-- @field c_types
c_manager.c_types = {
    ["N/A"] = "",
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

--- Cleans a C type keyword by removing certain qualifiers and detecting type information.
-- Removes keywords such as `const`, `volatile`, etc., and identifies if the type is a
-- struct, union, enum, or callback.
-- @param ptype The C type to clean.
-- @return A table indicating the type information (e.g., if it's a struct, union, etc.),
-- and the cleaned type as a string.
local function _clean_keyword(ptype)
    local keywords = {
        "const", "volatile", "static", "extern", "inline", "register", "restrict",
        "struct", "union", "enum"
    }
    local is = {}
    local cleaned_ptype = ptype or "N/A"
    
    
    for _, keyword in ipairs(keywords) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if cleaned_ptype:find(pattern) then
            cleaned_ptype = cleaned_ptype:gsub(pattern, "")
            if keyword == "struct" then
                is.struct = true
            elseif keyword == "union" then
                is.union = true
            elseif keyword == "enum" then
                is.enum = true
                cleaned_ptype = "enum"
            end
        end
    end
    
    if cleaned_ptype:find("%(%*%)") then
        is.callback = true
        cleaned_ptype = "void*"
    end
    return is, cleaned_ptype
end

--- Checks if a given type is a recognized C type.
-- @param t The type to check.
-- @return `true` if the type is recognized, `false` otherwise.
local function _is_c_type(t)
    return c_manager.c_types[t:gsub("%s*%*$", "")] ~= nil
end

--- Counts the number of pointers in a C type and returns the cleaned type.
-- @param _type The type to analyze.
-- @return The number of pointers and the cleaned type.
local function _count_pointers(_type)
    local ptr_count = 0
    local cleaned_type = _type
    cleaned_type = cleaned_type:gsub("%s*%*", function()
        ptr_count = ptr_count + 1
        return ""
    end)
    cleaned_type = cleaned_type:gsub("%s*%[%d*%]", function()
        ptr_count = ptr_count + 1
        return ""
    end)
    return ptr_count, common.trim(cleaned_type)
end

--- Resolves the real C type, handling typedefs, structs, and unions.
-- Determines the true type of a given C type, including any pointer levels.
-- @param data The data context containing typedefs and structs.
-- @param ptype The C type to resolve.
-- @param ptr_count The initial pointer count (optional).
-- @return The real C type, pointer count, and the kind of type (e.g., 'ctype', 'struct').
local function _get_real_type(data, ptype, ptr_count)
    local is, cleaned_ptype = _clean_keyword(ptype)
    local cnt_tmp, cleaned_ptype = _count_pointers(cleaned_ptype)
    ptr_count = (ptr_count or 0) + cnt_tmp
    if _is_c_type(cleaned_ptype) then
        return cleaned_ptype or "N/A", ptr_count, "ctype"
    elseif is.struct then
        return data.struct_csv[cleaned_ptype] or "N/A", ptr_count, "struct"
    elseif is.union then
        return data.struct_csv[cleaned_ptype] or "N/A", ptr_count, "union"
    else
        cleaned_ptype, ptr_count, kind = _get_real_type(data, data.typedef_csv[cleaned_ptype], ptr_count)
        return cleaned_ptype or "N/A", ptr_count, kind
    end
end


--- Resolves a C parameter's true type and its details.
-- Determines the actual C type, including handling nested structures and pointers.
-- @param ptype The parameter type.
-- @param pname The parameter name.
-- @param data The data context containing typedefs and structs.
-- @return A table containing the parameter name, original type, resolved C type,
-- pointer count, and kind of type.
function c_manager.get_real_cparam(ptype, pname, data)
    local result
    local ctype, nb_ptr, kind = _get_real_type(data, ptype)
    if type(ctype) == 'table' then
        local struct_fields = {}
        for _, pair in ipairs(ctype) do
            table.insert(struct_fields, 
                c_manager.get_real_cparam(pair.type, pair.name, data)
            )
        end
        result = {pname=pname, ptype=ptype, ctype=struct_fields, ptr=nb_ptr, kind=kind}
    else
        result = {pname=pname, ptype=ptype, ctype=ctype, ptr=nb_ptr, kind=kind}
    end
    return result
end

--- Concatenates a C type and parameter name into a single declaration.
-- Handles special cases like function pointers and arrays.
-- @param ptype The parameter type.
-- @param pname The parameter name.
-- @return A string representing the complete C declaration.
function c_manager.concat_param(ptype, pname)
    local pos = ptype:find("%(%*%)")
    if pos then
        return ptype:sub(1, pos+1) .. pname .. ptype:sub(pos + 2)
    end
    local pos_array = ptype:find("%[%d*%]")
    if pos_array then
        local base_type = ptype:sub(1, pos_array - 1) 
        local array_size = ptype:sub(pos_array) 
        return base_type .. " " .. pname .. array_size
    end
    return ptype.." "..pname
end


return c_manager