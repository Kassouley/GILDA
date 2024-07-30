local handler_mgr_hdr = {}

function handler_mgr_hdr.content()
    return string.format([[
#ifndef HANDLER_MANAGER_H
#define HANDLER_MANAGER_H
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "%s"

void* load_handle(const char* handle_lib_path);
void fallback(void);

#define HANDLE(api_table, v, handle) \
do { \
    api_table.fn_##v = (__##v##_t)(dlsym(handle, #v)); \
    if (!api_table.fn_##v) { \
        LOG_MESSAGE("Failed to load \"%%s\". Skipping.\n", #v); \
        api_table.fn_##v = (__##v##_t)fallback; \
    } \
    api_table.ptr_##v = api_table.fn_##v; \
} while (false);

#define ENABLE_TRACE(api_table, v, d) \
do { \
    if (is_full_enabled || is_function_enabled[d##_API_ID_##v]) \
        api_table.ptr_##v = i_##v; \
} while (false);

#define DISABLE_TRACE(api_table, v) \
do { \
    api_table.ptr_##v = api_table.fn_##v; \
} while (false);

#endif
]], S:_LOGGER_HEAD())
end

return handler_mgr_hdr