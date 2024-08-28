local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._CB_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._CB_HDR_PATH, do_gen = true, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------

function src:generate_content()
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>

#include "]]..S._IF_HDR..[["
#include "]]..S._CB_HDR..[["

void (*]]..S._CB_STORED_CALLBACK_FUNC..[[)(]]..S._CB_ARGS..[[);

]]..S._CB_SET_CALLBACK_FUNC_DECL..[[ {
    ]]..S._CB_STORED_CALLBACK_FUNC..[[ = ]]..S._CB_CALLBACK..[[;
}

]]..S._CB_CALLBACK_FUNC_DECL..[[ {
    if (]]..S._CB_STORED_CALLBACK_FUNC..[[) {
        ]]..S._CB_STORED_CALLBACK_FUNC..[[(is_enter, activity);
    } else {
        fprintf(stderr, "No ]]..S._DOMAIN..[[ callback function has been set.\n");
    }
}
]]
end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

-----------------------------
-- HEADER CONTENT
-----------------------------

function hdr:generate_content(data)
    local def_header = S._DOMAIN_UPPER.."_CALLBACK_H"
    local macro_call = string.format("GET_CB_ARGS_DATA_##v(%s)", S._CB_API_DATA_VAR)
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include <stdbool.h>

#include "]]..S._IF_HDR..[["
]]..data.include..[[ 

#define IS_ENTER 1
#define IS_EXIT 0

]]..S._CB_SET_CALLBACK_FUNC_DECL..[[;
]]..S._CB_CALLBACK_FUNC_DECL..[[;

// CALLBACK BEFORE
#define ]]..S._CB_MACRO_BEFORE..[[(v, ]]..S._CB_API_DATA_VAR..[[) { \
    ]]..S._CB_API_DATA_VAR..[[->funid = ]]..S._IF_API_ID_PREFIX..[[##v; \
    ]]..macro_call..[[; \
    ]]..S._CB_CALLBACK_FUNC..[[(IS_ENTER, ]]..S._CB_API_DATA_VAR..[[); \
};

// CALLBACK AFTER
#define ]]..S._CB_MACRO_AFTER..[[(v, ]]..S._CB_API_DATA_VAR..[[) { \
    ]]..macro_call..[[; \
    ]]..S._CB_CALLBACK_FUNC..[[(IS_EXIT, ]]..S._CB_API_DATA_VAR..[[); \
};

]]..self.subcontents.cb_get_args_block..[[ 
#endif // ]]..def_header
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------
hdr:init_subcontent("cb_get_args_block", Content:new())

function hdr:generate_subcontents(f, _, _)
    local cb_get_args_lines = Content:new(1)
    for i = 1, #f.pname do
        cb_get_args_lines:addfLine("%s->args.%s.%s = (%s)%s; \\", S._CB_API_DATA_VAR, f.fname, f.pname[i], f.ptype[i], f.pname[i])
    end
    cb_get_args_lines = cb_get_args_lines:getContent()

    self.subcontents["cb_get_args_block"]:addfLine("#define GET_CB_ARGS_DATA_%s(%s) { \\", f.fname, S._CB_API_DATA_VAR)
    if f.ftype ~= "void" then
        self.subcontents["cb_get_args_block"]:addfLine("\t%s->args.%s.ret_value = (%s)%s; \\", S._CB_API_DATA_VAR, f.fname, f.ftype, "__"..S._DOMAIN.."_ret__")
    end
    self.subcontents["cb_get_args_block"]:addLine(cb_get_args_lines == "" and "\\" or cb_get_args_lines)
    self.subcontents["cb_get_args_block"]:addLine("};\n")
end

return {src=src, hdr=hdr}
