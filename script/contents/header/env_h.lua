local env_hdr = {}

function env_hdr.content(subcontent)
    return S._WARNING_MSG..[[ 

#ifndef ENV_H
#define ENV_H
#include <stdbool.h>

]]..subcontent.set_enabled_block..[[ 

const char* 
get_function_filter(const char* env_function_filter);
                    
int 
get_]]..S._TOOLS_NAME_ADJ..[[_domain(bool* is_]]..S._TOOLS_NAME_ADJ..[[); 

bool 
is_]]..S._TOOLS_NAME_ADJ..[[_domain(const char *domain);

#endif // ENV_H
]]
end

function env_hdr.set_enabled_block()
    return string.format([[
void 
set_%s_%s_enabled(bool* enabled_functions, 
                  bool* is_full_enabled);
]], 
        S._DOMAIN, S._TOOLS_NAME_NOUN
    )
end

return env_hdr

