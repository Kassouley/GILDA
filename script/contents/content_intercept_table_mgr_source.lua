local itcp_tbl_mgr_src = {}

function itcp_tbl_mgr_src.content(includes_str, handler, subcontent)
    return string.format([[
#include "%s"
#include "handler_manager.h"
%s
%s %s;

void %s() {
    void *handle = load_handle("%s");
%s
};
]],
        S:_ITM_HEAD(),
        includes_str,
        S:_INTERCEPT_TABLE_T(), S:_INTERCEPT_TABLE_VAR(),
        S:_ITM_LOAD_TABLE_FUNC(),
        handler,
        subcontent.load_table_block
    )
end

function itcp_tbl_mgr_src.handle_line(func_name)
    return string.format("\tHANDLE(%s, %s, handle);\n", S:_INTERCEPT_TABLE_VAR(), func_name)
end

return itcp_tbl_mgr_src
