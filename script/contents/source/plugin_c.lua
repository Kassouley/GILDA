local plug_src = {}

function plug_src.content(subcontent, includes_str)
    return S._SAMPLE_MSG..[[ 

#include "]]..S._ATM_HEAD..[["
]]..includes_str..[[ 
extern ]]..S._INTERCEPT_TABLE_T..[[ ]]..S._INTERCEPT_TABLE_VAR..[[;

]]..subcontent.func_blk
end

function plug_src.prcss_args_blk(decl, var, pointer_count)
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

return plug_src
