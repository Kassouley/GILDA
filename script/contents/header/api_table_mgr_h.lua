local api_tbl_mgr_hdr = {}


function api_tbl_mgr_hdr.content(subcontent, includes_str)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_VERB.."_TABLE_MGR_H" 
    return ""..
           S._WARNING_MSG.."\n"..
           "\n"..
           "\n"..
           "#ifndef "..def_header.."\n"..
           "#define "..def_header.."\n"..
           "\n"..
           includes_str.."\n"..
           "\n"..
           "void "..S._ATM_LOAD_TABLE_FUNC.."();\n"..
           "void "..S._ATM_ENABLE_DOMAIN_FUNC.."();\n"..
           "void "..S._ATM_DISABLE_DOMAIN_FUNC.."();\n"..
           "\n"..
           subcontent.typedef_block.."\n"..
           "\n"..
           "typedef struct {\n"..
           subcontent.api_tbl_block.."\n"..
           "} "..S._INTERCEPT_TABLE_T..";\n"..
           "\n"..
           "#endif // "..def_header
end


function api_tbl_mgr_hdr.typedef_block(f)
    return string.format("typedef %s (*__%s_t)(%s);\n", f.return_type, f.name, table.concat(f.args, ", "))
end

function api_tbl_mgr_hdr.api_tbl_block(func_name)
    return string.format([[
    __%s_t fn_%s;
    __%s_t ptr_%s;
]], func_name, func_name, 
    func_name, func_name)
end

return api_tbl_mgr_hdr
