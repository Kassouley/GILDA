local plg_src = {}

function plg_src.content(subcontents)
    return S._SAMPLE_MSG..[[ 

#include "]]..S._INTERCEPTOR_HEAD..[["
#include "]]..S._PLUG_HEAD..[["

void process_]]..S._DOMAIN..[[_args_for(]]..S._API_ID_T..[[ funid, const ]]..S._API_ARGS_T..[[* args) {
    switch(funid) {
]]..subcontents.case_block..[[ 
        default : break;
    }
}

]]
end

function plg_src.case_block(fname)
    return string.format("\t\tcase %s%s : PROCESS_ARGS_%s(args);", S._API_ID_PREFIX, fname, fname)
end

return plg_src
