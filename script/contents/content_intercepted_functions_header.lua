local itcp_fnct_hdr = {}

function itcp_fnct_hdr.content(includes_str, subcontent)
    local def_header = string.format(
        "%s_%s_FUNCTIONS_H", S:_DOMAIN_UPPER(), S._TOOLS_NAME_UPPER_ADJ
    )
    return string.format([[
#ifndef %s
#define %s
%s

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

// %s API data
typedef struct %s {
    tuint64_t corrId;
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
        subcontent.api_id_enum_block,
        _API_ID_T,
        S:_DOMAIN_UPPER(), 
        S:_DOMAIN(), S:_API_ID_T(),
        subcontent.get_funame_block,
        S:_DOMAIN_UPPER(), 
        S:_API_DATA_S(),
        subcontent.api_data_t_block,
        S:_API_DATA_T()
    )
end


function itcp_fnct_hdr.api_id_enum_block(func_name, i)
    return string.format("\t%s%s = %d,\n", S:_API_ID_PREFIX(), func_name, i)
end

function itcp_fnct_hdr.get_funame_block(func_name)
    return string.format("\t\tcase %s%s : return \"%s\";\n", S:_API_ID_PREFIX(), func_name, func_name)
end

function itcp_fnct_hdr.api_data_t_block(func_name, args_block)
    return string.format([[
        struct {
%s
        } %s;
]], args_block, func_name)
end

function itcp_fnct_hdr.api_data_t_line(arg)
    return "\t\t\t" .. arg .. ";"
end

return itcp_fnct_hdr
