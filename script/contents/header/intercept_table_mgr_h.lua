local itcp_tbl_mgr_hdr = {}

function itcp_tbl_mgr_hdr.content(includes_str, subcontent)
    local def_header = string.format(
        "%s_%s_TABLE_MGR_H", S:_DOMAIN_UPPER(), S._TOOLS_NAME_LOWER_VERB
    )
    return string.format([[
#ifndef %s
#define %s
%s
void %s();

%s

typedef struct {
%s
} %s;

#endif
]],
        def_header,
        def_header,
        includes_str,
        S:_ITM_LOAD_TABLE_FUNC(),
        subcontent.typedef_block,
        subcontent.intercept_table_block,
        S:_INTERCEPT_TABLE_T()
    )
end


function itcp_tbl_mgr_hdr.typedef_line(f)
    return string.format("typedef %s (*__%s_t)(%s);\n", f.return_type, f.name, table.concat(f.args, ", "))
end

function itcp_tbl_mgr_hdr.itcp_tbl_line(func_name)
    return string.format([[
    __%s_t fn_%s;
    __%s_t ptr_%s;
]], func_name, func_name, 
    func_name, func_name)
end

return itcp_tbl_mgr_hdr
