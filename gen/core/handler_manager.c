#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "handler_manager.h"
#include "logger.h"

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