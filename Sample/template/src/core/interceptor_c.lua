local ContentManager = require("ContentManager")
local Content = require("Content")

interceptor_c = setmetatable({}, ContentManager)
interceptor_c.__index = interceptor_c

function interceptor_c:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("INTERCEPTOR_SRC"),
        subcontents = {
            ["domain_name_block"] = Content:new(2),
            ["api_table_var_block"] = Content:new(),
            ["funame_block"] = Content:new(2),
            ["funid_block"] = Content:new(2),
            ["funaddr_block"] = Content:new(2),
            ["enable_case_block"] = Content:new(2),
            ["disable_case_block"] = Content:new(2),
            ["set_cb_block"] = Content:new(2),
            ["init_block"] = Content:new(1),
            ["fini_block"] = Content:new(1),
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, interceptor_c)
    return instance
end

function interceptor_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <stdio.h>
#include "]]..S:STRING("INTERCEPTOR_HDR")..[["

]]..self.subcontents.api_table_var_block..[[ 

]]..S:STRING("I_GET_DOMAIN_FUNC_DECL")..[[ 
{
	switch(domain) {
]]..self.subcontents.domain_name_block..[[ 
		default : return "Unknown domain";
	}
	return "Unknown domain";
}

]]..S:STRING("I_GET_FUNAME_FUNC_DECL")..[[ 
{
    switch (domain) {
]]..self.subcontents.funame_block..[[ 
        default: break;
    }
}

]]..S:STRING("I_GET_FUNID_FUNC_DECL")..[[ 
{
    switch (domain) {
]]..self.subcontents.funid_block..[[ 
        default: break;
    }
}

]]..S:STRING("I_GET_FUNADDR_FUNC_DECL")..[[ 
{
    switch (domain) {
]]..self.subcontents.funaddr_block..[[ 
        default: break;
    }
}

]]..S:STRING("I_ENABLE_DOMAIN_FUNC_DECL")..[[ 
{
    switch (domain) {
]]..self.subcontents.enable_case_block..[[ 
        default: return ]]..S:STATUS("UNKNOWN_DOMAIN")..[[;
    }
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("I_DISABLE_DOMAIN_FUNC_DECL")..[[ 
{
    switch (domain) {
]]..self.subcontents.disable_case_block..[[ 
        default: return ]]..S:STATUS("UNKNOWN_DOMAIN")..[[;
    }
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("I_SET_CALLBACK_FUNC_DECL")..[[ 
{
    switch (domain) {
]]..self.subcontents.set_cb_block..[[ 
        default: return ]]..S:STATUS("UNKNOWN_DOMAIN")..[[;
    }
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("I_INIT_FUNC_DECL")..[[ 
{
    INIT_LOGGER();
    init_id_system();
    ]]..S:STRING("I_STATUS_TYPE")..[[ status = ]]..S:STATUS("SUCCESS")..[[;
]]..self.subcontents.init_block..[[ 
    printf("Profiler initialized.\n");
    return status;
}

]]..S:STRING("I_FINI_FUNC_DECL")..[[ 
{
    CLOSE_LOGGER();
    cleanup_id_system();
    ]]..S:STRING("I_STATUS_TYPE")..[[ status = ]]..S:STATUS("SUCCESS")..[[;
]]..self.subcontents.fini_block..[[ 
    printf("Profiler finalized.\n");
    return status;
}

]]
end


function interceptor_c:generate_subcontents()
    self.subcontents.domain_name_block:addfLine("case %s: return \"%s\";", S:STRING("DOMAIN_ID"), S:STRING("DOMAIN_ID"))
    
    self.subcontents.api_table_var_block:addfLine(
        "%s %s;", 
        S:STRING("ATM_API_TABLE_T"), S:STRING("DOMAIN_API_TABLE_VAR"))
    
    self.subcontents.funaddr_block:addfLine(
        "case %s:\n\t\t\treturn %s(funid);", 
        S:STRING("DOMAIN_ID"), S:STRING("IF_GET_FUNADDR_FUNC"))
            
    self.subcontents.funame_block:addfLine(
        "case %s:\n\t\t\treturn %s(funid);", 
        S:STRING("DOMAIN_ID"), S:STRING("IF_GET_FUNAME_FUNC"))
             
    self.subcontents.funid_block:addfLine(
        "case %s:\n\t\t\treturn %s(funame);", 
        S:STRING("DOMAIN_ID"), S:STRING("IF_GET_FUNID_FUNC"))
        
    self.subcontents.enable_case_block:addfLine(
        "case %s:\n\t\t\treturn %s(&%s, %s);", 
        S:STRING("DOMAIN_ID"), S:STRING("ATM_ENABLE_FUNC"), S:STRING("DOMAIN_API_TABLE_VAR"), S:STRING("DOMAIN_FILTER_ENV_VAR"))
    
    self.subcontents.disable_case_block:addfLine(
        "case %s:\n\t\t\treturn %s(&%s);", 
        S:STRING("DOMAIN_ID"), S:STRING("ATM_DISABLE_FUNC"), S:STRING("DOMAIN_API_TABLE_VAR"))
        
    self.subcontents.set_cb_block:addfLine("case %s:\n\t\t\treturn %s(callback_handler);", S:STRING("DOMAIN_ID"), S:STRING("CB_SET_CALLBACK_FUNC"))

    self.subcontents.init_block:addfLine(
        "status = %s(%s, &%s, %sNB_FUNCTION);", 
        S:STRING("ATM_INIT_FUNC"), S:STRING("DOMAIN_ID"), S:STRING("DOMAIN_API_TABLE_VAR"), S:STRING("IF_API_ID_PREFIX"))
    self.subcontents.init_block:addfLine(
        "if (status != %s) return status;", S:STATUS("SUCCESS"))
    self.subcontents.init_block:addfLine(
        "status = %s(&%s, \"%s\");", 
        S:STRING("ATM_POPU_FUNC"), S:STRING("DOMAIN_API_TABLE_VAR"), S:STRING("HANDLE_PATH"))
    self.subcontents.init_block:addfLine(
        "if (status != %s) return status;", S:STATUS("SUCCESS"))
        
        
    self.subcontents.fini_block:addfLine(
        "status = %s(&%s);", 
        S:STRING("ATM_FINI_FUNC"), S:STRING("DOMAIN_API_TABLE_VAR"))
    self.subcontents.fini_block:addfLine(
        "if (status != %s) return status;", S:STATUS("SUCCESS"))
end

return interceptor_c, "COMMON"