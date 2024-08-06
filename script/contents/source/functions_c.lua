local fnct_src = {}

function fnct_src.content(subcontent, includes_str)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HEAD..[["
]]..includes_str..[[ 
extern ]]..S._INTERCEPT_TABLE_T..[[ ]]..S._INTERCEPT_TABLE_VAR..[[;

]]..subcontent.func_blk
end

function fnct_src.func_blk(ftype, fname, fparam, concat_pname)
    if ftype ~= "void" then
        return string.format([[
%s %s(%s) { 
    return %s.ptr_%s(%s); 
}

]], 
            ftype, fname, fparam,
            S._INTERCEPT_TABLE_VAR, fname, concat_pname
        )
    else
        return string.format([[
%s %s(%s) { 
    %s.ptr_%s(%s); 
}

]], 
            ftype, fname, fparam,
            S._INTERCEPT_TABLE_VAR, fname, concat_pname
        )
    end
end

return fnct_src
