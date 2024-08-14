local src = {}
local hdr = {}

src.kpath = "_INTERCEPTOR_SRC_PATH"
hdr.kpath = "_INTERCEPTOR_HDR_PATH"

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._LOGGER_HDR..[["

]]..S._I_ENABLE_DOMAIN_FUNC_DECL..[[
{
    switch (domain) {
]]..subcontents.enable_case_block..[[ 
        default: break;
    }
}

]]..S._I_DISABLE_DOMAIN_FUNC_DECL..[[ 
{
    switch (domain) {
]]..subcontents.disable_case_block..[[ 
        default: break;
    }
}

]]..S._I_INIT_FUNC_DECL..[[
{
    ]]..S._LOG_INIT_MACRO..[[();
    ]]..S._CID_INIT_FUNC..[[();
]]..subcontents.load_block..[[ 
    printf("Profiler initialized.\n");
}

]]..S._I_FINI_FUNC_DECL..[[
{
    ]]..S._LOG_FINI_MACRO..[[();
    ]]..S._CID_FINI_FUNC..[[();
    printf("Profiler finalized.\n");
}

]]
end

function src.enable_case_block()
    return "\t\tcase "..S._DOMAIN_ID..": "..S._ATM_ENABLE_DOMAIN_FUNC.."(); break;"
end

function src.disable_case_block()
    return "\t\tcase "..S._DOMAIN_ID..": "..S._ATM_DISABLE_DOMAIN_FUNC.."(); break;"
end

function src.load_block()
    return "\t"..S._ATM_LOAD_TABLE_FUNC.."();"
end

-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr.content(subcontents)
    local def_header = S._TOOLS_NAME_UPPER.."_H"
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..subcontents.include_block..[[ 
#include "]]..S._ENV_HDR..[["
#include "]]..S._CID_HDR..[["

typedef enum {
]]..subcontents.enum_block..[[,
    ]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN
} ]]..S._I_DOMAIN_T..[[;

]]..S._I_GET_DOMAIN_FUNC_DECL..[[
{
	switch(domain) {
]]..subcontents.domain_name_block..[[ 
		default : return "Unknown domain";
	}
	return "Unknown domain";
}

]]..S._I_ENABLE_DOMAIN_FUNC_DECL..[[;
]]..S._I_DISABLE_DOMAIN_FUNC_DECL..[[;
]]..S._I_INIT_FUNC_DECL..[[;
]]..S._I_FINI_FUNC_DECL..[[;

#endif // ]]..def_header
end

function hdr.domain_name_block()
    return "\t\tcase "..S._DOMAIN_ID..": return \""..S._DOMAIN_ID.."\";"
end

function hdr.include_block()
    return "#include \""..S._CB_HDR.."\"\n"..
           "#include \""..S._ATM_HDR.."\"\n"..
           "#include \""..S._IF_HDR.."\"\n"
end

function hdr.enum_block()
    return "\t"..S._DOMAIN_ID
end

return {src=src, hdr=hdr}
