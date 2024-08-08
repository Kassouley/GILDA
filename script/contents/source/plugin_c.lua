local plg_src = {}

function plg_src.content(subcontents)
    return S._SAMPLE_MSG..[[ 

#include "]]..S._ATM_HEAD..[["

]]
end

function plg_src.prcss_args_blk(decl, var, pointer_count)
    local print_statement = var.." = "
    if decl == "void" and pointer_count > 0 then
        print_statement = print_statement .. ("%p" .. (" -> %p"):rep(pointer_count - 1))
    elseif pointer_count > 0 then
        print_statement = print_statement .. ("%p" .. (" -> %p"):rep(pointer_count - 1) .. " -> " .. c_manager.c_types[decl])
    else
        print_statement = print_statement .. c_manager.c_types[decl]
    end
    return print_statement
end

return plg_src
