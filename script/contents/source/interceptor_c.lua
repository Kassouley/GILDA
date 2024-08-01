local interceptor_src = {}

function interceptor_src.content(subcontent)
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include "]]..S._INTERCEPTOR_HEAD..[["
#include "]]..S._LOGGER_HEAD..[["

void ]]..S._TOOLS_NAME..[[_enable_domain(]]..S._TOOLS_NAME..[[_domain_t domain)
{
    switch (domain) {
]]..subcontent.enable_case_block..[[ 
        default: break;
    }
}

void ]]..S._TOOLS_NAME..[[_disable_domain(]]..S._TOOLS_NAME..[[_domain_t domain)
{
    switch (domain) {
]]..subcontent.disable_case_block..[[ 
        default: break;
    }
}

void ]]..S._TOOLS_NAME..[[_init()
{
    INIT_LOGGER();
]]..subcontent.load_block..[[
    printf("Profiler initialized.\n");
}

void ]]..S._TOOLS_NAME..[[_fini()
{
    CLOSE_LOGGER();
    printf("Profiler finalized.\n");
}

]]
end

function interceptor_src.enable_case_block()
    return "\t\tcase "..S._DOMAIN_ID..": "..S._ATM_ENABLE_DOMAIN_FUNC.."(); break;"
end

function interceptor_src.disable_case_block()
    return "\t\tcase "..S._DOMAIN_ID..": "..S._ATM_DISABLE_DOMAIN_FUNC.."(); break;"
end

function interceptor_src.load_block()
    return "\t"..S._ATM_LOAD_TABLE_FUNC.."();"
end

return interceptor_src
