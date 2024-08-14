local src = {}
local hdr = {}

src.kpath = "_CB_SRC_PATH"
hdr.kpath = "_CB_HDR_PATH"

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
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
-- HEADER CONTENT
-----------------------------
function hdr.content(subcontents)
    local def_header = S._DOMAIN_UPPER.."_CALLBACK_H"
    local macro_call = string.format("GET_CB_ARGS_DATA_##v(%s)", S._CB_API_DATA_VAR)
    local content =S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include "]]..S._IF_HDR..[["
]]..subcontents.include..[[ 

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

]]..subcontents.cb_get_args_block..[[ 

#endif // ]]..def_header
    return content
end

function hdr.cb_get_args_block(ftype, fname, cb_get_args_block)
    if ftype == "void" then
        return string.format([[
#define GET_CB_ARGS_DATA_%s(%s) { \
%s
};
]],
        fname, S._CB_API_DATA_VAR,
        cb_get_args_block == "" and "\\" or cb_get_args_block
    )
    else
        return string.format([[
#define GET_CB_ARGS_DATA_%s(%s) { \
    %s->args.%s.ret_value = (%s)%s; \
%s
};
]],
        fname,
        S._CB_API_DATA_VAR,
        S._CB_API_DATA_VAR, 
        fname, 
        ftype, 
        "__"..S._DOMAIN.."_ret__",
        cb_get_args_block == "" and "\\" or cb_get_args_block
    )
    end
end

function hdr.cb_get_args_line(fname, ptype, pname)
    return string.format("\t%s->args.%s.%s = (%s)%s; \\", 
        S._CB_API_DATA_VAR, 
        fname, 
        pname, 
        ptype, 
        pname
    )
end

return {src=src, hdr=hdr}
