local tools_src = {}

function tools_src.content(subcontent)
    return string.format([[
#include <stdio.h>
#include <stdlib.h>
#include "%s"

%s

__attribute__((constructor)) void init(void) {
    %s_init();
%s
}

__attribute__((destructor)) void fini(void) {
    %s_fini();
}
]],
        S:_INTERCEPTOR_HEAD(),
        subcontent.callback_block,
        S._TOOLS_NAME,
        subcontent.subcontent,
        S._TOOLS_NAME
    )
end

function tools_src.subcontent()
    return string.format([[
    %s(%s_callback_sample);
    %s_enable_domain(%s);
]],
        S:_SET_CALLBACK(), S:_DOMAIN(),
        S._TOOLS_NAME, S:_DOMAIN_ID()
        )
end

function tools_src.callback_block()
    return string.format([[
void %s_callback_sample(bool is_enter, %s func_id, %s data) 
{
    if (is_enter)
        printf("%%s\n", get_%s_funame_by_id(func_id));
}
]],
        S:_DOMAIN(),
        S:_API_ID_T(),
        S:_API_DATA_T(),
        S:_DOMAIN()
    )
end

return tools_src
