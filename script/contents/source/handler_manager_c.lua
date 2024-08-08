local handler_mgr_src = {}

function handler_mgr_src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "]]..S._LOGGER_HEAD..[["
#include "]]..S._HANDLER_MGR_HEAD..[["

void* load_handle(const char* handle_lib_path) {
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

return handler_mgr_src

