local ContentManager = require("ContentManager")
local Content = require("Content")

tool = setmetatable({}, ContentManager)
tool.__index = tool

function tool:new(options, template_path, output_path)
    local attribute = {
        file_name = "tool.c",
        is_sample = true,
        do_not_gen = not options.force_tool_gen and true,
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    if instance then setmetatable(instance, tool) end
    return instance
end

function tool:generate_content()
    return S:STRING("SAMPLE_MSG")..[[ 

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <assert.h>
#include <]]..S:STRING("INTERCEPTOR_HDR")..[[>
#include <plugin.h>

typedef struct plugin_manager_s {
    void* plugin_handle;
    ]]..S:STRING("I_STATUS_TYPE")..[[ (*plugin_initialize)(]]..S:STRING("PLG_STRUCT")..[[**);
    ]]..S:STRING("I_STATUS_TYPE")..[[ (*plugin_finalize)(]]..S:STRING("PLG_STRUCT")..[[**);
    ]]..S:STRING("I_STATUS_TYPE")..[[ (*get_api_callback)(const ]]..S:STRING("PLG_STRUCT")..[[*, ]]..S:STRING("I_DOMAIN_T")..[[, api_callback_handler_t*); 
} plugin_manager_t;

plugin_manager_t plugin_manager = {0};
]]..S:STRING("PLG_STRUCT")..[[* plugin = NULL;

static void* load_symbol(void *handle, const char *symbol) {
    void *sym = dlsym(handle, symbol);
    if (sym == NULL) {
        fprintf(stderr, "Error loading symbol %s: %s\n", symbol, dlerror());
        if (handle) dlclose(handle);
        abort();
    }
    return sym;
}
 
static void open_plugin_manager(plugin_manager_t* pm) {
    if (!pm->plugin_handle) {
        pm->plugin_handle = get_plugin_lib();
        pm->plugin_initialize = load_symbol(pm->plugin_handle, "]]..S:STRING("PLG_INIT_FUNC")..[[");
        pm->plugin_finalize = load_symbol(pm->plugin_handle, "]]..S:STRING("PLG_FINI_FUNC")..[[");
        pm->get_api_callback = load_symbol(pm->plugin_handle, "]]..S:STRING("PLG_GET_CB_FUNC")..[[");
    }
}

static void close_plugin_manager(plugin_manager_t* pm) {
    if (pm->plugin_handle) {
        dlclose(pm->plugin_handle);
        pm->plugin_handle = NULL;
    }
}

void onLoad()
{
    ]]..S:STRING("I_INIT_FUNC")..[[();

    open_plugin_manager(&plugin_manager);
    ]]..S:STRING("PLG_STRUCT")..[[* plugin = NULL;
    plugin_manager.plugin_initialize(&plugin);
    
    // API Table Init
    api_callback_handler_t callback_handler;
    for (]]..S:STRING("I_DOMAIN_T")..[[ domain = 0; domain < ]]..S:STRING("TOOLS_NAME|upper")..[[_NB_DOMAIN; domain++)
    {
        if (is_set_domain(get_domain_name(domain))) {
            plugin_manager.get_api_callback(plugin, domain, &callback_handler);
            ]]..S:STRING("I_SET_CALLBACK_FUNC")..[[(domain, callback_handler);
            ]]..S:STRING("I_ENABLE_DOMAIN_FUNC")..[[(domain);
        }
    }
}

void onExit()
{
    for (]]..S:STRING("I_DOMAIN_T")..[[ domain = 0; domain < ]]..S:STRING("TOOLS_NAME|upper")..[[_NB_DOMAIN; domain++)
    {
        if (is_set_domain(get_domain_name(domain))) {
		    ]]..S:STRING("I_DISABLE_DOMAIN_FUNC")..[[(domain);
        }
    }
    
    plugin_manager.plugin_finalize(&plugin);
    close_plugin_manager(&plugin_manager);
    ]]..S:STRING("I_FINI_FUNC")..[[();
}

__attribute__((constructor(101))) void init(void) 
{
    onLoad();
}

__attribute__((destructor(101))) void fini(void) 
{
    int cr = atexit( onExit );
    assert( cr == 0 );
}
]]
end

return tool, "COMMON"
