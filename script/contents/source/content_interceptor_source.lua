local interceptor_src = {}

function interceptor_src.content(case_block)
    return string.format([[
#include <stdio.h>
#include "%s"
#include "logger.h"

void enable_%s_domain(interceptor_domain_t domain)
{
    switch (domain) {
%s
        default: break;
    }
}

void start_interceptor()
{
    INIT_LOGGER();
    printf("Profiler initialized.\n");
}

void end_interceptor()
{
    CLOSE_LOGGER();
    printf("Profiler finalized.\n");
}

]],
        S:_INTERCEPTOR_HEAD(),
        S._TOOLS_NAME,
        case_block
    )
end

function interceptor_src.case_line()
    return "\t\tcase "..S:_DOMAIN_ID()..": "..S:_ITM_LOAD_TABLE_FUNC().."(); break;"
end

return interceptor_src
