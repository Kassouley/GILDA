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

#define HANDLE(itcp_table, v, handle) \
do { \
    itcp_table.fn_##v = (__##v##_t)(dlsym(handle, #v)); \
    if (!itcp_table.fn_##v) { \
        LOG_MESSAGE("Failed to load \"%s\". Skipping.\n", #v); \
        itcp_table.fn_##v = (__##v##_t)fallback; \
    } \
    itcp_table.ptr_##v = itcp_table.fn_##v; \
} while (false);


#define SWITCH_FILTER(itcp_table, v, is_enable) \
do { \
    if (is_enable) { \
        itcp_table.ptr_##v = i_##v; \
    } else { \
        itcp_table.ptr_##v = itcp_table.fn_##v; \
    } \
} while (false);

#endif
]], S:_LOGGER_HEAD(), "%s")
end

return handler_mgr_hdr