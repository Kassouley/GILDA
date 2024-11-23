local ContentManager = require("ContentManager")
local Content = require("Content")

time_h = setmetatable({}, ContentManager)
time_h.__index = time_h

function time_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("TIME_HDR"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, time_h)
    return instance
end

function time_h:generate_content()
    local def_header = S:STRING("TOOLS_NAME|upper").."_TIME_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include <stdint.h>
#include <time.h> 

typedef struct timespec ]]..S:STRING("TIMESPECT_T")..[[;
typedef uint64_t ]]..S:STRING("TIME_T")..[[;

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(]]..S:STRING("TIMESPECT_T")..[[ ts);

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_us(]]..S:STRING("TIMESPECT_T")..[[ ts);

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ms(]]..S:STRING("TIMESPECT_T")..[[ ts);

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_s(]]..S:STRING("TIMESPECT_T")..[[ ts);

#endif // ]]..def_header
end

return time_h, "COMMON"
