local ContentManager = require("ContentManager")
local Content = require("Content")

lifecycle_h = setmetatable({}, ContentManager)
lifecycle_h.__index = lifecycle_h

function lifecycle_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("LC_HDR"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, lifecycle_h)
    return instance
end

function lifecycle_h:generate_content()
    local def_header = S:STRING("TOOLS_NAME|upper").."_LIFECYCLE_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include <time.h>
#include <stdlib.h>
#include "]]..S:STRING("INTERCEPTOR_HDR")..[["

typedef struct {
    int argc;
    char **argv;
    int retval;
    pid_t pid;
    pid_t tid;
} ]]..S:STRING("TOOLS_NAME")..[[_main_data_t;

typedef struct {
    ]]..S:STRING("LC_PHASE_T")..[[ current_phase;
    ]]..S:STRING("TIMESPECT_T")..[[ constructor_start;
    ]]..S:STRING("TIMESPECT_T")..[[ main_start;
    ]]..S:STRING("TIMESPECT_T")..[[ main_stop;
    ]]..S:STRING("TIMESPECT_T")..[[ destructor_end;
    ]]..S:STRING("TOOLS_NAME")..[[_main_data_t main_data;
} ]]..S:STRING("LC_T")..[[;

]]..S:STRING("LC_INIT_FUNC_DECL")..[[;
]]..S:STRING("LC_FINI_FUNC_DECL")..[[;
]]..S:STRING("LC_GET_LC_FUNC_DECL")..[[;
]]..S:STRING("LC_GET_PHASE_FUNC_DECL")..[[;

int i_main(int argc, char **argv, char **envp);

#endif // ]]..def_header
end

return lifecycle_h, "COMMON"
