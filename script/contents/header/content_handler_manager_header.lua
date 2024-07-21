local handler_mgr_hdr = {}

function handler_mgr_hdr.content()
    return [[
#ifndef HANDLER_MANAGER_H
#define HANDLER_MANAGER_H
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "logger.h"

void* load_handle(const char* handle_lib_path);
void fallback(void);

#define HANDLE(itcp_table, v, handle) \
do { \
    itcp_table.fn_##v = (__##v##_t)(dlsym(handle, #v)); \
    if (!itcp_table.fn_##v) { \
        LOG_MESSAGE("Failed to load \"%s\". Skipping.\n", #v); \
        itcp_table.fn_##v = (__##v##_t)fallback; \
    } \
} while (false)

#endif
]]
end

return handler_mgr_hdr