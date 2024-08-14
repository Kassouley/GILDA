local common = require("common")

local src = {}

function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HDR..[["
]]..subcontents.include..[[ 
extern ]]..S._ATM_INTERCEPT_TABLE_T..[[ ]]..S._ATM_INTERCEPT_TABLE_VAR..[[;

]]..subcontents.func_blk
end

function src.func_blk(ftype, fname, concat_pname, concat_param)
    if ftype ~= "void" then
        return string.format([[
%s %s(%s) { 
    return %s.ptr_%s(%s); 
}

]], 
            ftype, fname, concat_param,
            S._ATM_INTERCEPT_TABLE_VAR, fname, concat_pname
        )
    else
        return string.format([[
%s %s(%s) { 
    %s.ptr_%s(%s); 
}

]], 
            ftype, fname, concat_param,
            S._ATM_INTERCEPT_TABLE_VAR, fname, concat_pname
        )
    end
end

local src_auto =  common.deepcopy(src)
local src_man = src

src_auto.kpath = "_F_AUTO_SRC_PATH"
src_man.kpath = "_F_MAN_SRC_PATH"

return {auto=src_auto, man=src_man}
