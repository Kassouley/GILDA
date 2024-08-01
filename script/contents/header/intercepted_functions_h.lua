local api_fnct_hdr = {}

function api_fnct_hdr.content(subcontent, includes_str)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_UPPER_ADJ.."_FUNCTIONS_H"
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..includes_str..[[
#include <string.h>

// ]]..S._DOMAIN_UPPER..[[ API ID enum
typedef enum {
]]..subcontent.api_id_enum_block..[[
    ]]..S._API_ID_PREFIX..[[NB_FUNCTION,
    ]]..S._API_ID_PREFIX..[[UNKNOWN,
} ]]..S._API_ID_T..[[;

// Return ]]..S._DOMAIN_UPPER..[[ API function name for a given ID
static inline const char* get_]]..S._DOMAIN..[[_funame_by_id(]]..S._API_ID_T..[[ id) {
    switch(id) {
]]..subcontent.get_funame_block..[[ 
        default : return NULL;
    }
    return NULL;
}

// Return ]]..S._DOMAIN_UPPER..[[ API function ID for a given name
static inline ]]..S._API_ID_T..[[ get_]]..S._DOMAIN..[[_funid_by_name(const char* name) {
    if (name == NULL) return ]]..S._API_ID_PREFIX..[[UNKNOWN;
]]..subcontent.get_funid_block..[[ 
    return ]]..S._API_ID_PREFIX..[[UNKNOWN;
}

// ]]..S._DOMAIN_UPPER..[[ API args
typedef union ]]..S._API_ARGS_S..[[ {
]]..subcontent.api_data_t_block..[[ 
} ]]..S._API_ARGS_T..[[;

// ]]..S._DOMAIN_UPPER..[[ API activity
typedef struct ]]..S._API_DATA_S..[[ {
    ]].. S._API_ID_T..[[ funid;
    uint64_t corrId;
    uint64_t start_time;
    uint64_t stop_time;
    ]]..S._API_ARGS_T..[[ args;
} ]]..S._API_DATA_T..[[;

// ]]..S._DOMAIN_UPPER..[[ API Function Prototype
]]..subcontent.func_proto_block..[[ 

#endif // ]]..def_header
end

function api_fnct_hdr.func_proto_block(f)
    return string.format("%s i_%s(%s);", f.return_type, f.name, table.concat(f.args, ", "))
end

function api_fnct_hdr.api_id_enum_block(func_name)
    return string.format("\t%s%s,", S._API_ID_PREFIX, func_name)
end

function api_fnct_hdr.get_funame_block(func_name)
    return string.format("\t\tcase %s%s : return \"%s\";", S._API_ID_PREFIX, func_name, func_name)
end

function api_fnct_hdr.get_funid_block(func_name)
    return string.format("\telse if (strcmp(name, \"%s\") == 0) return %s%s;", func_name, S._API_ID_PREFIX, func_name)
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
    return "\t\t" .. arg .. ";"
end

return api_fnct_hdr
