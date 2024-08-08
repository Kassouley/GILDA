local handler_mgr_hdr = {}

function handler_mgr_hdr.content(subcontents)
    return S._WARNING_MSG..[[ 

#ifndef HANDLER_MANAGER_H
#define HANDLER_MANAGER_H
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "]]..S._LOGGER_HEAD..[["

/**
 * The `#define HANDLE(api_table, v, handle)` macro is defining a custom macro named 
 * `HANDLE` that is used for loading function pointers from a dynamically loaded
 * library handle and assign the loaded function to function pointer that will be
 * call during the interception. 
 */
#define HANDLE(api_table, v, handle) \
do { \
    api_table.fn_##v = (__##v##_t)(dlsym(handle, #v)); \
    if (!api_table.fn_##v) { \
        LOG_MESSAGE("Failed to load \"%s\". Skipping.\n", #v); \
        api_table.fn_##v = (__##v##_t)fallback; \
    } \
    api_table.ptr_##v = api_table.fn_##v; \
} while (false);



/**
 * The `#define ENABLE_]]..S._TOOLS_NAME_UPPER_GERUND..[[(api_table, v, d)` macro is defining a custom macro named 
 * `ENABLE_]]..S._TOOLS_NAME_UPPER_GERUND..[[` that is used for enabling the interception of the function v from 
 * domain d
 */
#define ENABLE_]]..S._TOOLS_NAME_UPPER_GERUND..[[(api_table, v, d) \
do { \
    if (is_full_enabled || is_function_enabled[d##_API_ID_##v]) \
        api_table.ptr_##v = i_##v; \
} while (false);



/**
 * The `#define DISABLE_]]..S._TOOLS_NAME_UPPER_GERUND..[[(api_table, v)` macro is defining a custom macro named 
 * `DISABLE_]]..S._TOOLS_NAME_UPPER_GERUND..[[` that is used for disabling the interception of the function v
 */
#define DISABLE_]]..S._TOOLS_NAME_UPPER_GERUND..[[(api_table, v) \
do { \
    api_table.ptr_##v = api_table.fn_##v; \
} while (false);



/**
 * The function `load_handle` loads a dynamic library specified by the given path and returns a handle
 * to it, or aborts the program if the library is not found.
 * 
 * @param handle_lib_path The `handle_lib_path` parameter is a string that represents the file path to
 * a shared library that you want to load using the `dlopen` function in C.
 * 
 * @return If the `dlopen` function successfully loads the dynamic library specified by
 * `handle_lib_path`, then the handle to that library is being returned. If the library is not found or
 * there is an error in loading it, the function will print an error message and abort the program.
 */
void* load_handle(const char* handle_lib_path);



/**
 * The function `fallback` is designed to handle critical errors by displaying an error message and
 * exiting the program with a failure status.
 */
void fallback(void);


#endif // HANDLER_MANAGER_H
]]
end

return handler_mgr_hdr