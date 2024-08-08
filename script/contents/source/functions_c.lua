local fnct_src = {}

function fnct_src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HEAD..[["
]]..subcontents.include..[[ 
extern ]]..S._INTERCEPT_TABLE_T..[[ ]]..S._INTERCEPT_TABLE_VAR..[[;

]]..subcontents.func_blk
end

function fnct_src.func_blk(ftype, fname, concat_pname, concat_param)
    if ftype ~= "void" then
        return string.format([[
%s %s(%s) { 
    return %s.ptr_%s(%s); 
}

]], 
            ftype, fname, concat_param,
            S._INTERCEPT_TABLE_VAR, fname, concat_pname
        )
    else
        return string.format([[
%s %s(%s) { 
    %s.ptr_%s(%s); 
}

]], 
            ftype, fname, concat_param,
            S._INTERCEPT_TABLE_VAR, fname, concat_pname
        )
    end
end

return fnct_src
