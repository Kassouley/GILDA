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
    printf("Profiler initialization . . . ");
    ]]..S:STRING("I_INIT_FUNC")..[[();
    printf("Done\n");

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
    printf("Profiler start\n");
    ]]..S:STRING("I_START_FUNC")..[[();
}

void onExit()
{
    ]]..S:STRING("I_STOP_FUNC")..[[();

    printf("Profiler stop\n");
    ]]..S:STRING("LC_T")..[[* lc = ]]..S:STRING("LC_GET_LC_FUNC")..[[();
    ]]..S:STRING("TIME_T")..[[ tool_init_start = ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(lc->tool_init_start);
    ]]..S:STRING("TIME_T")..[[ constructor_start = ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(lc->constructor_start);
    ]]..S:STRING("TIME_T")..[[ main_start = ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(lc->main_start);
    ]]..S:STRING("TIME_T")..[[ main_stop = ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(lc->main_stop);
    ]]..S:STRING("TIME_T")..[[ destructor_stop = ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(lc->destructor_stop);
    ]]..S:STRING("TIME_T")..[[ tool_fini_stop = ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(lc->tool_fini_stop);
    printf("Init tool duration : %lu\n", constructor_start-tool_init_start);
    printf("Constructor duration : %lu\n", main_start-constructor_start);
    printf("Main duration : %lu\n", main_stop-main_start);
    printf("Destuctor duration : %lu\n", destructor_stop-main_stop);
    printf("Fini tool duration : %lu\n", tool_fini_stop-destructor_stop);

    for (]]..S:STRING("I_DOMAIN_T")..[[ domain = 0; domain < ]]..S:STRING("TOOLS_NAME|upper")..[[_NB_DOMAIN; domain++)
    {
        if (is_set_domain(get_domain_name(domain))) {
		    ]]..S:STRING("I_DISABLE_DOMAIN_FUNC")..[[(domain);
        }
    }
    
    plugin_manager.plugin_finalize(&plugin);
    close_plugin_manager(&plugin_manager);
    printf("Profiler fini . . . ");
    ]]..S:STRING("I_FINI_FUNC")..[[();
    printf("Done\n");
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
