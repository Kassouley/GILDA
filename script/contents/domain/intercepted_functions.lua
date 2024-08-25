local ContentManager = require("ContentManager")
local Content = require("Content")
local c_manager = require("c_manager")

local function finalize_subcontent(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._IF_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._IF_HDR_PATH, do_gen = true, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------

function src:generate_content(data)
    return S._WARNING_MSG..[[ 

#include <stdlib.h>
#include "]]..S._IF_HDR..[["
#include "]]..S._ATM_HDR..[["
#include "]]..S._CB_HDR..[["

]]..data.include..[[ 

extern ]]..S._ATM_INTERCEPT_TABLE_T..[[ ]]..S._ATM_INTERCEPT_TABLE_VAR..[[;

]]..self.subcontents.func_blk..[[ 

]]
end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src:init_subcontent("func_blk", Content:new())

function src:generate_subcontents(f, concat_param, _)
    local function_ret_var = "__"..S._DOMAIN.."_ret__"
    local content = Content:new()
    content:addfLine("%s i_%s(%s) {", f.ftype, f.fname, concat_param)
    content:increaseIndent()
    content:addfLine("%s* %s = (%s*)malloc(sizeof(%s));", S._IF_API_DATA_T, S._CB_API_DATA_VAR, S._IF_API_DATA_T, S._IF_API_DATA_T)
    if f.ftype ~= "void" then
        content:addfLine("%s %s;", f.ftype, function_ret_var)
    end
    content:addfLine("%s(%s, %s);", S._CB_MACRO_BEFORE, f.fname, S._CB_API_DATA_VAR)
    if f.ftype ~= "void" then
        content:addfLine("%s = %s.fn_%s(%s);", function_ret_var, S._ATM_INTERCEPT_TABLE_VAR, f.fname, table.concat(f.pname, ","))
    else
        content:addfLine("%s.fn_%s(%s);", S._ATM_INTERCEPT_TABLE_VAR, f.fname, table.concat(f.pname, ","))
    end
    content:addfLine("%s(%s, %s);", S._CB_MACRO_AFTER, f.fname, S._CB_API_DATA_VAR)
    if f.ftype ~= "void" then
        content:addfLine("return %s;", function_ret_var)
    else
        content:addLine("return;")
    end
    content:decreaseIndent()
    content:addLine("};\n")
    self.subcontents.func_blk:addfLine("%s", content:getContent())
end

-----------------------------
-- HEADER CONTENT
-----------------------------

function hdr:generate_content(data)
    local def_header = S._DOMAIN_UPPER.."_"..S._TOOLS_NAME_UPPER_ADJ.."_FUNCTIONS_H"
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..data.include..[[
#include <string.h>

// ]]..S._DOMAIN_UPPER..[[ API ID enum
typedef enum {
]]..self.subcontents.api_id_enum_block..[[ 
    ]]..S._IF_API_ID_PREFIX..[[NB_FUNCTION,
    ]]..S._IF_API_ID_PREFIX..[[UNKNOWN,
} ]]..S._IF_API_ID_T..[[;

// Return ]]..S._DOMAIN_UPPER..[[ API function name for a given ID
]]..S._IF_GET_FUNAME_FUNC_DECL..[[
{
    switch(id) {
]]..self.subcontents.get_funame_block..[[ 
        default : return NULL;
    }
    return NULL;
}

// Return ]]..S._DOMAIN_UPPER..[[ API function ID for a given name
]]..S._IF_GET_FUNID_FUNC_DECL..[[
{
    if (name == NULL) return ]]..S._IF_API_ID_PREFIX..[[UNKNOWN;
]]..self.subcontents.get_funid_block..[[ 
    return ]]..S._IF_API_ID_PREFIX..[[UNKNOWN;
}

// ]]..S._DOMAIN_UPPER..[[ API args
typedef union ]]..S._IF_API_ARGS_S..[[ {
]]..self.subcontents.api_data_t_block..[[ 
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
]]..self.subcontents.func_proto_block..[[ 

#endif // ]]..def_header
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------
hdr:init_subcontent("api_data_t_block", Content:new())
hdr:init_subcontent("api_id_enum_block", Content:new(1))
hdr:init_subcontent("func_proto_block", Content:new())
hdr:init_subcontent("get_funame_block", Content:new(2))
hdr:init_subcontent("get_funid_block", Content:new(1))

function hdr:generate_subcontents(f, concat_param, _)
    local function api_data_t_lines(pname, ptype)
        local api_data_t_lines = Content:new(2)
        for i = 1, #pname do
            api_data_t_lines:addfLine("%s;", c_manager.concat_param(ptype[i], pname[i]))
        end
        return api_data_t_lines:getContent()
    end
    
    -- API data type block
    self.subcontents.api_data_t_block:addLine("\tstruct {")
    if f.ftype ~= "void" then
        self.subcontents.api_data_t_block:addfLine("\t\t%s ret_value;", f.ftype)
    end
    self.subcontents.api_data_t_block:addfLine("%s", api_data_t_lines(f.pname, f.ptype))
    self.subcontents.api_data_t_block:addfLine("\t} %s;", f.fname)

    -- API ID enum block
    self.subcontents.api_id_enum_block:addfLine("%s%s,", S._IF_API_ID_PREFIX, f.fname)

    -- Function prototype block
    self.subcontents.func_proto_block:addfLine("%s i_%s(%s);", f.ftype, f.fname, concat_param)

    -- Get function name block
    self.subcontents.get_funame_block:addfLine("case %s%s : return \"%s\";", S._IF_API_ID_PREFIX, f.fname, f.fname)

    -- Get function ID block
    self.subcontents.get_funid_block:addfLine("else if (strcmp(name, \"%s\") == 0) return %s%s;", f.fname, S._IF_API_ID_PREFIX, f.fname)
end

return {src=src, hdr=hdr}
