local env_hdr = {}

function env_hdr.content()
    local def_header = S._ENV.."_H"
    return string.format([[
#ifndef %s
#define %s

#define FUNCTION_FILTER "%s"

char**
split_string(const char *env_var, 
             int *word_count);

int 
get_function_filter(char **functions, 
                    unsigned int* functions_count);
]], 
        def_header,
        def_header,
        S._FUNCTION_FILTER)
end

return env_hdr

