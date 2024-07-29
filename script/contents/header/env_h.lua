local env_hdr = {}

function env_hdr.content()
    return string.format([[
#ifndef ENV_H
#define ENV_H

#define FUNCTION_FILTER "%s"

char**
split_string(const char *env_var, 
             int *word_count);

int 
get_function_filter(char ***functions, 
                    unsigned int *functions_count);

#endif
]], 
        S._FUNCTION_FILTER)
end

return env_hdr

