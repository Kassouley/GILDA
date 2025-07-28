-- Managing C types and their Lua representations.
-- This module provides utilities for handling C types, cleaning type keywords,
-- counting pointers, and resolving real C types from typedefs and structs.

-- CVar class to represent a C type and perform operations on it
local CVar = {}
CVar.__index = CVar
CVar.__data = {}


CVar.__data.c_types_fmt = {
    ["N/A"]                     = nil,
    ["void"]                    = nil,
    ["opaque"]                  = "%p",
    ["function"]                = "%p",
    ["string"]                  = "%s",
    ["enum"]                    = "%d",
    ["char"]                    = "%c",
    ["signed char"]             = "%hhd",
    ["unsigned char"]           = "%hhu",
    ["short"]                   = "%hd",
    ["signed short"]            = "%hd",
    ["unsigned short"]          = "%hu",
    ["short int"]               = "%hd",
    ["signed short int"]        = "%hd",
    ["unsigned short int"]      = "%hu",
    ["int"]                     = "%d",
    ["signed int"]              = "%d",
    ["unsigned int"]            = "%u",
    ["long"]                    = "%ld",
    ["signed long"]             = "%ld",
    ["unsigned long"]           = "%lu",
    ["long int"]                = "%ld",
    ["signed long int"]         = "%ld",
    ["unsigned long int"]       = "%lu",
    ["long long"]               = "%lld",
    ["signed long long"]        = "%lld",
    ["unsigned long long"]      = "%llu",
    ["long long int"]           = "%lld",
    ["signed long long int"]    = "%lld",
    ["unsigned long long int"]  = "%llu",
    ["float"]                   = "%f",
    ["double"]                  = "%lf",
    ["long double"]             = "%Lf",
}

CVar.__data.type_qualifers  = { ["const"] = true, ["volatile"] = true, ["restrict"] = true }

--- Sets the CVar shared data for typedefs, structs, and keywords.
-- @param data A table containing typedef and struct CSV mappings.
function CVar:set_data(data)
    CVar.__data.typedef_map = data.typedef_csv
    CVar.__data.struct_map = data.struct_csv
end

function CVar:is_function(ctype)
    ctype = ctype or self.ctype
    return ctype:find("%(%*[^)]*%)%(") ~= nil
end


function CVar:is_struct(ctype)
    ctype = ctype or self.ctype
    return ctype:find("struct%s*") ~= nil
end


function CVar:is_enum(ctype)
    ctype = ctype or self.ctype
    return ctype:find("enum%s*") ~= nil
end


function CVar:is_union(ctype)
    ctype = ctype or self.ctype
    return ctype:find("union%s*") ~= nil
end

function CVar:is_ptr(ctype)
    ctype = ctype or self.ctype
    local cnt, _ = self:get_ptr_count(ctype)
    return cnt > 0
end

function CVar:is_string(ctype)
    ctype = ctype or self.ctype
    return ctype:match("char%s*%*%s*$") ~= nil
        or ctype:match("char%s*%[") ~= nil
end

function CVar:is_generic_ptr(ctype)
    ctype = ctype or self.ctype
    local cnt, _ = self:get_ptr_count(ctype)
    return self:ctype_is_void() and cnt == 1
end


function CVar:is_opaque()
    if self:is_struct() or self:is_union() then
        return #self.struct_fields == 0
    end
    return false
end


function CVar:is_static_array(ctype)
    ctype = ctype or self.ctype
    return ctype:find("%[%d-%]") ~= nil
end


function CVar:is_dynamic_array(ctype)
    ctype = ctype or self.ctype
    return ctype:find("%[%%s*%]") ~= nil
end


function CVar:is_array(ctype)
    ctype = ctype or self.ctype
    return self:is_dynamic_array(ctype) or self:is_static_array(ctype)
end



function CVar:ctype_is_void()
    return self:get_base_type() == "void"
end



function CVar:get_base_type()
    if self:is_string() then
        return "string"
    elseif self:is_function() then
        return "function"
    elseif self:is_enum() then
        return "enum"
    elseif self:is_opaque() then
        return "opaque"
    elseif self:is_struct() then
        return "struct"
    elseif self:is_union() then
        return "union"
    else
        local ctype = self.ctype

        -- Remove qualifiers
        ctype = self:remove_type_qualifers()

        -- Remove pointers and arrays
        ctype = ctype:gsub("%*+", "")             -- remove pointer stars
        ctype = ctype:gsub("%[[^%]]*%]", "")      -- remove array brackets


        return ctype
    end
end


function CVar:get_cfmt()
    local base_type = self:get_base_type()

    if base_type == "union" or base_type == "struct" then
        error("Do not use CVar:get_cfmt() method for structure or union variable.\n"..
              "Please check before if variable is structure or union using var:is_struct() or var:is_union() methods.")
    end

    return CVar.__data.c_types_fmt[base_type] or "%p"  -- default fallback
end

function CVar:get_decl(type_str, var_name)
    type_str = type_str or self.vtype
    var_name = var_name or self.name

    if self:is_function(type_str) or type_str:find("%(%*%)") ~= nil then
      local start_pos, end_pos = type_str:find("%(%*[^)]*%)")
      return type_str:sub(1, end_pos - 1) .. " " .. var_name .. type_str:sub(end_pos)
    end
    if self:is_array(type_str) then
        local pos_array = type_str:find("%[.-%]")
        local base_type = type_str:sub(1, pos_array - 1)
        local array_size = type_str:sub(pos_array)
        return base_type .. " " .. var_name .. array_size
    end
    return type_str .. " " .. var_name
end


function CVar:__resolve_struct()
    local base_type = self:get_base_type()
    local struct_map = CVar.__data.struct_map[base_type]
    if struct_map then
        for i = 1, #struct_map do
            local pair = struct_map[i]
            local field = CVar:new(pair.type, pair.name)
            table.insert(self.struct_fields, field)
        end
    end
end


function CVar:new(vtype, name)
    local att = setmetatable({}, CVar)
    att.pdecl = att:get_decl()
    att.vtype = vtype
    att.name  = name

    att.ctype = att:__resolve_typedef(vtype)

    att.struct_fields = {}
    if self:is_struct() or self:is_union() then
        self:__resolve_struct()
    end
    
    return att
end


function CVar:__resolve_typedef(type_str, depth)
    depth = depth or 0
    if depth > 10 then
        return type_str -- prevent infinite recursion
    end

    type_str = type_str:trim()

    -- If the whole type_str is a typedef, resolve it directly
    if CVar.__data.typedef_map[type_str] then
        return self:__resolve_typedef(CVar.__data.typedef_map[type_str], depth + 1)
    end

    -- Otherwise, try to replace typedefs inside the string
    -- We replace words that match typedef names with their resolved type

    -- Pattern to find words (identifiers)
    local function replace_typedefs(word)
        if CVar.__data.typedef_map[word] then
            return self:__resolve_typedef(CVar.__data.typedef_map[word], depth + 1)
        else
            return word
        end
    end

    -- Replace all typedef words recursively
    local resolved = type_str:gsub("(%w+)", replace_typedefs)

    return resolved
end


function CVar:__get_type_qualifers(ctype)
    local qualifiers = {}
    local words = {}

    -- Split the input into words
    for word in ctype:gmatch("%S+") do
        if CVar.__data.type_qualifers[word] then
            table.insert(qualifiers, word)
        else
            table.insert(words, word)
        end
    end

    ctype = table.concat(words, " ")
    return qualifiers, ctype
end


function CVar:get_type_qualifers(ctype)
    ctype = ctype or self.ctype

    -- If the input is function type
    local ret_type, ptr_part, args = ctype:match("(.-)%(%s*%*%s*([^%(%)]*)%s*%)%s*(%b())")
    if ret_type and ptr_part and args then
        local qualifiers, ctype = self:__get_type_qualifers(ptr_part)
        ctype = string.format("%s(*%s)%s", ret_type, ctype, args)
        return qualifiers, ctype
    else
        return self:__get_type_qualifers(ctype)
    end
end

function CVar:get_type_for_struct(ctype)
    ctype = ctype or self.ctype
    ctype = CVar:remove_type_qualifers(ctype)

    if self:is_dynamic_array(ctype) then
        ctype = ctype:gsub("%[%]", "(*)")
    end

    return ctype
end



function CVar:remove_type_qualifers(decl)
    decl = decl or self.ctype
    _, decl = self:get_type_qualifers(decl)
    return decl
end


function CVar:get_array_dim(ctype)
    ctype = ctype or self.ctype

    local dims = {}
    if self:is_array(ctype) then

        -- Match [N] or [] — insert 0 for empty brackets
        for size in ctype:gmatch("%[(.-)%]") do
            local dim = tonumber(size)
            table.insert(dims, dim or 0)
        end

        -- Remove array parts to get the base ctype
        ctype = ctype:gsub("%[.-%]", ""):gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")

    end
    return dims, ctype
end




-- Return the type full derefenced : int** -> int, int(*)[3] -> int[3],  int[][3] -> int[3]
function CVar:get_ptr_count(ctype)
    ctype = ctype or self.ctype

    if self:is_function(ctype) then
        return 0, ctype
    end
    local ref_cnt = 0
    ctype = ctype:gsub("%s*%*%s*", function()
        ref_cnt = ref_cnt + 1
        return ""
    end)
    ctype = ctype:gsub("%s*%[%s*%]%s*", function()
        ref_cnt = ref_cnt + 1
        return ""
    end)
    return ref_cnt, ctype
end

return CVar
