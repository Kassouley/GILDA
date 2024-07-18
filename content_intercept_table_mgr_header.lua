local itcp_tbl_mgr_hdr = {}

-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER HEADER --
function itcp_tbl_mgr_hdr.content_1(MACRO_STRING, includes_str)
    return  "#ifndef "..MACRO_STRING._ITM_HEADDEF.."\n"..
            "#define "..MACRO_STRING._ITM_HEADDEF.."\n\n"..
            includes_str..
            "void "..MACRO_STRING._ITM_LOAD_TABLE_DECL.."();\n\n"..
            "struct "..MACRO_STRING._INTERCEPT_TABLE_T.." {\n"
end

function itcp_tbl_mgr_hdr.content_2(MACRO_STRING, f)
    return "\ttypeof(&"..f.name..") "..MACRO_STRING._INTERCEPT_FUNC_PREFIX..f.name..";\n"
end

function itcp_tbl_mgr_hdr.content_3()
    return  "};\n"..
            "#endif"
end

return itcp_tbl_mgr_hdr