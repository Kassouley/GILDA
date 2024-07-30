local env_src = {}

function env_src.content(subcontent)
    return string.format([[
%s

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include "%s"
#include "%s"

%s

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

bool is_%s_domain(const char *domain) 
{
    const char *env_var = getenv(domain);
    if (env_var != NULL && *env_var != '\0') {
        int is_%s = atoi(env_var);
        if (is_%s) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}

int get_%s_domain(bool* is_%s) 
{
    for (%s_domain_t domain = 0; domain < NB_DOMAIN; domain++) {
        const char *domain_name = get_domain_name(domain);
        is_%s[domain] = is_%s_domain(domain_name);
    }
    return 0;
}
]], 
        S._WARNING_MSG,
        S:_INTERCEPTOR_HEAD(),
        S:_ENV_HEAD(),
        subcontent.set_enabled_block,
        S._TOOLS_NAME_ADJ,
        S._TOOLS_NAME_ADJ,
        S._TOOLS_NAME_ADJ,
        S._TOOLS_NAME_ADJ, S._TOOLS_NAME_ADJ,
        S._TOOLS_NAME,
        S._TOOLS_NAME_ADJ, S._TOOLS_NAME_ADJ
    )
end

function env_src.set_enabled_block()
    return string.format([[
void set_%s_%s_enabled(bool* enabled_functions, bool* is_full_enabled) 
{
    const char *env_var = get_function_filter("%s_FUNCTIONS");
    if (env_var != NULL) {

        char* functions = strdup(env_var);
        char* token = strtok(functions, ",");

        while (token) {
            %s id = get_%s_funid_by_name(token);
            if (id >= 0 && id < %sNB_FUNCTION) {
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
]], 
        S:_DOMAIN(), S._TOOLS_NAME_NOUN,
        S:_DOMAIN_ID(),
        S:_API_ID_T(),
        S:_DOMAIN(),
        S:_API_ID_PREFIX()
    )
end

return env_src

