local tools_src = {}

function tools_src.content(subcontent)
    return S._SAMPLE_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include "]]..S._INTERCEPTOR_HEAD..[["

]]..subcontent.callback_block..[[ 

__attribute__((constructor)) void init(void) {
    ]]..S._TOOLS_NAME..[[_init();

    bool* is_]]..S._TOOLS_NAME_ADJ..[[ = (bool*)malloc(]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN * sizeof(bool));
    get_]]..S._TOOLS_NAME_ADJ..[[_domain(is_]]..S._TOOLS_NAME_ADJ..[[);

]]..subcontent.subcontent..[[ 

    free(is_]]..S._TOOLS_NAME_ADJ..[[);
}

__attribute__((destructor)) void fini(void) {
    ]]..S._TOOLS_NAME..[[_fini();
}
]]
end

function tools_src.subcontent()
    return string.format([[
    if (is_%s[%s]) {
        %s(%s_callback_sample);
        %s_enable_domain(%s);
    }]],
        S._TOOLS_NAME_ADJ, S._DOMAIN_ID,
        S._SET_CALLBACK, S._DOMAIN,
        S._TOOLS_NAME, S._DOMAIN_ID
        )
end

function tools_src.callback_block()
    return [[
void ]]..S._DOMAIN..[[_callback_sample(bool is_enter, const ]]..S._API_DATA_T..[[* activity) 
{
    if (is_enter)
        printf("%s\n", get_]]..S._DOMAIN..[[_funame_by_id(activity->funid));
}
]]
end

return tools_src
