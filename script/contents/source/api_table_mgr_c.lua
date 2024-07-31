local itcp_tbl_mgr_src = {}

function itcp_tbl_mgr_src.content(subcontent, includes_str, handler)
    return string.format([[
%s

#include "%s"
#include "%s"
#include "%s"
#include "%s"
%s
%s %s;

void %s()
{
    bool is_function_enabled[%sNB_FUNCTION] = { false };
    bool is_full_enabled = true;
    set_%s_%s_enabled(is_function_enabled, &is_full_enabled);
%s
}

void %s()
{
%s	
}

void %s() {
    void *handle = load_handle("%s");
%s
};
]],
        S._WARNING_MSG,
        S:_ATM_HEAD(),
        S:_IF_HEAD(),
        S:_HANDLER_MGR_HEAD(),
        S:_ENV_HEAD(),
        includes_str,
        S:_INTERCEPT_TABLE_T(), S:_INTERCEPT_TABLE_VAR(),
        S:_ATM_ENABLE_DOMAIN_FUNC(),
        S:_API_ID_PREFIX(),
        S:_DOMAIN(), S._TOOLS_NAME_NOUN,
        subcontent.enable_domain_block,
        S:_ATM_DISABLE_DOMAIN_FUNC(),
        subcontent.disable_domain_block,
        S:_ATM_LOAD_TABLE_FUNC(),
        handler,
        subcontent.load_table_block
    )
end

function itcp_tbl_mgr_src.load_table_block(func_name)
    return string.format("\tHANDLE(%s, %s, handle);", S:_INTERCEPT_TABLE_VAR(), func_name)
end

function itcp_tbl_mgr_src.enable_domain_block(func_name)
    return string.format("\tENABLE_%s(%s, %s, %s);", S._TOOLS_NAME_UPPER_GERUND, S:_INTERCEPT_TABLE_VAR(), func_name, S:_DOMAIN_UPPER())
end

function itcp_tbl_mgr_src.disable_domain_block(func_name)
    return string.format("\tDISABLE_%s(%s, %s);", S._TOOLS_NAME_UPPER_GERUND, S:_INTERCEPT_TABLE_VAR(), func_name)
end

return itcp_tbl_mgr_src
