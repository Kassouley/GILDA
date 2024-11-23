local ContentManager = require("ContentManager")
local Content = require("Content")

mangen_intercepted_function = setmetatable({}, ContentManager)
mangen_intercepted_function.__index = mangen_intercepted_function

function mangen_intercepted_function:new(options, template_path, output_path)
    local attribute = {
        file_name = S:STRING("DOMAIN").."_domain/"..S:STRING("IF_SRC"),
        is_sample = true,
        do_not_gen = (not options.force_mangen and true) or options.no_mangen,
        subcontents = {
            ["func_blk"] = Content:new()
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    if instance then setmetatable(instance, mangen_intercepted_function) end
    return instance
end

function mangen_intercepted_function:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <stdlib.h>
#include "]]..S:STRING("IF_HDR")..[["
#include "]]..S:STRING("INTERCEPTOR_HDR")..[["

]]..S:STRING("INCLUDE_STR")..[[ 

]]..self.subcontents.func_blk..[[ 

]]
end


function mangen_intercepted_function:generate_subcontents(f)
            if f.gen ~= "MANGEN" then return end
            local macro_call = string.format("GET_ARGS_VALUE_%s(%s)", f.fname, S:STRING("CB_API_DATA_VAR"))
            local content = Content:new()
--[[1]]     content:addfLine("%s i_%s(%s) {", f.ftype.vtype, f.fname, f.fdecl)
            content:increaseIndent()
--[[2]]     content:addfLine("%s* %s = (%s*)malloc(sizeof(%s));", S:STRING("I_API_DATA_T"), S:STRING("CB_API_DATA_VAR"), S:STRING("I_API_DATA_T"), S:STRING("I_API_DATA_T"))
            if f.fargs ~= "" and f.get_arg_before == true then
--[[3.5]]       content:addfLine("%s;", macro_call)
            end
--[[4]]     content:addfLine("%s(%s, %s%s, %s);", S:STRING("CB_OE_CALLBACK_FUNC"), S:STRING("DOMAIN_ID"), S:STRING("IF_API_ID_PREFIX"), f.fname, S:STRING("CB_API_DATA_VAR"))
            if f.ftype.ctype ~= "void" or f.ftype:is_generic_ptr() then
--[[5]]         content:addfLine(
                    "%s_FUNCTION_CALL_RET(%s, %s);", 
                    S:STRING("DOMAIN|upper"), f.ftype.vtype, f.fargs == "" and f.fname or f.fname..", "..f.fargs)
            else
--[[5]]         content:addfLine("%s_FUNCTION_CALL(%s)", S:STRING("DOMAIN|upper"), f.fargs == "" and f.fname or f.fname..", "..f.fargs)
            end
            if f.fargs ~= "" and f.get_arg_after == true then
--[[5.5]]       content:addfLine("%s;", macro_call)
            end
--[[7]]     content:addfLine("%s(%s, %s%s, %s);", S:STRING("CB_OX_CALLBACK_FUNC"), S:STRING("DOMAIN_ID"), S:STRING("IF_API_ID_PREFIX"), f.fname, S:STRING("CB_API_DATA_VAR"))
            if f.ftype.ctype ~= "void" or f.ftype:is_generic_ptr() then
--[[8]]         content:addfLine("return %s;", S:STRING("CB_API_RET_VAR"))
            else
--[[8]]         content:addLine("return;")
            end
            content:decreaseIndent()
--[[9]]     content:addLine("};\n")
            self.subcontents.func_blk:addfLine("%s", content:getContent())
end

return mangen_intercepted_function, "DOMAIN"
