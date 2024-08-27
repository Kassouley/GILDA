local Content = require("Content")
local ContentManager = require("ContentManager")

local function finalize_subcontent(arg)
    return arg:getContent()
end

local src = ContentManager:new({path = S._ATM_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._ATM_HDR_PATH, do_gen = true, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------

function src:generate_content(data)
    return S._WARNING_MSG..[[ 

#include "]]..S._ATM_HDR..[["
#include "]]..S._IF_HDR..[["
#include "]]..S._HANDLER_MGR_HDR..[["
#include "]]..S._ENV_HDR..[["
]]..data.include..[[ 

]]..S._ATM_INTERCEPT_TABLE_T..[[ ]]..S._ATM_INTERCEPT_TABLE_VAR..[[;

]]..S._ATM_ENABLE_DOMAIN_FUNC_DECL..[[ 
{
    bool is_function_enabled[]]..S._IF_API_ID_PREFIX..[[NB_FUNCTION] = { false };
    bool is_full_enabled = true;
    ]]..S._ENV_SET_ENABLED_FUNC..[[(is_function_enabled, &is_full_enabled);
]]..self.subcontents.enable_domain_block..[[
}

]]..S._ATM_DISABLE_DOMAIN_FUNC_DECL..[[ 
{
]]..self.subcontents.disable_domain_block..[[ 
}

]]..S._ATM_LOAD_TABLE_FUNC_DECL..[[ 
{
    void *handle = load_handle(]]..data.handle..[[);
]]..self.subcontents.load_table_block..[[ 
};
]]
end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src:init_subcontent("load_table_block", Content:new(1))
src:init_subcontent("enable_domain_block", Content:new(1))
src:init_subcontent("disable_domain_block", Content:new(1))

function src:generate_subcontents(f, _, _)
    self.subcontents["load_table_block"]:addfLine("%s(%s, %s, handle);", S._HM_HANDLE_MACRO, S._ATM_INTERCEPT_TABLE_VAR, f.fname)
    self.subcontents["enable_domain_block"]:addfLine("%s(%s, %s, %s);", S._HM_ENABLE_MACRO, S._ATM_INTERCEPT_TABLE_VAR, f.fname, S._DOMAIN_UPPER)
    self.subcontents["disable_domain_block"]:addfLine("%s(%s, %s);", S._HM_DISABLE_MACRO, S._ATM_INTERCEPT_TABLE_VAR, f.fname)
end

-----------------------------
-- HEADER CONTENT
-----------------------------

function hdr:generate_content(data)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_UPPER_VERB.."_TABLE_MGR_H" 
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..data.include..[[ 

]]..S._ATM_ENABLE_DOMAIN_FUNC_DECL..[[;
]]..S._ATM_DISABLE_DOMAIN_FUNC_DECL..[[;
]]..S._ATM_LOAD_TABLE_FUNC_DECL..[[;

]]..self.subcontents.typedef_block..[[

typedef struct {
]]..self.subcontents.api_tbl_block..[[ 
} ]]..S._ATM_INTERCEPT_TABLE_T..[[;
 
#endif //]] ..def_header
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------

hdr:init_subcontent("typedef_block", Content:new())
hdr:init_subcontent("api_tbl_block", Content:new(1))

function hdr:generate_subcontents(f, concat_param, _)
    self.subcontents["typedef_block"]:addfLine("typedef %s (*__%s_t)(%s);", f.ftype, f.fname, concat_param)

    self.subcontents["api_tbl_block"]:addfLine("__%s_t fn_%s;", f.fname, f.fname)
    self.subcontents["api_tbl_block"]:addfLine("__%s_t ptr_%s;", f.fname, f.fname)
end

return {src=src, hdr=hdr}
