local src = {}
local hdr = {}

src.kpath = "_IF_SRC_PATH"
hdr.kpath = "_IF_HDR_PATH"

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include <stdlib.h>
#include "]]..S._IF_HDR..[["
#include "]]..S._ATM_HDR..[["
#include "]]..S._CB_HDR..[["

]]..subcontents.include..[[ 

extern ]]..S._ATM_INTERCEPT_TABLE_T..[[ ]]..S._ATM_INTERCEPT_TABLE_VAR..[[;

]]..subcontents.func_blk..[[ 

]]
end

function src.func_blk(ftype, fname, concat_pname, concat_param)
    if ftype ~= "void" then
        local function_ret_var = "__"..S._DOMAIN.."_ret__"
        return [[
]]..ftype..[[ i_]]..fname..[[(]]..concat_param..[[) {
    ]]..S._IF_API_DATA_T..[[* ]]..S._CB_API_DATA_VAR..[[ = (]]..S._IF_API_DATA_T..[[*)malloc(sizeof(]]..S._IF_API_DATA_T..[[));
    ]]..ftype..[[ ]]..function_ret_var..[[;
    ]]..S._CB_MACRO_BEFORE..[[(]]..fname..[[, ]]..S._CB_API_DATA_VAR..[[);
    ]]..function_ret_var..[[ = ]]..S._ATM_INTERCEPT_TABLE_VAR..[[.fn_]]..fname..[[(]]..concat_pname..[[);
    ]]..S._CB_MACRO_AFTER..[[(]]..fname..[[, ]]..S._CB_API_DATA_VAR..[[);
    return ]]..function_ret_var..[[;
}
]]
    else
        return [[
]]..ftype..[[ i_]]..fname..[[(]]..concat_param..[[) {
    ]]..S._IF_API_DATA_T..[[* ]]..S._CB_API_DATA_VAR..[[ = (]]..S._IF_API_DATA_T..[[*)malloc(sizeof(]]..S._IF_API_DATA_T..[[));
    ]]..S._CB_MACRO_BEFORE..[[(]]..fname..[[, ]]..S._CB_API_DATA_VAR..[[);
    ]]..S._ATM_INTERCEPT_TABLE_VAR..[[.fn_]]..fname..[[(]]..concat_pname..[[);
    ]]..S._CB_MACRO_AFTER..[[(]]..fname..[[, ]]..S._CB_API_DATA_VAR..[[);
    return;
}
]]
    end
end


-----------------------------
-- HDRER CONTENT
-----------------------------
function hdr.content(subcontents)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_UPPER_ADJ.."_FUNCTIONS_H"
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..subcontents.include..[[
#include <string.h>

// ]]..S._DOMAIN_UPPER..[[ API ID enum
typedef enum {
]]..subcontents.api_id_enum_block..[[
    ]]..S._IF_API_ID_PREFIX..[[NB_FUNCTION,
    ]]..S._IF_API_ID_PREFIX..[[UNKNOWN,
} ]]..S._IF_API_ID_T..[[;

// Return ]]..S._DOMAIN_UPPER..[[ API function name for a given ID
]]..S._IF_GET_FUNAME_FUNC_DECL..[[
{
    switch(id) {
]]..subcontents.get_funame_block..[[ 
        default : return NULL;
    }
    return NULL;
}

// Return ]]..S._DOMAIN_UPPER..[[ API function ID for a given name
]]..S._IF_GET_FUNID_FUNC_DECL..[[
{
    if (name == NULL) return ]]..S._IF_API_ID_PREFIX..[[UNKNOWN;
]]..subcontents.get_funid_block..[[ 
    return ]]..S._IF_API_ID_PREFIX..[[UNKNOWN;
}

// ]]..S._DOMAIN_UPPER..[[ API args
typedef union ]]..S._IF_API_ARGS_S..[[ {
]]..subcontents.api_data_t_block..[[ 
} ]]..S._IF_API_ARGS_T..[[;

// ]]..S._DOMAIN_UPPER..[[ API activity
typedef struct ]]..S._IF_API_DATA_S..[[ {
    ]].. S._IF_API_ID_T..[[ funid;
    uint64_t corrId;
    uint64_t start_time;
    uint64_t stop_time;
    uint64_t pid;
    uint64_t tid;
    ]]..S._IF_API_ARGS_T..[[ args;
} ]]..S._IF_API_DATA_T..[[;

// ]]..S._DOMAIN_UPPER..[[ API Function Prototype
]]..subcontents.func_proto_block..[[ 

#endif // ]]..def_header
end

function hdr.func_proto_block(ftype, fname, concat_param)
    return string.format("%s i_%s(%s);", ftype, fname, concat_param)
end

function hdr.api_id_enum_block(fname)
    return string.format("\t%s%s,", S._IF_API_ID_PREFIX, fname)
end

function hdr.get_funame_block(fname)
    return string.format("\t\tcase %s%s : return \"%s\";", S._IF_API_ID_PREFIX, fname, fname)
end

function hdr.get_funid_block(fname)
    return string.format("\telse if (strcmp(name, \"%s\") == 0) return %s%s;", fname, S._IF_API_ID_PREFIX, fname)
end

function hdr.api_data_t_block(ftype, fname, args_block)
    if ftype == "void" then
        return string.format([[
    struct {
%s
    } %s;
]], 
        args_block, fname)
    else
        return string.format([[
    struct {
        %s ret_value;
%s
    } %s;
]], 
        ftype, args_block, fname)
    end
end

function hdr.api_data_t_line(declaration)
    return "\t\t" .. declaration .. ";"
end

return {src=src, hdr=hdr}
