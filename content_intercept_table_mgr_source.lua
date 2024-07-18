local itcp_tbl_mgr_src = {}

-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER SOURCE --
function itcp_tbl_mgr_src.content_1(MACRO_STRING, includes_str, handler)
    return  "#include \""..MACRO_STRING._ITM_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._HANDLE_MGR_HEAD.."\"\n"..
            includes_str..
            MACRO_STRING._INTERCEPT_TABLE_T.." "..MACRO_STRING._INTERCEPT_TABLE_DECL..";\n\n"..
            "void "..MACRO_STRING._ITM_LOAD_TABLE_DECL.."() {\n"..
            "\tvoid *handle = load_handle(\""..handler.."\");\n"
end

function itcp_tbl_mgr_src.content_2(MACRO_STRING, f)
    return "\tHANDLE("..MACRO_STRING._INTERCEPT_TABLE_DECL..", "..f.name..", handle);\n"
end

function itcp_tbl_mgr_src.content_3()
    return "};\n\n"
end
-- AUTOGEN CONTENT INTERCEPT_TABLE_MANAGER SOURCE --

return itcp_tbl_mgr_src