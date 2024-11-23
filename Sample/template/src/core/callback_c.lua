local ContentManager = require("ContentManager")
local Content = require("Content")

callback_c = setmetatable({}, ContentManager)
callback_c.__index = callback_c

function callback_c:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("CB_SRC"),
        subcontents = {
            ["define"] = Content:new()
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, callback_c)
    return instance
end

function callback_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <stdio.h>
#include <stdlib.h>

#include "]]..S:STRING("INTERCEPTOR_HDR")..[["
#include "]]..S:STRING("CB_HDR")..[["

void default_callback_function(]]..S:STRING("CB_ARGS")..[[)
{
    fprintf(stderr, "No callback function has been set for domain ID %d.\n", domain); 
}

#define DEFINE_API_CALLBACKS(api_name) \
    ]]..S:STRING("CB_TYPEDEF_T2")..[[ __on_enter_##api_name##_callback_function = default_callback_function; \
    ]]..S:STRING("CB_TYPEDEF_T2")..[[ __on_exit_##api_name##_callback_function = default_callback_function; \
\
    ]]..S:STRING("I_STATUS_TYPE")..[[ set_##api_name##_api_callback(api_callback_handler_t callback_handler) { \
        if (!callback_handler.on_enter_callback || !callback_handler.on_exit_callback) \
            return ]]..S:STATUS("CB_IS_NULL")..[[; \
        __on_enter_##api_name##_callback_function = callback_handler.on_enter_callback; \
        __on_exit_##api_name##_callback_function = callback_handler.on_exit_callback; \
        return ]]..S:STATUS("SUCCESS")..[[; \
    }

]]..self.subcontents.define
end

function callback_c:generate_subcontents()
    self.subcontents.define:addfLine("DEFINE_API_CALLBACKS(%s);", S:STRING("DOMAIN"))
end


return callback_c, "COMMON"