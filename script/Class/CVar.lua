-- Managing C types and their Lua representations.
-- This module provides utilities for handling C types, cleaning type keywords,
-- counting pointers, and resolving real C types from typedefs and structs.

-- CVar class to represent a C type and perform operations on it
local CVar = {}
CVar.__index = CVar
CVar.__data = {}

--- Sets the CVar shared data for typedefs, structs, and keywords.
-- @param data A table containing typedef and struct CSV mappings.
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
        ["enum"] = "%d",
        ["struct"] = "",
        ["union"] = "",
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


--- Resolves pointers or dynamic references from the type.
-- Updates the type or increments the dynamic reference count.
-- @param self The CVar instance.
local function resolve_pointer_ref(self)
    if self.ctype:find("%(%*%)")  then
        self.ctype = "function"
    else
        self.ctype = self.ctype:gsub("%s*%*%s*", function()
            self.dyn_ref_cnt = self.dyn_ref_cnt + 1
            return ""
        end)
        self.ctype = self.ctype:gsub("%s*%[%]%s*", function()
            self.dyn_ref_cnt = self.dyn_ref_cnt + 1
            return ""
        end)
    end
end

--- Resolves array dimensions in the C type declaration.
-- Extracts and stores array sizes, cleaning the type string.
-- @param self The CVar instance.
local function resolve_array_dimension(self)
    for dim in self.ctype:gmatch("%s*%[(%d+)%]%s*") do
        table.insert(self.dimensions, tonumber(dim))
    end
    self.ctype = self.ctype:gsub("%[%d+%]", "")
end

--- Resolves and removes C keywords from the type string.
-- Extracts and marks detected keywords in the type.
-- @param self The CVar instance.
local function resolve_keywords(self)
    for _, keyword in ipairs(CVar.__data.keywords_list) do
        local pattern = "%f[%w_]" .. keyword .. "%f[^%w_]%s*"
        if self.ctype:find(pattern) then
            self.ctype = self.ctype:gsub(pattern, "")
            self.keyword[keyword] = true
        end
    end
end

--- Resolves if the type is a C string based on type and references.
-- @param self The CVar instance.
local function resolve_string(self)
    if self.ctype == "char" and 
            (self.dyn_ref_cnt > 0 or #self.dimensions > 0) then
        self.ctype = "string"
    end
end

--- Resolves if the type is an enum and adjusts its type.
-- @param self The CVar instance.
local function resolve_enum(self)
    if self:is_enum() then
        self.ctype = "enum"
    end
end

--- Resolves struct or union types, including their fields.
-- Maps struct or union fields into the CVar instance.
-- @param self The CVar instance.
local function resolve_struct(self)
    if self:is_struct() or self:is_union() then
        local tmp = self:is_struct() and "struct "..self.ctype or "union "..self.ctype
        local struct_map = CVar.__data.struct_map[self.ctype] or CVar.__data.struct_map[tmp]
        if struct_map then
            for i = 1, #struct_map do
                local pair = struct_map[i]
                local field = CVar:new(pair.type, pair.name)
                table.insert(self.struct_fields, field)
            end
            
            self.ctype = self:is_struct() and "struct" or "union"
        else
            self.ctype = "N/A"
        end
    end
end

--- Checks if the current type is a known C type.
-- @param self The CVar instance.
-- @return True if the type is known, otherwise false.
local function is_c_type(self)
    return CVar.__data.c_types[self.ctype] ~= nil
end

--- Resolves typedefs and applies all type resolutions to determine the actual type.
-- @param self The CVar instance.
local function resolve_typedef(self)
    resolve_keywords(self)
    resolve_array_dimension(self)
    resolve_pointer_ref(self)
    resolve_string(self)
    resolve_enum(self)
    resolve_struct(self)

    if not is_c_type(self) then
        local typedef_type = CVar.__data.typedef_map[self.ctype]
        if typedef_type then
            self.ctype = typedef_type
            resolve_typedef(self)
        else
            self.ctype = "N/A"
        end
    end
end

--- Constructor for the CVar class.
-- @param vtype The type declaration string.
-- @param name The variable name (optional).
-- @return A new CVar instance.
function CVar:new(vtype, name)
    if type(vtype) ~= "string" then error("CVar Constructor : argument 1 need to be a string") end
    local self = setmetatable({}, CVar)
    self.vtype = vtype
    self.name = name
    self.pdecl = self:concat_param()
    self.ctype = self.vtype
    self.keyword = {}
    self.dimensions = {}
    self.dyn_ref_cnt = 0
    self.struct_fields = {}
    resolve_typedef(self)
    return self
end

--- Returns the format string for the current type.
-- @return A format string or nil if the type is unknown.
function CVar:get_format()
    return CVar.__data.c_types[self.ctype]
end

--- Cleans the variable type by removing pointers and array brackets.
-- @return The cleaned-up type string.
function CVar:get_cleaned_vtype()
    local cleaned_ptype = self.vtype
    if self.ctype ~= "function" then
        cleaned_ptype = cleaned_ptype:gsub("%s*%*", "")
        cleaned_ptype = cleaned_ptype:gsub("%s*%[%]", "")
    else
        cleaned_ptype = cleaned_ptype:gsub("const%s+", "")
    end
    return cleaned_ptype
end

--- Determines if the type is a generic pointer (`void *`).
-- @return True if the type is a generic pointer, otherwise false.
function CVar:is_generic_ptr()
    return self.ctype == "void" and self.dyn_ref_cnt == 1
end

--- Determines if the type represents a string.
-- @return True if the type is a string, otherwise false.
function CVar:is_string()
    return self.ctype == "string"
end

--- Determines if the type represents a function pointer.
-- @return True if the type is a function, otherwise false.
function CVar:is_function()
    return self.ctype == "function"
end

--- Determines if the type represents `void`.
-- @return True if the type is `void`, otherwise false.
function CVar:is_void()
    return self.ctype == "void"
end

--- Determines if the type is unknown or unsupported.
-- @return True if the type is unknown (`N/A`), otherwise false.
function CVar:is_unknown()
    return self.ctype == "N/A"
end

--- Determines if the type represents a `struct`.
-- @return True if the type is a `struct`, otherwise false.
function CVar:is_struct()
    return self.keyword["struct"]
end

--- Determines if the type represents a `union`.
-- @return True if the type is a `union`, otherwise false.
function CVar:is_union()
    return self.keyword["union"]
end

--- Determines if the type represents an `enum`.
-- @return True if the type is an `enum`, otherwise false.
function CVar:is_enum()
    return self.keyword["enum"]
end

--- Determines if the type is an array.
-- @return True if the type is an array, otherwise false.
function CVar:is_array()
    return #self.dimensions > 0
end

--- Determines if the type is a pointer (dynamic reference).
-- @return True if the type has at least one pointer, otherwise false.
function CVar:is_pointer()
    return self.dyn_ref_cnt > 0
end

--- Determines if the type is dynamic (e.g., has pointers or dynamic fields).
-- For structs or unions, checks if any fields are dynamic.
-- @return True if the type is dynamic, otherwise false.
function CVar:is_dynamic()
    if self.struct_fields then
        for _, field in ipairs(self.struct_fields) do
            if field:is_dynamic() then return true end
        end
        return false
    end
    return self.dyn_ref_cnt > 0
end

--- Determines if the type is static (not dynamic).
-- @return True if the type is static, otherwise false.
function CVar:is_static()
    return not self:is_dynamic()
end

--- Concatenates the type and name into a declaration string.
-- Handles special cases for function pointers and arrays.
-- @return A string representing the type declaration with the variable name.
function CVar:concat_param()
    if not self.name then return self.vtype end
    local pos = self.vtype:find("%(%*%)")
    if pos then
        return self.vtype:sub(1, pos+1) .. self.name .. self.vtype:sub(pos + 2)
    end
    local pos_array = self.vtype:find("%[%d*%]")
    if pos_array then
        local base_type = self.vtype:sub(1, pos_array - 1)
        local array_size = self.vtype:sub(pos_array)
        return base_type .. " " .. self.name .. array_size
    end
    return self.vtype .. " " .. self.name
end

return CVar
