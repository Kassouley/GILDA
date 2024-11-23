local ContentManager = require("ContentManager")
local Content = require("Content")

time_c = setmetatable({}, ContentManager)
time_c.__index = time_c

function time_c:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("TIME_SRC"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, time_c)
    return instance
end

function time_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include "]]..S:STRING("TIME_HDR")..[["

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ns(]]..S:STRING("TIMESPECT_T")..[[ ts)
{
    return (]]..S:STRING("TIME_T")..[[)ts.tv_sec * 1000000000ULL + (]]..S:STRING("TIME_T")..[[)ts.tv_nsec;
}

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_us(]]..S:STRING("TIMESPECT_T")..[[ ts)
{
    return (]]..S:STRING("TIME_T")..[[)ts.tv_sec * 1000000ULL + (]]..S:STRING("TIME_T")..[[)(ts.tv_nsec / 1000ULL);
}

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_ms(]]..S:STRING("TIMESPECT_T")..[[ ts)
{
    return (]]..S:STRING("TIME_T")..[[)ts.tv_sec * 1000ULL + (]]..S:STRING("TIME_T")..[[)(ts.tv_nsec / 1000000ULL);
}

]]..S:STRING("TIME_T")..[[ ]]..S:STRING("TOOLS_NAME")..[[_get_timestamp_s(]]..S:STRING("TIMESPECT_T")..[[ ts)
{
    return (]]..S:STRING("TIME_T")..[[)ts.tv_sec;
}

]]
end

return time_c, "COMMON"
