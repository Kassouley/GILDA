local src = {}

src.kpath = "_TOOL_SRC_PATH"

function src.content(subcontents)
    return S._SAMPLE_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._PLG_HDR..[["

__attribute__((constructor)) void init(void) {
    ]]..S._I_INIT_FUNC..[[();

    bool* is_]]..S._TOOLS_NAME_ADJ..[[ = (bool*)malloc(]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN * sizeof(bool));
    ]]..S._ENV_GET_DOMAIN_FUNC..[[(is_]]..S._TOOLS_NAME_ADJ..[[);

]]..subcontents.subcontent..[[ 

    free(is_]]..S._TOOLS_NAME_ADJ..[[);
}

__attribute__((destructor)) void fini(void) {
    ]]..S._I_FINI_FUNC..[[();
}
]]
end

function src.subcontent()
    return string.format([[
    if (is_%s[%s]) {
        %s(%s);
        %s(%s);
    }]],
        S._TOOLS_NAME_ADJ, S._DOMAIN_ID,
        S._CB_SET_CALLBACK_FUNC, S._PLG_CALLBACK_FUNC,
        S._I_ENABLE_DOMAIN_FUNC, S._DOMAIN_ID
        )
end

return {src=src}
