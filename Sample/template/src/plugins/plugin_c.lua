local ContentManager = require("ContentManager")
local Content = require("Content")

plugin_c = setmetatable({}, ContentManager)
plugin_c.__index = plugin_c

function plugin_c:new(options, template_path, output_path)
    local attribute = {
        file_name = S:STRING("PLG_SRC"),
        do_not_gen = not options.plugin_gen and true,
        subcontents = {
            ["include_block"] = Content:new(),
            ["init_block"] = Content:new(1),
            ["get_profile_cb_block"] = Content:new(2),
            ["struct_fields"] = Content:new(1)
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    if instance then setmetatable(instance, plugin_c) end
    return instance
end

function plugin_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <]]..S:STRING("INTERCEPTOR_HDR")..[[>
]]..self.subcontents.include_block..[[ 

typedef struct ]]..S:STRING("TOOLS_NAME")..[[_plugin_s {
]]..self.subcontents.struct_fields..[[ 
} ]]..S:STRING("PLG_STRUCT")..[[;

]]..S:STRING("PLG_INIT_FUNC_DECL")..[[ 
{
    ]]..S:STRING("I_STATUS_TYPE")..[[ status = ]]..S:STATUS("SUCCESS")..[[;
    if (plugin == NULL) return ]]..S:STATUS("INVALID_PTR")..[[;
    if (*plugin != NULL) return ]]..S:STATUS("PLUGIN_INIT")..[[;
    *plugin = (]]..S:STRING("PLG_STRUCT")..[[*)malloc(sizeof(]]..S:STRING("PLG_STRUCT")..[[));
    if (*plugin == NULL) return ]]..S:STATUS("MALLOC_FAILED")..[[;
]]..self.subcontents.init_block..[[ 
    return status;
}

]]..S:STRING("PLG_FINI_FUNC_DECL")..[[ 
{
    ]]..S:STRING("I_STATUS_TYPE")..[[ status = ]]..S:STATUS("SUCCESS")..[[;
    if (plugin == NULL) return ]]..S:STATUS("INVALID_PTR")..[[;
    if (*plugin == NULL) return ]]..S:STATUS("PLUGIN_IS_NULL")..[[;
    free(*plugin);
    *plugin = NULL;
    return status;
}

]]..S:STRING("PLG_GET_CB_FUNC_DECL")..[[ 
{
    if (plugin == NULL) return ]]..S:STATUS("INVALID_PTR")..[[;
    switch(domain)
    {
]]..self.subcontents.get_profile_cb_block..[[ 
        default: return ]]..S:STATUS("UNKNOWN_DOMAIN")..[[;
    }
    return ]]..S:STATUS("SUCCESS")..[[;
}
]]

end

function plugin_c:generate_subcontents()
    self.subcontents.include_block:addfLine("#include \"%s\"", S:STRING("DPLG_HDR"))

    self.subcontents.init_block:addfLine("(*plugin)->%s_callback_handler.on_enter_callback = %s;", S:STRING("DOMAIN"), S:STRING("PLG_OE_CALLBACK_FUNC"))
    self.subcontents.init_block:addfLine("(*plugin)->%s_callback_handler.on_exit_callback = %s;", S:STRING("DOMAIN"), S:STRING("PLG_OX_CALLBACK_FUNC"))
    
    self.subcontents.get_profile_cb_block:addfLine("case %s: *callback_handler = plugin->%s_callback_handler; break;", S:STRING("DOMAIN_ID"), S:STRING("DOMAIN"))
    
    self.subcontents.struct_fields:addfLine("api_callback_handler_t %s_callback_handler;", S:STRING("DOMAIN"))
end

return plugin_c, "COMMON"
