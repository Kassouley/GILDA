local itcp_fnct_hdr = {}

function itcp_fnct_hdr.content(includes_str, subcontent)
    local def_header = string.format(
        "%s_%s_FUNCTIONS_H", S:_DOMAIN_UPPER(), S._TOOLS_NAME_UPPER_ADJ
    )
    local macro_call = string.format("GET_CB_ARGS_DATA_##v##(%s)", S:_API_DATA_VAR())
    return string.format([[
#ifndef %s
#define %s
%s
#include <string.h>

// CALLBACK
#define %s_CALLBACK_BEFORE(v) { \
    %s %s = {}; \
    %s; \
    %s(IS_ENTER, %s##v##, %s); \
};

#define %s_CALLBACK_AFTER(v) { \
    %s; \
    %s(IS_EXIT, %s##v##, %s); \
};

// %s API ID enum
typedef enum {
%s
} %s;

// Return %s API function name for a given ID
static inline const char* get_%s_funame_by_id(%s id) {
    switch(id) {
%s
    }
    return NULL;
}

// Return %s API function name for a given ID
static inline %s get_%s_funid_by_name(const char* name) {
    if (name == NULL) return 0;
%s
}

// %s API data
typedef struct %s {
    uint64_t corrId;
    bool is_enter;
    union {
%s
    } args;
} %s;

#endif
]],
        def_header,
        def_header,
        includes_str,

        S:_DOMAIN_UPPER(),
        S:_API_DATA_T(), S:_API_DATA_VAR(),
        macro_call,
        S:_CALLBACK_FUNCTION(), S:_API_ID_PREFIX(), S:_API_DATA_VAR(), 

        S:_DOMAIN_UPPER(),
        macro_call,
        S:_CALLBACK_FUNCTION(), S:_API_ID_PREFIX(), S:_API_DATA_VAR(), 

        S:_DOMAIN_UPPER(),
        subcontent.api_id_enum_block,
        S:_API_ID_T(),

        S:_DOMAIN_UPPER(), 
        S:_DOMAIN(), S:_API_ID_T(),
        subcontent.get_funame_block,
        
        S:_DOMAIN_UPPER(), 
        S:_API_ID_T(), S:_DOMAIN(), 
        subcontent.get_funid_block,

        S:_DOMAIN_UPPER(), 
        S:_API_DATA_S(),
        subcontent.api_data_t_block,
        S:_API_DATA_T()
    )
end


function itcp_fnct_hdr.api_id_enum_block(func_name, i)
    return string.format("\t%s%s = %d,", S:_API_ID_PREFIX(), func_name, i)
end

function itcp_fnct_hdr.get_funame_block(func_name)
    return string.format("\t\tcase %s%s : return \"%s\";", S:_API_ID_PREFIX(), func_name, func_name)
end

function itcp_fnct_hdr.get_funid_block(func_name)
    return string.format("\telse if (strcmp(name, \"%s\") == 0) return %s%s;", func_name, S:_API_ID_PREFIX(), func_name)
end

function itcp_fnct_hdr.api_data_t_block(return_type, func_name, args_block)
    if return_type == "void" then
        return string.format([[
        struct {
%s
        } %s;
]], 
        args_block, func_name)
    else
        return string.format([[
        struct {
            %s ret_value;
%s
        } %s;
]], 
        return_type, args_block, func_name)
    end
end

function itcp_fnct_hdr.api_data_t_line(arg)
    return "\t\t\t" .. arg .. ";"
end

return itcp_fnct_hdr