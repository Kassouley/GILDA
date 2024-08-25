local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._ENV_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._ENV_HDR_PATH, do_gen = true, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src:generate_content()
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._ENV_HDR..[["

]]..self.subcontents.set_enabled_block..[[ 

]]..S._ENV_GET_FILTER_FUNC_DECL..[[ 
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

]]..S._ENV_IS_DOMAIN_FUNC_DECL..[[ 
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

]]..S._ENV_GET_DOMAIN_FUNC_DECL..[[ 
{
    bool* is_]]..S._TOOLS_NAME_ADJ..[[ = (bool*)malloc(]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN * sizeof(bool));
    for (]]..S._I_DOMAIN_T..[[ domain = 0; domain < ]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN; domain++) {
        const char *domain_name = ]]..S._I_GET_DOMAIN_FUNC..[[(domain);
        is_]]..S._TOOLS_NAME_ADJ..[[[domain] = ]]..S._ENV_IS_DOMAIN_FUNC..[[(domain_name);
    }
    return is_]]..S._TOOLS_NAME_ADJ..[[;
}
]]
end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src:init_subcontent("set_enabled_block", Content:new())

function src:generate_subcontents()
    self.subcontents["set_enabled_block"]:addfLine([[
%s
{
    const char *env_var = %s("%s_FUNCTIONS");
    if (env_var != NULL) {

        char* functions = strdup(env_var);
        char* token = strtok(functions, ",");

        while (token) {
            %s id = %s(token);
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
}]],    S._ENV_SET_ENABLED_FUNC_DECL, 
        S._ENV_GET_FILTER_FUNC, S._DOMAIN_ID,
        S._IF_API_ID_T, S._IF_GET_FUNID_FUNC,
        S._IF_API_ID_PREFIX)
end


-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr:generate_content()
    return S._WARNING_MSG..[[ 

#ifndef ENV_H
#define ENV_H
#include <stdbool.h>

]]..self.subcontents.set_enabled_block..[[ 

]]..S._ENV_GET_FILTER_FUNC_DECL..[[;
]]..S._ENV_IS_DOMAIN_FUNC_DECL..[[;
]]..S._ENV_GET_DOMAIN_FUNC_DECL..[[;

#endif // ENV_H
]]
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------

hdr:init_subcontent("set_enabled_block", Content:new())

function hdr:generate_subcontents()
    hdr.subcontents.set_enabled_block:addfLine("%s;", S._ENV_SET_ENABLED_FUNC_DECL)
end

return {src=src, hdr=hdr}
