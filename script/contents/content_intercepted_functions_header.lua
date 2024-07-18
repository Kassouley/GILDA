local itcp_fnct_hdr = {}

function itcp_fnct_hdr.content_1(MACRO_STRING, includes_str)
    return string.format([[
#ifndef %s
#define %s
%s
]],
        MACRO_STRING._IF_HEADDEF,
        MACRO_STRING._IF_HEADDEF,
        includes_str
    )
end

function itcp_fnct_hdr.content_2a(MACRO_STRING)
    return string.format("// %s API ID enum\nenum %s {\n", MACRO_STRING._INTERCEPTOR_NAME_UPPER, MACRO_STRING._API_ID_T)
end

function itcp_fnct_hdr.content_2b(MACRO_STRING, f, i)
    return string.format("\t%s%s = %d,\n", MACRO_STRING._IF_FUN_ID_PREFIX, f.name, i)
end

function itcp_fnct_hdr.content_2c()
    return "};\n\n"
end

function itcp_fnct_hdr.content_3a(MACRO_STRING)
    return string.format("// Return %s API function name for a given ID\n%s %s(%s id) {\n\tswitch(id) {\n", MACRO_STRING._INTERCEPTOR_NAME_UPPER, MACRO_STRING._IF_GET_FUNAME_TYPE, MACRO_STRING._IF_GET_FUNAME_DECL, MACRO_STRING._API_ID_T)
end

function itcp_fnct_hdr.content_3b(MACRO_STRING, f)
    return string.format("\t\tcase %s%s : return \"%s\";\n", MACRO_STRING._IF_FUN_ID_PREFIX, f.name, f.name)
end

function itcp_fnct_hdr.content_3c()
    return "\t}\n\treturn NULL;\n}\n\n"
end

function itcp_fnct_hdr.content_4a(MACRO_STRING)
    return string.format("// %s API data\ntypedef struct %s {\n\tuint64_t corrId;\n\tbool is_enter;\n\tunion {\n", MACRO_STRING._INTERCEPTOR_NAME_UPPER, MACRO_STRING._API_DATA_S)
end

function itcp_fnct_hdr.content_4b()
    return "\t\tstruct {\n"
end

function itcp_fnct_hdr.content_4c(arg)
    return "\t\t\t" .. arg .. ";\n"
end

function itcp_fnct_hdr.content_4d(f)
    return "\t\t} " .. f.name .. ";\n"
end

function itcp_fnct_hdr.content_4e(MACRO_STRING)
    return "\t} args;\n} " .. MACRO_STRING._API_DATA_T .. ";\n\n"
end

function itcp_fnct_hdr.content_5()
    return "#endif"
end

return itcp_fnct_hdr
