local ContentManager = require("ContentManager")
local Content = require("Content")

callback_h = setmetatable({}, ContentManager)
callback_h.__index = callback_h

function callback_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("CB_HDR"),
        subcontents = {
            ["define"] = Content:new()
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, callback_h)
    return instance
end

function callback_h:generate_content()
    local def_header = "API_CALLBACK_MANAGER_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include "]]..S:STRING("INTERCEPTOR_HDR")..[["

typedef ]]..S:STRING("CB_TYPEDEF_T")..[[;

typedef struct {
    ]]..S:STRING("CB_TYPEDEF_T2")..[[ on_enter_callback;
    ]]..S:STRING("CB_TYPEDEF_T2")..[[ on_exit_callback;
} api_callback_handler_t;

void default_callback_function(]]..S:STRING("CB_ARGS")..[[);

#define DEFINE_API_CALLBACKS_PROTO(api_name) \
    extern ]]..S:STRING("CB_TYPEDEF_T2")..[[ __on_enter_##api_name##_callback_function; \
    extern ]]..S:STRING("CB_TYPEDEF_T2")..[[ __on_exit_##api_name##_callback_function; \
\
    ]]..S:STRING("I_STATUS_TYPE")..[[ set_##api_name##_api_callback(api_callback_handler_t callback_handler); \

]]..self.subcontents.define..[[ 

#endif // ]]..def_header
end

function callback_h:generate_subcontents()
    self.subcontents.define:addfLine("DEFINE_API_CALLBACKS_PROTO(%s);", S:STRING("DOMAIN"))
end


return callback_h, "COMMON"
