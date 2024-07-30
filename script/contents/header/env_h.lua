local env_hdr = {}

function env_hdr.content(subcontent)
    return string.format([[
%s

#ifndef ENV_H
#define ENV_H
#include <stdbool.h>

%s

const char* 
get_function_filter(const char* env_function_filter);
                    
int 
get_%s_domain(bool* is_%s); 

bool 
is_%s_domain(const char *domain);

#endif // ENV_H
]], 
        S._WARNING_MSG,
        subcontent.set_enabled_block,
        S._TOOLS_NAME_ADJ, S._TOOLS_NAME_ADJ,
        S._TOOLS_NAME_ADJ
    )
end

function env_hdr.set_enabled_block()
    return string.format([[
void 
set_%s_%s_enabled(bool* enabled_functions, 
                  bool* is_full_enabled);
]], 
        S:_DOMAIN(), S._TOOLS_NAME_NOUN
    )
end

return env_hdr

