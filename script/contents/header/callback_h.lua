local cb_hdr = {}

-- Generates the content for the callback header file
function cb_hdr.content(subcontent, includes_str)
    local def_header = S:_DOMAIN_UPPER().."_CALLBACK_H"
    local content = string.format([[
#ifndef %s
#define %s

#include "%s"
%s
#define IS_ENTER 1
#define IS_EXIT 0

void %s(%s);
void %s(void (*%s)(%s));

%s

#endif
]],
        def_header,
        def_header,
        S:_IF_HEAD(),
        includes_str,
        S:_CALLBACK_FUNCTION(), S:_CB_ARGS(),
        S:_SET_CALLBACK(), S:_CALLBACK(), S:_CB_ARGS(),
        subcontent.cb_get_args_block
    )
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
        func_name,
        S:_API_DATA_VAR(),
        cb_get_args_block == "" and "\\" or cb_get_args_block
    )
    else
        return string.format([[
#define GET_CB_ARGS_DATA_%s(%s) { \
    %s.args.%s.ret_value = (%s)%s; \
%s
};
]],
        func_name,
        S:_API_DATA_VAR(),
        S:_API_DATA_VAR(), 
        func_name, 
        return_type, 
        "__"..S:_DOMAIN().."_ret__",
        cb_get_args_block == "" and "\\" or cb_get_args_block
    )
    end
end

-- Generates a line for setting a callback argument
function cb_hdr.cb_get_args_line(func_name, arg, arg_type)
    return string.format("\t%s.args.%s.%s = (%s)%s; \\", 
        S:_API_DATA_VAR(), 
        func_name, 
        arg, 
        arg_type, 
        arg
    )
end

return cb_hdr
