local cb_hdr = {}


-- Generates the content for the callback header file
function cb_hdr.content(subcontent, includes_str)
    local def_header = S._DOMAIN_UPPER.."_CALLBACK_H"
    local macro_call = string.format("GET_CB_ARGS_DATA_##v(%s)", S._API_DATA_VAR)
    local content =S._WARNING_MSG..[[


#ifndef ]]..def_header..[[

#define ]]..def_header..[[


#include "]]..S._IF_HEAD..[["
]]..includes_str..[[

#define IS_ENTER 1
#define IS_EXIT 0

void ]]..S._CALLBACK_FUNCTION.."("..S._CB_ARGS..[[);
void ]]..S._SET_CALLBACK..[[(void (*]]..S._CALLBACK..")("..S._CB_ARGS..[[));

// CALLBACK BEFORE
#define ]]..S._DOMAIN_UPPER..[[_CALLBACK_BEFORE(v, ]]..S._API_DATA_VAR..[[) { \
    ]]..S._API_DATA_VAR..[[->funid = ]]..S._API_ID_PREFIX..[[##v; \
    ]]..macro_call..[[; \
    ]]..S._CALLBACK_FUNCTION..[[(IS_ENTER, ]]..S._API_DATA_VAR..[[); \
};

// CALLBACK AFTER
#define ]]..S._DOMAIN_UPPER..[[_CALLBACK_AFTER(v, ]]..S._API_DATA_VAR..[[) { \
    ]]..macro_call..[[; \
    ]]..S._CALLBACK_FUNCTION..[[(IS_EXIT, ]]..S._API_DATA_VAR..[[); \
};

]]..subcontent.cb_get_args_block..[[

#endif // ]]..def_header..[[
]]
    return content
end

-- Generates the macro definition for getting callback arguments data
function cb_hdr.cb_get_args_block(return_type, func_name, cb_get_args_block)
    if return_type == "void" then
        return string.format([[
#define GET_CB_ARGS_DATA_%s(%s) { \
%s
};
]],
        func_name, S._API_DATA_VAR,
        cb_get_args_block == "" and "\\" or cb_get_args_block
    )
    else
        return string.format([[
#define GET_CB_ARGS_DATA_%s(%s) { \
    %s->args.%s.ret_value = (%s)%s; \
%s
};
]],
        func_name,
        S._API_DATA_VAR,
        S._API_DATA_VAR, 
        func_name, 
        return_type, 
        "__"..S._DOMAIN.."_ret__",
        cb_get_args_block == "" and "\\" or cb_get_args_block
    )
    end
end

-- Generates a line for setting a callback argument
function cb_hdr.cb_get_args_line(func_name, arg, arg_type)
    return string.format("\t%s->args.%s.%s = (%s)%s; \\", 
        S._API_DATA_VAR, 
        func_name, 
        arg, 
        arg_type, 
        arg
    )
end

return cb_hdr
