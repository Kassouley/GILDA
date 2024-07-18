local itcp_tbl_mgr_src = {}

function itcp_tbl_mgr_src.content_1(MACRO_STRING, includes_str, handler)
    return string.format([[
#include "%s"
#include "%s"
%s
%s %s;

void %s() {
    void *handle = load_handle("%s");
]],
        MACRO_STRING._ITM_HEAD,
        MACRO_STRING._HANDLE_MGR_HEAD,
        includes_str,
        MACRO_STRING._INTERCEPT_TABLE_T, MACRO_STRING._INTERCEPT_TABLE_DECL,
        MACRO_STRING._ITM_LOAD_TABLE_DECL,
        handler
    )
end

function itcp_tbl_mgr_src.content_2(MACRO_STRING, f)
    return string.format("\tHANDLE(%s, %s, handle);\n", MACRO_STRING._INTERCEPT_TABLE_DECL, f.name)
end

function itcp_tbl_mgr_src.content_3()
    return "};\n\n"
end

return itcp_tbl_mgr_src
