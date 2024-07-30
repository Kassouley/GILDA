local api_fnct_hdr = {}

function api_fnct_hdr.content(subcontent, includes_str)
    local def_header = string.format(
        "%s_%s_FUNCTIONS_H", S:_DOMAIN_UPPER(), S._TOOLS_NAME_UPPER_ADJ
    )
    local macro_call = string.format("GET_CB_ARGS_DATA_##v(%s)", S:_API_DATA_VAR())
    return string.format([[
#ifndef %s
#define %s
%s
#include <string.h>

// CALLBACK BEFORE
#define %s_CALLBACK_BEFORE(v, %s) { \
    %s; \
    %s(IS_ENTER, %s##v, %s); \
};

// CALLBACK AFTER
#define %s_CALLBACK_AFTER(v, %s) { \
    %s; \
    %s(IS_EXIT, %s##v, %s); \
};

// %s API ID enum
typedef enum {
%s
    %sNB_FUNCTION,
    %sUNKNOWN,
} %s;

// Return %s API function name for a given ID
static inline const char* get_%s_funame_by_id(%s id) {
    switch(id) {
%s
        default : return NULL;
    }
    return NULL;
}

// Return %s API function ID for a given name
static inline %s get_%s_funid_by_name(const char* name) {
    if (name == NULL) return %sUNKNOWN;
%s
    return %sUNKNOWN;
}

// %s API data
typedef struct %s {
    uint64_t corrId;
    bool is_enter;
    union {
%s
    } args;
} %s;

// %s API Function Prototype
%s

#endif // %s
]],
        def_header,
        def_header,
        includes_str,
        -- CALLBACK BEFORE
        S:_DOMAIN_UPPER(),
        S:_API_DATA_VAR(),
        macro_call,
        S:_CALLBACK_FUNCTION(), S:_API_ID_PREFIX(), S:_API_DATA_VAR(), 
        -- CALLBACK AFTER
        S:_DOMAIN_UPPER(),
        S:_API_DATA_VAR(),
        macro_call,
        S:_CALLBACK_FUNCTION(), S:_API_ID_PREFIX(), S:_API_DATA_VAR(), 
        -- API ID enum
        S:_DOMAIN_UPPER(),
        subcontent.api_id_enum_block,
        S:_API_ID_PREFIX(),
        S:_API_ID_PREFIX(),
        S:_API_ID_T(),
        -- API function name
        S:_DOMAIN_UPPER(), 
        S:_DOMAIN(), S:_API_ID_T(),
        subcontent.get_funame_block,
        -- API function ID
        S:_DOMAIN_UPPER(), 
        S:_API_ID_T(), S:_DOMAIN(), 
        S:_API_ID_PREFIX(),
        subcontent.get_funid_block,
        S:_API_ID_PREFIX(),
        -- API data
        S:_DOMAIN_UPPER(), 
        S:_API_DATA_S(),
        subcontent.api_data_t_block,
        S:_API_DATA_T(),
        -- API Function Prototype
        S:_DOMAIN_UPPER(), 
        subcontent.func_proto_block,
        def_header
    )
end

function api_fnct_hdr.func_proto_block(f)
    return string.format("%s i_%s(%s);", f.return_type, f.name, table.concat(f.args, ", "))
end

function api_fnct_hdr.api_id_enum_block(func_name)
    return string.format("\t%s%s,", S:_API_ID_PREFIX(), func_name)
end

function api_fnct_hdr.get_funame_block(func_name)
    return string.format("\t\tcase %s%s : return \"%s\";", S:_API_ID_PREFIX(), func_name, func_name)
end

function api_fnct_hdr.get_funid_block(func_name)
    return string.format("\telse if (strcmp(name, \"%s\") == 0) return %s%s;", func_name, S:_API_ID_PREFIX(), func_name)
end

function api_fnct_hdr.api_data_t_block(return_type, func_name, args_block)
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

function api_fnct_hdr.api_data_t_line(arg)
    return "\t\t\t" .. arg .. ";"
end

return api_fnct_hdr
