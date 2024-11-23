local ContentManager = require("ContentManager")
local Content = require("Content")

interceptor_h = setmetatable({}, ContentManager)
interceptor_h.__index = interceptor_h

function interceptor_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("INTERCEPTOR_HDR"),
        subcontents = {
            ["include_block"] = Content:new(),
            ["extern_api_table"] = Content:new(),
            ["domain_args_block"] = Content:new(2),
            ["enum_block"] = Content:new(1),
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, interceptor_h)
    return instance
end

function interceptor_h:generate_content()
    local def_header = S:STRING("TOOLS_NAME|upper").."_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include "utils.h"
#include "env.h"
#include "logger.h"
#include "id_system.h"
#include "]]..S:STRING("TIME_HDR")..[["
#include "]]..S:STRING("STATUS_HDR")..[["
]]..self.subcontents.include_block..[[ 

typedef unsigned int ]]..S:STRING("I_API_ID_T")..[[;

typedef enum {
]]..self.subcontents.enum_block..[[ 
    ]]..S:STRING("TOOLS_NAME|upper")..[[_NB_DOMAIN
} ]]..S:STRING("I_DOMAIN_T")..[[;

typedef enum {
	]]..S:STRING("TOOLS_NAME|upper")..[[_IN_CONSTRUCTOR_PHASE,
	]]..S:STRING("TOOLS_NAME|upper")..[[_IN_MAIN_PHASE,
	]]..S:STRING("TOOLS_NAME|upper")..[[_IN_DESTRUCTOR_PHASE
} ]]..S:STRING("LC_PHASE_T")..[[;

typedef struct ]]..S:STRING("I_API_DATA_S")..[[ {
	]]..S:STRING("I_DOMAIN_T")..[[ domain;
    ]]..S:STRING("LC_PHASE_T")..[[ phase;
	]]..S:STRING("I_API_ID_T")..[[ funid;
    uint64_t id;
    uint64_t corr_id;
	uint64_t pid;
	uint64_t tid;
    ]]..S:STRING("TIMESPECT_T")..[[ start_time;
    ]]..S:STRING("TIMESPECT_T")..[[ stop_time;
    union {
]]..self.subcontents.domain_args_block..[[ 
	};
} ]]..S:STRING("I_API_DATA_T")..[[;

#include "]]..S:STRING("LC_HDR")..[["
#include "]]..S:STRING("CB_HDR")..[["
#include "]]..S:STRING("ATM_HDR")..[["

]]..self.subcontents.extern_api_table..[[ 

]]..S:STRING("I_GET_DOMAIN_FUNC_DECL")..[[;
]]..S:STRING("I_GET_FUNAME_FUNC_DECL")..[[;
]]..S:STRING("I_GET_FUNID_FUNC_DECL")..[[;
]]..S:STRING("I_GET_FUNADDR_FUNC_DECL")..[[;
]]..S:STRING("I_ENABLE_DOMAIN_FUNC_DECL")..[[;
]]..S:STRING("I_DISABLE_DOMAIN_FUNC_DECL")..[[;
]]..S:STRING("I_SET_CALLBACK_FUNC_DECL")..[[;
]]..S:STRING("I_INIT_FUNC_DECL")..[[;
]]..S:STRING("I_FINI_FUNC_DECL")..[[;

#endif // ]]..def_header
end


function interceptor_h:generate_subcontents()
    self.subcontents.include_block:addfLine("#include \"%s\"", S:STRING("IF_HDR"))

    self.subcontents.enum_block:addfLine("%s,", S:STRING("DOMAIN_ID"))

    self.subcontents.domain_args_block:addfLine("%s %s_args;", S:STRING("IF_API_ARGS_T"), S:STRING("DOMAIN"))

    self.subcontents.extern_api_table:addfLine("extern %s %s;", S:STRING("ATM_API_TABLE_T"), S:STRING("DOMAIN_API_TABLE_VAR"))
end

return interceptor_h, "COMMON"