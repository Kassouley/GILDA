local itcp_tbl_mgr_src = {}

function itcp_tbl_mgr_src.content(subcontent, includes_str, handler)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HEAD..[["
#include "]]..S._IF_HEAD..[["
#include "]]..S._HANDLER_MGR_HEAD..[["
#include "]]..S._ENV_HEAD..[["
]]..includes_str..[[
]]..S._INTERCEPT_TABLE_T..[[ ]]..S._INTERCEPT_TABLE_VAR..[[;

void ]]..S._ATM_ENABLE_DOMAIN_FUNC..[[()
{
    bool is_function_enabled[]]..S._API_ID_PREFIX..[[NB_FUNCTION] = { false };
    bool is_full_enabled = true;
    set_]]..S._DOMAIN..[[_]]..S._TOOLS_NAME_NOUN..[[_enabled(is_function_enabled, &is_full_enabled);
]]..subcontent.enable_domain_block..[[
}

void ]]..S._ATM_DISABLE_DOMAIN_FUNC..[[()
{
]]..subcontent.disable_domain_block..[[	
}

void ]]..S._ATM_LOAD_TABLE_FUNC..[[ ()
{
    void *handle = load_handle("]]..handler..[[");
]]..subcontent.load_table_block..[[
};
]]
end

function itcp_tbl_mgr_src.load_table_block(func_name)
    return string.format("\tHANDLE(%s, %s, handle);", S._INTERCEPT_TABLE_VAR, func_name)
end

function itcp_tbl_mgr_src.enable_domain_block(func_name)
    return string.format("\tENABLE_%s(%s, %s, %s);", S._TOOLS_NAME_UPPER_GERUND, S._INTERCEPT_TABLE_VAR, func_name, S._DOMAIN_UPPER)
end

function itcp_tbl_mgr_src.disable_domain_block(func_name)
    return string.format("\tDISABLE_%s(%s, %s);", S._TOOLS_NAME_UPPER_GERUND, S._INTERCEPT_TABLE_VAR, func_name)
end

return itcp_tbl_mgr_src
