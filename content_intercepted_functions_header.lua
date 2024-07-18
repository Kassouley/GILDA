local itcp_fnct_hdr = {}

-- AUTOGEN CONTENT INTERCEPTED_FUNCTIONS HEADER --
function itcp_fnct_hdr.content_1(MACRO_STRING, includes_str)
    return  "#ifndef "..MACRO_STRING._IF_HEADDEF.."\n"..
            "#define "..MACRO_STRING._IF_HEADDEF.."\n\n"..
            includes_str
end

function itcp_fnct_hdr.content_2a(MACRO_STRING)
    return  "// "..MACRO_STRING._INTERCEPTOR_NAME_UPPER.." API ID enum\n"..
            "enum "..MACRO_STRING._API_ID_T.." {\n"
end

function itcp_fnct_hdr.content_2b(MACRO_STRING, f, i)
    return  "\t"..MACRO_STRING._IF_FUN_ID_PREFIX..f.name.." = "..i..",\n"
end

function itcp_fnct_hdr.content_2c()
    return  "};\n\n"
end

function itcp_fnct_hdr.content_3a(MACRO_STRING)
    return  "// Return "..MACRO_STRING._INTERCEPTOR_NAME_UPPER.." API function name for a given ID\n"..
            MACRO_STRING._IF_GET_FUNAME_TYPE.." "..MACRO_STRING._IF_GET_FUNAME_DECL.."("..MACRO_STRING._API_ID_T.." id) {\n"..
            "\tswitch(id) {\n"
end

function itcp_fnct_hdr.content_3b(MACRO_STRING, f)
    return "\t\tcase "..MACRO_STRING._IF_FUN_ID_PREFIX..f.name.." : return \""..f.name.."\";\n"
end

function itcp_fnct_hdr.content_3c()
    return  "\t}\n"..
            "\treturn NULL;\n"..
            "}\n\n"
end

function itcp_fnct_hdr.content_4a(MACRO_STRING)
    return  "// "..MACRO_STRING._INTERCEPTOR_NAME_UPPER.." API data\n"..
            "typedef struct "..MACRO_STRING._API_DATA_S.." {\n"..
            "\tuint64_t corrId;\n"..
            "\tbool is_enter;\n"..
            "\tunion {\n"
end

function itcp_fnct_hdr.content_4b()
    return "\t\tstruct {\n"
end

function itcp_fnct_hdr.content_4c(arg)
    return "\t\t\t"..arg..";\n"
end

function itcp_fnct_hdr.content_4d(f)
    return "\t\t} "..f.name..";\n"
end

function itcp_fnct_hdr.content_4e(MACRO_STRING)
    return  "\t} args;\n"..
            "} "..MACRO_STRING._API_DATA_T..";\n\n"
end

function itcp_fnct_hdr.content_5()
    return  "#endif"
end

return itcp_fnct_hdr