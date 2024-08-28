local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._INTERCEPTOR_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._INTERCEPTOR_HDR_PATH, do_gen = true, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src:generate_content()
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._LOGGER_HDR..[["

]]..S._I_ENABLE_DOMAIN_FUNC_DECL..[[
{
    switch (domain) {
]]..self.subcontents.enable_case_block..[[ 
        default: break;
    }
}

]]..S._I_DISABLE_DOMAIN_FUNC_DECL..[[ 
{
    switch (domain) {
]]..self.subcontents.disable_case_block..[[ 
        default: break;
    }
}

]]..S._I_INIT_FUNC_DECL..[[
{
    ]]..S._LOG_INIT_MACRO..[[();
    ]]..S._CID_INIT_FUNC..[[();
]]..self.subcontents.load_block..[[ 
    fprintf(stderr, "Profiler initialized.\n");
}

]]..S._I_FINI_FUNC_DECL..[[
{
    ]]..S._LOG_FINI_MACRO..[[();
    ]]..S._CID_FINI_FUNC..[[();
    fprintf(stderr, "Profiler finalized.\n");
}

]]
end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src:init_subcontent("enable_case_block", Content:new(2))
src:init_subcontent("disable_case_block", Content:new(2))
src:init_subcontent("load_block", Content:new(1))

function src:generate_subcontents()
    self.subcontents.enable_case_block:addfLine("case %s: %s(); break;", S._DOMAIN_ID, S._ATM_ENABLE_DOMAIN_FUNC)
    self.subcontents.disable_case_block:addfLine("case %s: %s(); break;", S._DOMAIN_ID, S._ATM_DISABLE_DOMAIN_FUNC)
    self.subcontents.load_block:addfLine("%s();", S._ATM_LOAD_TABLE_FUNC)
end

-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr:generate_content()
    local def_header = S._TOOLS_NAME_UPPER.."_H"
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..self.subcontents.include_block..[[ 
#include "]]..S._ENV_HDR..[["
#include "]]..S._CID_HDR..[["

typedef enum {
]]..self.subcontents.enum_block..[[ 
    ]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN
} ]]..S._I_DOMAIN_T..[[;

]]..S._I_GET_DOMAIN_FUNC_DECL..[[
{
	switch(domain) {
]]..self.subcontents.domain_name_block..[[ 
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

-----------------------------
-- HEADER SUBCONTENT
-----------------------------

hdr:init_subcontent("domain_name_block", Content:new(2))
hdr:init_subcontent("include_block", Content:new())
hdr:init_subcontent("enum_block", Content:new(1))

function hdr:generate_subcontents()
    self.subcontents.domain_name_block:addfLine("case %s: return \"%s\";", S._DOMAIN_ID, S._DOMAIN_ID)

    self.subcontents.include_block:addfLine("#include \"%s\"", S._CB_HDR)
    self.subcontents.include_block:addfLine("#include \"%s\"", S._ATM_HDR)
    self.subcontents.include_block:addfLine("#include \"%s\"\n", S._IF_HDR)

    self.subcontents.enum_block:addfLine("%s,", S._DOMAIN_ID)
end

return {src=src, hdr=hdr}
