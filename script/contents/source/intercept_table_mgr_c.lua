local itcp_tbl_mgr_src = {}

function itcp_tbl_mgr_src.content(includes_str, handler, subcontent)
    return string.format([[
#include "%s"
#include "handler_manager.h"
%s
%s %s;

void %s()
{
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
        S:_ITM_HEAD(),
        includes_str,
        S:_INTERCEPT_TABLE_T(), S:_INTERCEPT_TABLE_VAR(),
        S:_ITM_ENABLE_DOMAIN_FUNC(),
        subcontent.enable_domain_block,
        S:_ITM_DISABLE_DOMAIN_FUNC(),
        subcontent.disable_domain_block,
        S:_ITM_LOAD_TABLE_FUNC(),
        handler,
        subcontent.load_table_block
    )
end

function itcp_tbl_mgr_src.handle_line(func_name)
    return string.format("\tHANDLE(%s, %s, handle);", S:_INTERCEPT_TABLE_VAR(), func_name)
end

function itcp_tbl_mgr_src.enable_domain_line(func_name)
    return string.format("\tSWITCH_FILTER(%s, %s, 1);", S:_INTERCEPT_TABLE_VAR(), func_name)
end

function itcp_tbl_mgr_src.disable_domain_line(func_name)
    return string.format("\tSWITCH_FILTER(%s, %s, 0);", S:_INTERCEPT_TABLE_VAR(), func_name)
end

return itcp_tbl_mgr_src
