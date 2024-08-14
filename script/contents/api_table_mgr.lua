local src = {}
local hdr = {}

src.kpath = "_ATM_SRC_PATH"
hdr.kpath = "_ATM_HDR_PATH"

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HDR..[["
#include "]]..S._IF_HDR..[["
#include "]]..S._HANDLER_MGR_HDR..[["
#include "]]..S._ENV_HDR..[["
]]..subcontents.include..[[ 

]]..S._ATM_INTERCEPT_TABLE_T..[[ ]]..S._ATM_INTERCEPT_TABLE_VAR..[[;

]]..S._ATM_ENABLE_DOMAIN_FUNC_DECL..[[ 
{
    bool is_function_enabled[]]..S._IF_API_ID_PREFIX..[[NB_FUNCTION] = { false };
    bool is_full_enabled = true;
    ]]..S._ENV_SET_ENABLED_FUNC..[[(is_function_enabled, &is_full_enabled);
]]..subcontents.enable_domain_block..[[
}

]]..S._ATM_DISABLE_DOMAIN_FUNC_DECL..[[ 
{
]]..subcontents.disable_domain_block..[[ 
}

]]..S._ATM_LOAD_TABLE_FUNC_DECL..[[ 
{
    void *handle = load_handle("]]..subcontents.handler..[[");
]]..subcontents.load_table_block..[[
};
]]
end

function src.load_table_block(func_name)
    return "\t"..S._HM_HANDLE_MACRO.."("..S._ATM_INTERCEPT_TABLE_VAR..", "..func_name..", handle);"
end

function src.enable_domain_block(func_name)
    return "\t"..S._HM_ENABLE_MACRO.."("..S._ATM_INTERCEPT_TABLE_VAR..", "..func_name..", "..S._DOMAIN_UPPER..");"
end

function src.disable_domain_block(func_name)
    return "\t"..S._HM_DISABLE_MACRO.."("..S._ATM_INTERCEPT_TABLE_VAR..", "..func_name..");"
end


-----------------------------
-- HEADER CONTENT
-----------------------------

function hdr.content(subcontents)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_UPPER_VERB.."_TABLE_MGR_H" 
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..subcontents.include..[[ 

]]..S._ATM_ENABLE_DOMAIN_FUNC_DECL..[[;
]]..S._ATM_DISABLE_DOMAIN_FUNC_DECL..[[;
]]..S._ATM_LOAD_TABLE_FUNC_DECL..[[;

]]..subcontents.typedef_block..[[

typedef struct {
]]..subcontents.api_tbl_block..[[ 
} ]]..S._ATM_INTERCEPT_TABLE_T..[[;
 
#endif //]] ..def_header
end


function hdr.typedef_block(ftype, fname, concat_param)
    return string.format("typedef %s (*__%s_t)(%s);\n", ftype, fname, concat_param)
end

function hdr.api_tbl_block(func_name)
    return string.format([[
    __%s_t fn_%s;
    __%s_t ptr_%s;
]], func_name, func_name, 
    func_name, func_name)
end


return {src=src, hdr=hdr}
