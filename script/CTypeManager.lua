-- Managing C types and their Lua representations.
-- This module provides utilities for handling C types, cleaning type keywords,
-- counting pointers, and resolving real C types from typedefs and structs.

local common = require("common")

-- CTypeManager class to manage C types and their Lua representations
local CTypeManager = {}
CTypeManager.__index = CTypeManager

function CTypeManager:new(data)
    local instance = {}
    instance.typedef_map = data.typedef_csv
    instance.struct_map = data.struct_csv
    instance.keywords = {
        "const", "volatile", "static", "extern", 
        "inline", "register", "restrict",
        "struct", "union", "enum"
    }
    instance.keywords_bis = {
        "const", "volatile", "static", "extern", 
        "inline", "register", "restrict"
    }
    instance.c_types = {
        ["N/A"] = "",
        ["opaque"] = "%p",
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
    return setmetatable(instance, CTypeManager)
end

function CTypeManager:clean_keyword_bis(_type)
    local is = {}
    for _, keyword in ipairs(self.keywords_bis) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if _type:find(pattern) then
            _type = _type:gsub(pattern, "")
        end
    end
    return _type, is
end

function CTypeManager:clean_keyword(_type)
    local is = {}
    for _, keyword in ipairs(self.keywords) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if _type:find(pattern) then
            _type = _type:gsub(pattern, "")
            if keyword == "struct" then
                is.struct = true
            elseif keyword == "union" then
                is.union = true
            elseif keyword == "enum" then
                is.enum = true
                _type = "enum"
            end
        end
    end

    if _type:find("%(%*%)") then
        is.callback = true
        _type = "void*"
    end
    return _type, is
end

function CTypeManager:remove_ptr(_type)
    local ptr_cnt = 0
    _type = _type:gsub("%s*%*", function()
        ptr_cnt = ptr_cnt + 1
        return ""
    end)
    _type = _type:gsub("%s*%[%d*%]", function()
        ptr_cnt = ptr_cnt + 1
        return ""
    end)
    return ptr_cnt, common.trim(_type)
end

function CTypeManager:is_c_type(t)
    local cleaned_type = t:gsub("%s*%*$", "")
    return self.c_types[cleaned_type] ~= nil
end

function CTypeManager:get_ctype_of(_type, total_ptr)
    local cleaned_type, is = self:clean_keyword(_type)
    local curr_ptr_cnt, cleaned_type = self:remove_ptr(cleaned_type)
    total_ptr = (total_ptr or 0) + curr_ptr_cnt

    if self:is_c_type(cleaned_type) then
        return {
            ctype = cleaned_type,
            ptr_cnt = total_ptr,
            kind = "ctype"
        }
    elseif is.struct then
        return {
            ctype = curr_ptr_cnt > 0 and "opaque" or self.struct_map[cleaned_type] or "void",
            ptr_cnt = total_ptr,
            kind = "struct"
        }
    elseif is.union then
        return {
            ctype = self.struct_map[cleaned_type] or "N/A",
            ptr_cnt = total_ptr,
            kind = "union"
        }
    else
        return self:get_ctype_of(self.typedef_map[cleaned_type] or "N/A", total_ptr)
    end
end


function CTypeManager:get_real_cparam(ptype, pname)
    local result = self:get_ctype_of(ptype)

    local cvar = CVar:new(
        ptype, pname, 
        result.ctype, result.ptr_cnt,
        self.c_types[result.ctype],
        result.kind
    )

    local tmp = self:clean_keyword_bis(ptype)
    cvar.ptr_ptype, cvar.cleaned_ptype = self:remove_ptr(tmp)

    if type(result.ctype) == 'table' then
        local struct_fields = {}
        for i = 1, #result.ctype do
            local pair = result.ctype[i]
            struct_fields[i] = self:get_real_cparam(pair.type, pair.name)
        end
        cvar.ctype = struct_fields
    end

    return cvar
end

return CTypeManager
