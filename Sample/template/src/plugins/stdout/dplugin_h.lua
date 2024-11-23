local ContentManager = require("ContentManager")
local Content = require("Content")
local common = require("common")

dplugin_h = setmetatable({}, ContentManager)
dplugin_h.__index = dplugin_h

function dplugin_h:new(options, template_path, output_path)
    local do_not_gen = false
    if options.plugin_gen == false then
        do_not_gen = true
    elseif options.plugin_gen and not (options.plugin_gen["stdout"] or options.plugin_gen["all"]) then
        do_not_gen = false
    end

    local attribute = {
        file_name = S:STRING("DPLG_HDR"),
        do_not_gen = do_not_gen,
        subcontents = {
            ["prcss_args_blk"] = Content:new()
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, dplugin_h)
    return instance
end

function dplugin_h:generate_content()
    local def_header = S:STRING("DOMAIN|upper").."_PLUGIN_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..S:STRING("PLG_OE_CALLBACK_FUNC_DECL")..[[;
]]..S:STRING("PLG_OX_CALLBACK_FUNC_DECL")..[[;
]]..S:STRING("PLG_PROCESS_FUNC_DECL")..[[;

]]..self.subcontents.prcss_args_blk..[[

#endif // ]]..def_header
end


local function get_plugin_block_for(cvar_list, fname, depth, comment_content, macro_content, parent_vname)
    local depth = depth or 0
    local parent_vname = parent_vname or ""
    local comment_content = comment_content or Content:new()
    local macro_content = macro_content or Content:new(1)
    local print_indent = string.rep("\\t", depth + 1)
    local comment_indent = string.rep("\t", depth + 1)

    for _, cvar in ipairs(cvar_list) do
        local vname = "args->"..fname.."."..cvar.name
        if parent_vname ~= "" then
            vname = parent_vname .. "." .. cvar.name
        end
        if cvar:is_array() and cvar.ctype ~= "string" then
            for _, _ in ipairs(cvar.dimensions) do
                vname=vname.."[0]"
            end
        end

        if cvar.ctype == "N/A" then
            comment_content:addfLine(
                "//%s%s %s (unknown);", 
                comment_indent, cvar.vtype, cvar.name)
            macro_content:addfLine(
                "printf(\"%s%s %s = N/A, try to update csv files\\n\"); \\", 
                print_indent, cvar.vtype, cvar.name)
        else
            if cvar:is_pointer() and depth == 0 then
                macro_content:addfLine(
                    "printf(\"%s%s %s = %s\", %s); \\", 
                    print_indent, cvar.vtype, cvar.name, "%p", vname)

                for i = 1, cvar.dyn_ref_cnt-1 do
                    macro_content:addfLine(
                        "if (%s%s != NULL) { \\", 
                        vname, i==1 and "" or "__ref.ptr"..i-1)
                    macro_content:increaseIndent()
                    macro_content:addfLine(
                        "printf(\"-> %s\", %s__ref.ptr%d); \\", 
                        "%p", vname, i)
                end

                if cvar:is_struct() or cvar:is_union() then 
                    comment_content:addfLine(
                        "//%s%s %s ({", 
                        comment_indent, cvar.vtype, cvar.name)
                    macro_content:addfLine(
                        "if (%s%s != NULL) { \\", 
                        vname, cvar.dyn_ref_cnt==1 and "" or "__ref.ptr"..cvar.dyn_ref_cnt-1)
                    macro_content:increaseIndent()
                    macro_content:addfLine("printf(\" -> {\\n\"); \\")
                    get_plugin_block_for(
                        cvar.struct_fields,
                        fname,
                        depth+1, 
                        comment_content, 
                        macro_content, 
                        vname.."__ref.val")
                    macro_content:addfLine(
                        "printf(\"%s}\\n\"); \\", print_indent)
                    macro_content:decreaseIndent()
                    macro_content:addLine("} else { printf(\"\\n\"); }; \\")
                    comment_content:addfLine(
                        "//%s});", comment_indent)
                elseif cvar.ctype ~= "void" then
                    comment_content:addfLine(
                        "//%s%s %s (%s);", 
                        comment_indent, cvar.vtype, cvar.name, cvar.ctype..("*"):rep(cvar.dyn_ref_cnt))
                    macro_content:addfLine(
                        "if (%s%s != NULL) { \\", 
                        vname, cvar.dyn_ref_cnt==1 and "" or "__ref.ptr"..cvar.dyn_ref_cnt-1)
                    macro_content:increaseIndent()
                    macro_content:addfLine("printf(\" -> %s\\n\", %s__ref.val); \\", cvar:get_format(), vname)
                    macro_content:decreaseIndent()
                    macro_content:addLine("} else { printf(\"\\n\"); }; \\")
                else 
                    comment_content:addfLine(
                        "//%s%s %s (%s);", 
                        comment_indent, cvar.vtype, cvar.name, cvar.ctype..("*"):rep(cvar.dyn_ref_cnt))
                    macro_content:addLine("printf(\"\\n\"); \\")
                end

                for i = 1, cvar.dyn_ref_cnt-1 do
                    macro_content:decreaseIndent()
                    macro_content:addLine("} else { printf(\"\\n\"); }; \\")
                end
                
            elseif not cvar:is_pointer() then
                if cvar:is_struct() or cvar:is_union() then 
                    comment_content:addfLine(
                        "//%s%s %s ({", 
                        comment_indent, cvar.vtype, cvar.name)
                    macro_content:addfLine(
                        "printf(\"%s%s %s = {\\n\"); \\", 
                        print_indent, cvar.vtype, cvar.name)
                    get_plugin_block_for(
                        cvar.struct_fields,
                        fname,
                        depth+1, 
                        comment_content, 
                        macro_content, 
                        ("*"):rep(cvar.dyn_ref_cnt)..vname)
                    comment_content:addfLine(
                        "//%s});", 
                        comment_indent)
                    macro_content:addfLine(
                        "printf(\"%s}\\n\"); \\", 
                        print_indent)
                elseif cvar.ctype ~= "void" then
                    comment_content:addfLine(
                        "//%s%s %s (%s);", 
                        comment_indent, cvar.vtype, cvar.name, cvar.ctype)
                    macro_content:addfLine(
                        "printf(\"%s%s %s = %s\\n\", %s); \\", 
                        print_indent, cvar.vtype, cvar.name, cvar:get_format(), vname)
                else
                    comment_content:addfLine(
                        "//%s%s %s (%s);", 
                        comment_indent, cvar.vtype, cvar.name, cvar.ctype)
                end
            end
        end
    end
    return macro_content:getContent(), comment_content:getContent()
end


function dplugin_h:generate_subcontents(f)
    local signature = common.get_function_signature(f)
    local macro_blk, comment_blk = get_plugin_block_for(signature, f.fname)
    self.subcontents["prcss_args_blk"]:addfLine("%s", comment_blk) 
    self.subcontents["prcss_args_blk"]:addfLine("#define PROCESS_ARGS_%s(args) { \\", f.fname) 
    self.subcontents["prcss_args_blk"]:addfLine("%s", macro_blk == "" and "\\" or macro_blk) 
    self.subcontents["prcss_args_blk"]:addLine("};\n")
end

return dplugin_h, "DOMAIN"
