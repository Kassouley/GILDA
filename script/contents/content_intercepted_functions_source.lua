local itcp_fnct_src = {}

function itcp_fnct_src.content_1(MACRO_STRING, includes_str)
    return string.format([[
#include "%s"
#include "%s"
#include "%s"
%s
extern %s %s;

]],
        MACRO_STRING._IF_HEAD,
        MACRO_STRING._ITM_HEAD,
        MACRO_STRING._CB_HEAD,
        includes_str,
        MACRO_STRING._INTERCEPT_TABLE_T, MACRO_STRING._INTERCEPT_TABLE_DECL
    )
end

function itcp_fnct_src.content_2(f, MACRO_STRING, names_param_str)
    local function_header = string.format("%s %s(%s) {\n", f.return_type, f.name, table.concat(f.args, ", "))
    local cb_arg_1 = "IS_ENTER"
    local cb_arg_2 = MACRO_STRING._IF_FUN_ID_PREFIX .. f.name
    local cb_arg_3 = MACRO_STRING._CB_DATA_NAME
    local cb_call = string.format("\t%s(%s, %s, %s);\n", MACRO_STRING._CB_FUNC_DECL, cb_arg_1, cb_arg_2, cb_arg_3)
    local get_data_call = string.format("\t%s%s(%s);\n", MACRO_STRING._CB_GET_ARGS_PREFIX, f.name, cb_arg_3)

    local function_body = string.format("\t%s %s;\n%s%s", MACRO_STRING._API_DATA_T, cb_arg_3, get_data_call, cb_call)
    local function_ret_var = "__"..MACRO_STRING._INTERCEPTOR_NAME.."_ret__"

    cb_call = string.format("\t%s(IS_EXIT, %s, %s);\n", MACRO_STRING._CB_FUNC_DECL, cb_arg_2, cb_arg_3)

    if f.return_type ~= "void" then
        function_body = function_body .. string.format("\t%s %s = %s.%s%s(%s);\n%s%s\treturn %s;\n", f.return_type, function_ret_var, MACRO_STRING._INTERCEPT_TABLE_DECL, MACRO_STRING._INTERCEPT_FUNC_PREFIX, f.name, names_param_str, get_data_call, cb_call, function_ret_var)
    else
        function_body = function_body .. string.format("\t%s.%s%s(%s);\n%s%s\treturn;\n", MACRO_STRING._INTERCEPT_TABLE_DECL, MACRO_STRING._INTERCEPT_FUNC_PREFIX, f.name, names_param_str, get_data_call, cb_call)
    end

    function_body = function_body .. "}\n\n"
    return function_header .. function_body
end

return itcp_fnct_src
