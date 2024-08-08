local api_tbl_mgr_hdr = {}


function api_tbl_mgr_hdr.content(subcontents)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_UPPER_VERB.."_TABLE_MGR_H" 
    return ""..
           S._WARNING_MSG.."\n"..
           "\n"..
           "\n"..
           "#ifndef "..def_header.."\n"..
           "#define "..def_header.."\n"..
           "\n"..
           subcontents.include.."\n"..
           "\n"..
           "void "..S._ATM_LOAD_TABLE_FUNC.."();\n"..
           "void "..S._ATM_ENABLE_DOMAIN_FUNC.."();\n"..
           "void "..S._ATM_DISABLE_DOMAIN_FUNC.."();\n"..
           "\n"..
           subcontents.typedef_block.."\n"..
           "\n"..
           "typedef struct {\n"..
           subcontents.api_tbl_block.."\n"..
           "} "..S._INTERCEPT_TABLE_T..";\n"..
           "\n"..
           "#endif // "..def_header
end


function api_tbl_mgr_hdr.typedef_block(ftype, fname, concat_param)
    return string.format("typedef %s (*__%s_t)(%s);\n", ftype, fname, concat_param)
end

function api_tbl_mgr_hdr.api_tbl_block(func_name)
    return string.format([[
    __%s_t fn_%s;
    __%s_t ptr_%s;
]], func_name, func_name, 
    func_name, func_name)
end

return api_tbl_mgr_hdr
