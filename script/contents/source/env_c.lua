local env_src = {}

function env_src.content()
    return string.format([[
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "%s"

char **split_string(const char *env_var, 
                    int *word_count) 
{
    int count = 0;
    char *temp = strdup(env_var); 
    char *token = strtok(temp, ",");
    
    while (token != NULL) {
        count++;
        token = strtok(NULL, ",");
    }
    
    char **words = (char **)malloc(count * sizeof(char *));
    strcpy(temp, env_var);  // Reset temp string
    token = strtok(temp, ",");
    int index = 0;

    while (token != NULL) {
        words[index] = strdup(token);
        index++;
        token = strtok(NULL, ",");
    }

    free(temp); 
    *word_count = count;
    return words;
}

int get_function_filter(char **functions, 
                        unsigned int* functions_count) 
{
    const char *env_var = getenv(FUNCTION_FILTER);

    if (env_var == NULL) {
        fprintf(stderr, "Environment variable %s is not set.\n", FUNCTION_FILTER);
        return EXIT_FAILURE;
    }

    int len = strlen(env_var);
    for (int i = 0; i < len; i++) {
        if (!isalnum(env_var[i]) 
                && env_var[i] != ',' 
                && env_var[i] != '_') {
            fprintf(stderr, "Environment variable %s is not well formatted.\n", FUNCTION_FILTER);
            return EXIT_FAILURE;
        }
    }
    *functions = split_string(env_var, &functions_count);
    return EXIT_SUCCESS;
}
]], S:_ENV_HEAD())
end

return env_src

