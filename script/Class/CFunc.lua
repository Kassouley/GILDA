local CVar = require("CVar")

local CFunc = {}
CFunc.__index = CFunc

function CFunc:new(attribute)
    local self = setmetatable({}, CFunc)

    self.gen    = attribute[1]
    self.capture_point = attribute[2]
    self.ftype  = CVar:new(attribute[3] .. " retval")
    self.fname  = attribute[4]
    
    self.fparam = {}
    if attribute[5] == "void" or attribute[5] == nil then
        self.has_no_param = true
    else
        -- Extract params
        for i = 5, #attribute do
            local fparam = CVar:new(attribute[i])
            table.insert(self.fparam, fparam)
        end
    end
    return self
end


function CFunc:return_is_ptr()
    return self.ftype:is_ptr()
end


function CFunc:params_has_ptr()
    for _, param in ipairs(self.fparam) do
        if param:is_ptr() then
            return true
        end
    end
    return false
end


function CFunc:uses_pointer()
    return self:params_has_ptr() or self:return_is_ptr()
end


function CFunc:is_void()
    return self.ftype:is_void()
end


function CFunc:get_signature_elements()
    local t = {}
    for i, v in ipairs(self.fparam) do
        t[i] = v
    end
    if not self:is_void() or self.ftype:is_generic_ptr() then
        table.insert(t, self.ftype)
    end
    return t
end


function CFunc:get_fname(prefix, suffix)
    prefix = prefix or ""
    suffix = suffix or ""
    return prefix .. self.fname .. suffix
end


function CFunc:get_function_decl(prefix, suffix)
    return self.ftype.vtype .. " " .. self:get_fname(prefix, suffix) .. "(" .. self:get_fparams_string() .. ")"
end


function CFunc:capture_point_is_post_call()
    return self.capture_point == "ARGS_AFTER"
end


function CFunc:capture_point_is_pre_call()
    return self.capture_point == "ARGS_BEFORE"
end


function CFunc:get_fargs_string()
    local strings = {}
    for _, param in ipairs(self.fparam) do
        table.insert(strings, param.name)
    end
    return table.concat(strings, ", ")
end


function CFunc:get_fparams_string()
    local strings = {}
    for _, param in ipairs(self.fparam) do
        table.insert(strings, param.pdecl)
    end
    return table.concat(strings, ", ")
end
