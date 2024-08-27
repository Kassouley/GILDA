local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._HANDLER_MGR_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._HANDLER_MGR_HDR_PATH, do_gen = true, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src:generate_content()
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "]]..S._LOGGER_HDR..[["
#include "]]..S._HANDLER_MGR_HDR..[["

]]..S._HM_LOAD_FUNC_DECL..[[ 
{
    void *handle = dlopen(handle_lib_path, RTLD_LOCAL | RTLD_LAZY);
    if (handle)
        return handle;
    fprintf(stderr, "%s not found\n", handle_lib_path);
    abort();
}

void fallback(void) {
    fprintf(stderr, "Critical error: Unable to load a function. See logs for more details.\n");
    exit(EXIT_FAILURE);
}
]]
end

-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr:generate_content()
    return S._WARNING_MSG..[[ 

#ifndef HANDLER_MANAGER_H
#define HANDLER_MANAGER_H
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "]]..S._LOGGER_HDR..[["

/**
 * Used for loading function pointers from a dynamically loaded
 * library handle and assign the loaded function to function pointer that will be
 * call during the interception. 
 */
#define ]]..S._HM_HANDLE_MACRO..[[(api_table, v, handle) \
do { \
    api_table.fn_##v = (__##v##_t)(dlsym(handle, #v)); \
    if (!api_table.fn_##v) { \
        ]]..S._LOG_MSG_MACRO..[[("Failed to load \"%s\". Skipping.\n", #v); \
        api_table.fn_##v = (__##v##_t)fallback; \
    } \
    api_table.ptr_##v = api_table.fn_##v; \
} while (false);



/**
 * Used for enabling the interception of the function v from domain d
 */
#define ]]..S._HM_ENABLE_MACRO..[[(api_table, v, d) \
do { \
    if (is_full_enabled || is_function_enabled[d##_API_ID_##v]) \
        api_table.ptr_##v = i_##v; \
} while (false);



/**
 * Used for disabling the interception of the function v
 */
#define ]]..S._HM_DISABLE_MACRO..[[(api_table, v) \
do { \
    api_table.ptr_##v = api_table.fn_##v; \
} while (false);



/**
 * Loads a dynamic library specified by the given path and returns a handle
 * to it, or aborts the program if the library is not found.
 * 
 * @param handle_lib_path The `handle_lib_path` parameter is a string that represents the file path to
 * a shared library that you want to load using the `dlopen` function in C.
 * 
 * @return If the `dlopen` function successfully loads the dynamic library specified by
 * `handle_lib_path`, then the handle to that library is being returned. If the library is not found or
 * there is an error in loading it, the function will print an error message and abort the program.
 */
]]..S._HM_LOAD_FUNC_DECL..[[;



/**
 * The function `fallback` is designed to handle critical errors by displaying an error message and
 * exiting the program with a failure status.
 */
void fallback(void);


#endif // HANDLER_MANAGER_H
]]
end

return {src=src, hdr=hdr}
