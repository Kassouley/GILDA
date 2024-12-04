/* # THIS FILE HAS BEEN AUTOMATICALLY GENERATED BY THE GILDA TOOL.
 * # DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING.
 * # ANY CHANGES MAY BE OVERWRITTEN BY SUBSEQUENT RUNS OF GILDA.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stddef.h>
#include <string.h>
#include <ctype.h>
#include <dlfcn.h>
#include "env.h"

const char* get_function_filter(const char* env_function_filter) 
{
    const char* env_var = getenv(env_function_filter);
    if (env_var == NULL || *env_var == '\0') {
        return NULL;
    }
    int len = strlen(env_var);
    for (int i = 0; i < len; i++) {
        if (!isalnum(env_var[i]) && env_var[i] != ',' && env_var[i] != '_') {
            return NULL;
        }
    }
    return env_var;
}

void* get_plugin_lib()
{
    const char *plugin_path = getenv(ENV_PLUGIN_PATH);
    static void* plugin_handle = NULL;
    if (plugin_path == NULL) {
        fprintf(stderr, "Environment variable %s is not set.\n", ENV_PLUGIN_PATH);
        exit(EXIT_FAILURE);
    }
    plugin_handle = dlopen(plugin_path, RTLD_LAZY);
    if (!plugin_handle) {
        fprintf(stderr, "%s\n", dlerror());
        exit(EXIT_FAILURE);
    }
    return plugin_handle;
}

const char* get_output_file()
{
    const char* out = getenv(ENV_OUTPUT_FILE);
    if (!out) return DEFAULT_OUTPUT_FILE;
    return out;
}

size_t get_buffer_size() 
{
    const char* buf_size = getenv(ENV_BUFFER_SIZE);
    if (!buf_size) return DEFAULT_BUFFER_SIZE;
    return atoll(buf_size);
}

bool is_set_domain(const char *domain) 
{
    const char *env_var = getenv(domain);
    if (env_var != NULL && *env_var != '\0') {
        int is_profiled = atoi(env_var);
        if (is_profiled) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}