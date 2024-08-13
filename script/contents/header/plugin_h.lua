local plg_hdr = {}

local c_manager = require("c_manager")

function plg_hdr.content(subcontents)
    local def_header = S._DOMAIN_UPPER.."_PLUGIN_H"
    return S._SAMPLE_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

void 
process_]]..S._DOMAIN..[[_args_for(]]..S._API_ID_T..[[ funid, const ]]..S._API_ARGS_T..[[* args);

]]..subcontents.prcss_args_blk..[[

#endif // ]]..def_header
end

local function prcss_args_blk_aux(fname, cparam, content, depth, parent_vname)
    content = content or {}
    depth = depth or 0
    parent_vname = parent_vname or ""
    local indent = string.rep("\\t", depth + 1)

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
   
        if type(ctype) == "table" then 
            table.insert(content, string.format(
                "\tprintf(\"%s%s %s %s:\\n\"); \\",
                indent, kind, ptype, pname))
            -- Pass the current pname (struct name) as parent_vname in recursive call
            prcss_args_blk_aux(fname, ctype, content, depth+1, ("*"):rep(nb_ptr)..vname)
        elseif ctype == "N/A" then
            table.insert(content, string.format(
                "\tprintf(\"%sctype non available for %s %s, try to update csv files\\n\"); \\",
                indent, ptype, pname))
        else
            local format = pname .. " = "
            local args = {}

            local vname_w_ptr = vname
            if nb_ptr > 0 then
                format = format .. ("%p" .. (" -> %p"):rep(nb_ptr - 1))

                for i = 1, nb_ptr do
                    table.insert(args, vname_w_ptr)
                    vname_w_ptr = "*" .. vname_w_ptr
                end

                if ctype ~= "void" then
                    format = format .. " -> " .. c_manager.c_types[ctype]
                    table.insert(args, vname_w_ptr)
                end
                
            else
                format = format .. c_manager.c_types[ctype]
                table.insert(args, vname)
            end
            table.insert(content, string.format(
                "\tprintf(\"%s%s %s\\n\", %s); \\",
                indent, ptype, format, table.concat(args, ", ")))
        end
    end
    return content
end


function plg_hdr.prcss_args_blk(fname, cparam)
    local prcss_args_blk = table.concat(prcss_args_blk_aux(fname, cparam), "\n")
    return string.format([[
#define PROCESS_ARGS_%s(args) { \
%s
};
]],
        fname,
        prcss_args_blk == "" and "\\" or prcss_args_blk
    )

end

return plg_hdr
