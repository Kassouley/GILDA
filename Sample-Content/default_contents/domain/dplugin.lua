local ContentManager = require("ContentManager")
local Content = require("Content")
local c_manager = require("c_manager")

local function finalize_subcontent(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._DPLG_SRC_PATH, do_gen = false, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._DPLG_HDR_PATH, do_gen = false, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------

function src:generate_content()
    return S._SAMPLE_MSG..[[ 

#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._DPLG_HDR..[["

]]..S._PLG_PROCESS_FUNC_DECL..[[ 
{
    switch(funid) {
]]..self.subcontents.case_block..[[ 
        default : break;
    }
}

]]
end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src:init_subcontent("case_block", Content:new(2))

function src:generate_subcontents(f, _, _)
    self.subcontents.case_block:addfLine("case %s%s : PROCESS_ARGS_%s(args); break;", S._IF_API_ID_PREFIX, f.fname, f.fname) 
end

-----------------------------
-- HEADER CONTENT
-----------------------------

function hdr:generate_content()
    local def_header = S._DOMAIN_UPPER.."_PLUGIN_H"
    return S._SAMPLE_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..S._PLG_PROCESS_FUNC_DECL..[[;

]]..self.subcontents.prcss_args_blk..[[

#endif // ]]..def_header
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------

hdr:init_subcontent("prcss_args_blk", Content:new())

local function prcss_args_blk_aux(fname, cparam, macro_content, comment_content, depth, parent_vname)
    local comment_content = comment_content or Content:new()
    local macro_content = macro_content or Content:new(1)
    local depth = depth or 0
    local parent_vname = parent_vname or ""
    local print_indent = string.rep("\\t", depth + 1)
    local comment_indent = string.rep("\t", depth + 1)

    if parent_vname ~= "" then
        if parent_vname:find("*") then
            parent_vname = "("..parent_vname..")"
        end
    end
    for _, param in ipairs(cparam) do
        local ptype = param.ptype
        local ctype = param.ctype
        local pname = param.pname
        local nb_ptr = param.ptr
        local kind = param.kind
        local vname = "args->"..fname.."."..pname
        if parent_vname ~= "" then
            vname = parent_vname .. "." .. pname
        end
   
        if ctype == "N/A" then
            comment_content:addfLine("//%s%s %s (unknown);", comment_indent, ptype, pname)
            macro_content:addfLine("printf(\"%s%s %s = N/A, try to update csv files\\n\"); \\", print_indent, ptype, pname)
        else
            if nb_ptr > 0 then
                local vname_w_ptr = "*"..vname
                local ptr = vname
                if type(ctype) == "table" then 
                    ptype = kind .. " " .. ptype
                end
                macro_content:addfLine("printf(\"%s%s %s = %s\", %s); \\", print_indent, ptype, pname, "%p", ptr)
                
                for i = 1, nb_ptr-1 do
                    macro_content:addfLine("if (%s != NULL) { \\", ptr)
                    macro_content:increaseIndent()
                    macro_content:addfLine("printf(\"-> %s\", %s); \\", "%p", vname_w_ptr)
                    ptr = vname_w_ptr
                    vname_w_ptr = "*" .. vname_w_ptr
                end

                if type(ctype) == "table" then 
                    comment_content:addfLine("//%s%s %s ({", comment_indent, ptype, pname)
                    macro_content:addfLine("if (%s != NULL) { \\", ptr)
                    macro_content:increaseIndent()
                    macro_content:addfLine("printf(\" -> {\\n\"); \\")
                    prcss_args_blk_aux(fname, ctype, macro_content, comment_content, depth+1, ("*"):rep(nb_ptr)..vname)
                    macro_content:addfLine("printf(\"%s}\\n\"); \\", print_indent)
                    macro_content:decreaseIndent()
                    macro_content:addLine("} else { printf(\"\\n\"); }; \\")
                    comment_content:addfLine("//%s});", comment_indent)
                elseif ctype ~= "void" then
                    comment_content:addfLine("//%s%s %s (%s);", comment_indent, ptype, pname, ctype..("*"):rep(nb_ptr))
                    macro_content:addfLine("if (%s != NULL) { \\", ptr)
                    macro_content:increaseIndent()
                    macro_content:addfLine("printf(\" -> %s\\n\", %s); \\", c_manager.c_types[ctype], vname_w_ptr)
                    macro_content:decreaseIndent()
                    macro_content:addLine("} else { printf(\"\\n\"); }; \\")
                else 
                    macro_content:addLine("printf(\"\\n\"); \\")
                    comment_content:addfLine("//%s%s %s (%s);", comment_indent, ptype, pname, ctype..("*"):rep(nb_ptr))
                end

                for i = 1, nb_ptr-1 do
                    macro_content:decreaseIndent()
                    macro_content:addLine("} else { printf(\"\\n\"); }; \\")
                end
                
            else
                if type(ctype) == "table" then 
                    comment_content:addfLine("//%s%s %s ({", comment_indent, ptype, pname)
                    macro_content:addfLine("printf(\"%s%s %s %s = {\\n\"); \\", print_indent, kind, ptype, pname)
                    prcss_args_blk_aux(fname, ctype, macro_content, comment_content, depth+1, ("*"):rep(nb_ptr)..vname)
                    macro_content:addfLine("printf(\"%s}\\n\"); \\", print_indent)
                    comment_content:addfLine("//%s});", comment_indent)
                elseif ctype ~= "void" then
                    comment_content:addfLine("//%s%s %s (%s);", comment_indent, ptype, pname, ctype)
                    macro_content:addfLine("printf(\"%s%s %s = %s\\n\", %s); \\", print_indent, ptype, pname, c_manager.c_types[ctype], vname)
                else
                    comment_content:addfLine("//%s%s %s (%s);", comment_indent, ptype, pname, ctype)
                end
            end
        end
    end
    return macro_content:getContent(), comment_content:getContent()
end

function hdr:generate_subcontents(f, _, cparam)
    local macro_blk, comment_blk = prcss_args_blk_aux(f.fname, cparam)
    self.subcontents.prcss_args_blk:addfLine("%s", comment_blk) 
    self.subcontents.prcss_args_blk:addfLine("#define PROCESS_ARGS_%s(args) { \\", f.fname) 
    self.subcontents.prcss_args_blk:addfLine("%s", macro_blk == "" and "\\" or macro_blk) 
    self.subcontents.prcss_args_blk:addLine("};\n") 
end

return {src=src, hdr=hdr}
