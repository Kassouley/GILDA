#ifndef HANDLER_MANAGER_H
#define HANDLER_MANAGER_H
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

void* load_handle(const char* handle_lib_path);

#define HANDLE(itcp_table, v, handle) \
do { \
    itcp_table.fn_##v = reinterpret_cast<decltype(&v)>(dlsym(handle, #v)); \
    if (!itcp_table.fn_##v) { \
        fprintf(stderr, "Failed to load \"%s\"\n", #v); \
        abort(); \
    } \
} while (false)

#endif