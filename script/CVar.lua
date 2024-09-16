-- Managing C types and their Lua representations.
-- This module provides utilities for handling C types, cleaning type keywords,
-- counting pointers, and resolving real C types from typedefs and structs.

local common = require("common")

-- CVar class to represent a C type and perform operations on it
local CVar = {}
CVar.__index = CVar
CVar.__data = {}

function CVar:set_data(data)
    CVar.__data.typedef_map = data.typedef_csv
    CVar.__data.struct_map = data.struct_csv
    CVar.__data.keywords_list = {
        "const", "volatile", "static", "extern", 
        "inline", "register", "restrict",
        "struct", "union", "enum"
    }
    CVar.__data.c_types = {
        ["N/A"] = "",
        ["opaque"] = "%p",
        ["function"] = "%p",
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
        ["string"] = "%s"
    }
end

function CVar:new(ptype, pname)
    local self = setmetatable({}, CVar)
    self.ptype = ptype
    self.pname = pname
    self.pdecl = self:concat_param()
    self.ctype = ptype
    self.cformat = ""
    self.keywords = {}
    self.stc_ref_cnt = 0
    self.dyn_ref_cnt = 0
    self:get_ctype()
    return self
end

function CVar:get_cleaned_ptype()
    local cleaned_ptype = self.ptype
    cleaned_ptype = cleaned_ptype:gsub("%s*%*", "")
    cleaned_ptype = cleaned_ptype:gsub("const", "")
    return cleaned_ptype
end

function CVar:is_generic_ptr()
    return self.ctype == "void" and self.dyn_ref_cnt == 1
end

function CVar:is_struct()
    return self.keywords["struct"]
end

function CVar:is_union()
    return self.keywords["union"]
end

function CVar:is_enum()
    return self.keywords["enum"]
end

function CVar:get_ctype()
    self:pop_keywords()
    self:pop_ref()
    if self:is_c_type() then
        self.cformat = CVar.__data.c_types[self.ctype]
    elseif self:is_enum() then
        self.ctype = "enum "..self.ctype
        self.cformat = "%d"
    elseif self:is_struct() or self:is_union() then
        local new_ctype = self:is_struct() and "struct "..self.ctype or "union "..self.ctype
        local struct_map = CVar.__data.struct_map[self.ctype] or CVar.__data.struct_map[new_ctype]
        self.struct_fields = {}
        if struct_map then
            for i = 1, #struct_map do
                local pair = struct_map[i]
                local field = CVar:new(pair.type, pair.name)
                table.insert(self.struct_fields, field)
            end
        end
        self.ctype = new_ctype
    else
        self.ctype = CVar.__data.typedef_map[self.ctype] or "N/A"
        self:get_ctype()
    end
end

function CVar:is_dynamic()
    if self.struct_fields then
        for _, field in ipairs(self.struct_fields) do
            if field:is_dynamic() then return true end
        end
        return false
    end
    return self.dyn_ref_cnt > 0
end

function CVar:is_static()
    return not self:is_dynamic()
end

function CVar:pop_ref()
    if self:is_function() then return end
    self.ctype = self.ctype:gsub("%s*%*", function()
        self.dyn_ref_cnt = self.dyn_ref_cnt + 1
        return ""
    end)
    self.ctype = self.ctype:gsub("%s*%[%d*%]", function()
        self.stc_ref_cnt = self.stc_ref_cnt + 1
        return ""
    end)
    self.ctype = common.trim(self.ctype)
end

function CVar:is_function() -- ICI
    if self.ctype:find("%(%*%)") then
        self.ctype = "function"
        return true
    end
    return false
end

function CVar:pop_keywords()
    for _, keyword in ipairs(CVar.__data.keywords_list) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if self.ctype:find(pattern) then
            self.ctype = self.ctype:gsub(pattern, "")
            self.keywords[keyword] = true
        end
    end
end

function CVar:is_c_type()
    return CVar.__data.c_types[self.ctype] ~= nil
end

function CVar:concat_param()
    local pos = self.ptype:find("%(%*%)")
    if pos then
        return self.ptype:sub(1, pos+1) .. self.pname .. self.ptype:sub(pos + 2)
    end
    local pos_array = self.ptype:find("%[%d*%]")
    if pos_array then
        local base_type = self.ptype:sub(1, pos_array - 1)
        local array_size = self.ptype:sub(pos_array)
        return base_type .. " " .. self.pname .. array_size
    end
    return self.ptype .. " " .. self.pname
end

return CVar
