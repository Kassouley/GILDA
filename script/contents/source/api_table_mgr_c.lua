local src = {}
local hdr = {}

src.path = S._ATM_SRC_PATH
hdr.path = S._ATM_HDR_PATH

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HEAD..[["
#include "]]..S._IF_HEAD..[["
#include "]]..S._HANDLER_MGR_HEAD..[["
#include "]]..S._ENV_HEAD..[["
]]..subcontents.include..[[ 

]]..S._INTERCEPT_TABLE_T..[[ ]]..S._INTERCEPT_TABLE_VAR..[[;

void ]]..S._ATM_ENABLE_DOMAIN_FUNC..[[()
{
    bool is_function_enabled[]]..S._API_ID_PREFIX..[[NB_FUNCTION] = { false };
    bool is_full_enabled = true;
    set_]]..S._DOMAIN..[[_]]..S._TOOLS_NAME_NOUN..[[_enabled(is_function_enabled, &is_full_enabled);
]]..subcontents.enable_domain_block..[[
}

void ]]..S._ATM_DISABLE_DOMAIN_FUNC..[[()
{
]]..subcontents.disable_domain_block..[[ 
}

void ]]..S._ATM_LOAD_TABLE_FUNC..[[ ()
{
    void *handle = load_handle("]]..subcontents.handler..[[");
]]..subcontents.load_table_block..[[
};
]]
end

function src.load_table_block(func_name)
    return string.format("\tHANDLE(%s, %s, handle);", S._INTERCEPT_TABLE_VAR, func_name)
end

function src.enable_domain_block(func_name)
    return string.format("\tENABLE_%s(%s, %s, %s);", S._TOOLS_NAME_UPPER_GERUND, S._INTERCEPT_TABLE_VAR, func_name, S._DOMAIN_UPPER)
end

function src.disable_domain_block(func_name)
    return string.format("\tDISABLE_%s(%s, %s);", S._TOOLS_NAME_UPPER_GERUND, S._INTERCEPT_TABLE_VAR, func_name)
end


-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr.content(subcontents)
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


function hdr.typedef_block(ftype, fname, concat_param)
    return string.format("typedef %s (*__%s_t)(%s);\n", ftype, fname, concat_param)
end

function hdr.api_tbl_block(func_name)
    return string.format([[
    __%s_t fn_%s;
    __%s_t ptr_%s;
]], func_name, func_name, 
    func_name, func_name)
end


return {src=src, hdr=hdr}
