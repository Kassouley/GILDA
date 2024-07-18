local itcp_tbl_mgr_hdr = {}

function itcp_tbl_mgr_hdr.content_1(MACRO_STRING, includes_str)
    return string.format([[
#ifndef %s
#define %s
%s
void %s();

struct %s {
]],
        MACRO_STRING._ITM_HEADDEF,
        MACRO_STRING._ITM_HEADDEF,
        includes_str,
        MACRO_STRING._ITM_LOAD_TABLE_DECL,
        MACRO_STRING._INTERCEPT_TABLE_T
    )
end

function itcp_tbl_mgr_hdr.content_2(MACRO_STRING, f)
    return string.format("\ttypeof(&%s) %s%s;\n", f.name, MACRO_STRING._INTERCEPT_FUNC_PREFIX, f.name)
end

function itcp_tbl_mgr_hdr.content_3()
    return "};\n#endif"
end

return itcp_tbl_mgr_hdr
