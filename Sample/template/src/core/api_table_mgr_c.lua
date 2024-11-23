local ContentManager = require("ContentManager")
local Content = require("Content")

api_table_mgr_c = setmetatable({}, ContentManager)
api_table_mgr_c.__index = api_table_mgr_c

function api_table_mgr_c:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("ATM_SRC"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, api_table_mgr_c)
    return instance
end

function api_table_mgr_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <stdbool.h>
#include "logger.h"
#include "]]..S:STRING("INTERCEPTOR_HDR")..[["
#include "]]..S:STRING("ATM_HDR")..[["

]]..S:STRING("ATM_INIT_FUNC_DECL")..[[ 
{
    if (!api_table) return ]]..S:STATUS("INVALID_PTR")..[[;
    api_table->size = size;
    api_table->domain = domain;
    api_table->api_ptr = (void**)malloc(size * sizeof(void*));
    if (!api_table->api_ptr) return ]]..S:STATUS("MALLOC_FAILED")..[[;
    api_table->api_fn = (void**)malloc(size * sizeof(void*));
    if (!api_table->api_fn) return ]]..S:STATUS("MALLOC_FAILED")..[[;
    api_table->handler = NULL;
    api_table->is_populate = false;
    
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("ATM_POPU_FUNC_DECL")..[[ 
{
    api_table->handler = dlopen(lib_path, RTLD_LOCAL | RTLD_LAZY);
    if (!api_table->handler) return ]]..S:STATUS("DLOPEN_FAILED")..[[;
    for (]]..S:STRING("I_API_ID_T")..[[ id = 0; id < api_table->size; id++)
    {
        const char* funame = ]]..S:STRING("I_GET_FUNAME_FUNC")..[[(api_table->domain, id);
        void* fn = (void*)(dlsym(api_table->handler, funame));
        if (!fn) {
            LOG_MESSAGE("Failed to load \"%s\". (%s) Skipping.", funame, dlerror());
            fn = (void*)fallback;
        }
        api_table->api_fn[id] = fn;
        api_table->api_ptr[id] = fn;
    }
    api_table->is_populate = true;
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("ATM_FINI_FUNC_DECL")..[[ 
{
    if (api_table == NULL) return ]]..S:STATUS("API_TBL_NULL")..[[;
    dlclose(api_table->handler);
    free(api_table->api_ptr);
    free(api_table->api_fn);
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("ATM_ENABLE_FUNC_DECL")..[[ 
{
    if (api_table == NULL) return ]]..S:STATUS("API_TBL_NULL")..[[;
    if (api_table->api_fn == NULL) return ]]..S:STATUS("API_TBL_NOT_INIT")..[[;
    if (api_table->api_ptr == NULL) return ]]..S:STATUS("API_TBL_NOT_INIT")..[[;
    const char *env_var = get_function_filter(env_var_name);
    ]]..S:STRING("I_API_ID_T")..[[ id = 0;
    if (env_var != NULL) {
        char* functions = strdup(env_var);
        char* token = strtok(functions, ",");

        while (token) {
            id = ]]..S:STRING("I_GET_FUNID_FUNC")..[[(api_table->domain, token);
            if (id >= 0 && id < api_table->size) {
                api_table->api_ptr[id] = ]]..S:STRING("I_GET_FUNADDR_FUNC")..[[(api_table->domain, id);
            }
            token = strtok(NULL, ",");
        }
        free(functions);
    } else {
        for (id = 0; id < api_table->size; id++)
        {
            api_table->api_ptr[id] = ]]..S:STRING("I_GET_FUNADDR_FUNC")..[[(api_table->domain, id);
        }
    }
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("ATM_DISABLE_FUNC_DECL")..[[ 
{
    if (api_table == NULL) return ]]..S:STATUS("API_TBL_NULL")..[[;
    if (api_table->api_fn == NULL) return ]]..S:STATUS("API_TBL_NOT_INIT")..[[;
    if (api_table->api_ptr == NULL) return ]]..S:STATUS("API_TBL_NOT_INIT")..[[;
    for (]]..S:STRING("I_API_ID_T")..[[ id = 0; id < api_table->size; id++)
    {
        api_table->api_ptr[id] = api_table->api_fn[id];
    }
    return ]]..S:STATUS("SUCCESS")..[[;
}

void fallback(void) {
    fprintf(stderr, "Critical error: Unable to load a function. See logs for more details.\n");
    exit(EXIT_FAILURE);
}
]]
end

return api_table_mgr_c, "COMMON"
