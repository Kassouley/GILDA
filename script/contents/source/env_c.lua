local env_src = {}

function env_src.content(subcontent)
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include "]]..S._INTERCEPTOR_HEAD..[["
#include "]]..S._ENV_HEAD..[["

]]..subcontent.set_enabled_block..[[

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

bool is_]]..S._TOOLS_NAME_ADJ..[[_domain(const char *domain) 
{
    const char *env_var = getenv(domain);
    if (env_var != NULL && *env_var != '\0') {
        int is_]]..S._TOOLS_NAME_ADJ..[[ = atoi(env_var);
        if (is_]]..S._TOOLS_NAME_ADJ..[[) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}

int get_]]..S._TOOLS_NAME_ADJ..[[_domain(bool* is_]]..S._TOOLS_NAME_ADJ..[[) 
{
    for (]]..S._TOOLS_NAME..[[_domain_t domain = 0; domain < ]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN; domain++) {
        const char *domain_name = get_domain_name(domain);
        is_]]..S._TOOLS_NAME_ADJ..[[[domain] = is_]]..S._TOOLS_NAME_ADJ..[[_domain(domain_name);
    }
    return 0;
}
]]
end

function env_src.set_enabled_block()
    return [[
void set_]]..S._DOMAIN..[[_]]..S._TOOLS_NAME_NOUN..[[_enabled(bool* enabled_functions, bool* is_full_enabled) 
{
    const char *env_var = get_function_filter("]]..S._DOMAIN_ID..[[_FUNCTIONS");
    if (env_var != NULL) {

        char* functions = strdup(env_var);
        char* token = strtok(functions, ",");

        while (token) {
            ]]..S._API_ID_T..[[ id = get_]]..S._DOMAIN..[[_funid_by_name(token);
            if (id >= 0 && id < ]]..S._API_ID_PREFIX..[[NB_FUNCTION) {
                enabled_functions[id] = true;
            }
            token = strtok(NULL, ",");
        }
        free(functions);
        *is_full_enabled = false;
    } else {
        *is_full_enabled = true;
    }
}
]]
end

return env_src

