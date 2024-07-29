local interceptor_src = {}

function interceptor_src.content(subcontent)
    return string.format([[
#include <stdio.h>
#include "%s"
#include "%s"

void %s_enable_domain(%s_domain_t domain)
{
    switch (domain) {
%s
        default: break;
    }
}

void %s_disable_domain(%s_domain_t domain)
{
    switch (domain) {
%s
        default: break;
    }
}

void %s_init()
{
    INIT_LOGGER();
%s
    printf("Profiler initialized.\n");
}

void %s_fini()
{
    CLOSE_LOGGER();
    printf("Profiler finalized.\n");
}

]],
        S:_INTERCEPTOR_HEAD(),
        S:_LOGGER_HEAD(),
        S._TOOLS_NAME, S._TOOLS_NAME,
        subcontent.enable_case_block,
        S._TOOLS_NAME, S._TOOLS_NAME,
        subcontent.disable_case_block,
        S._TOOLS_NAME,
        subcontent.load_block,
        S._TOOLS_NAME
    )
end

function interceptor_src.enable_case_block()
    return "\t\tcase "..S:_DOMAIN_ID()..": "..S:_ITM_ENABLE_DOMAIN_FUNC().."(); break;"
end

function interceptor_src.disable_case_block()
    return "\t\tcase "..S:_DOMAIN_ID()..": "..S:_ITM_DISABLE_DOMAIN_FUNC().."(); break;"
end

function interceptor_src.load_block()
    return "\t"..S:_ITM_LOAD_TABLE_FUNC().."();"
end

return interceptor_src
