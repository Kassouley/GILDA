local itcp_fnct_src = {}

function itcp_fnct_src.content(includes_str, subcontent)
    return string.format([[
#include "%s"
#include "%s"
#include "%s"
%s
extern %s %s;

%s

]],
        S:_IF_HEAD(),
        S:_ITM_HEAD(),
        S:_CB_HEAD(),
        includes_str,
        S:_INTERCEPT_TABLE_T(), S:_INTERCEPT_TABLE_VAR(),
        subcontent.func_blk
    )
end

function itcp_fnct_src.func_blk(f, names_param_str)
    local fn_call = ""
    local fn_return = ""
    if f.return_type ~= "void" then
        local function_ret_var = "__"..S:_DOMAIN().."_ret__"
        fn_call = string.format("%s %s = %s.fn_%s(%s)", f.return_type, function_ret_var, S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str)
        fn_return = string.format("return %s", function_ret_var)
    else
        fn_call = string.format("%s.fn_%s(%s)", S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str)
        fn_return = string.format("return")
    end
    local macro_call = string.format("GET_CB_ARGS_DATA_%s(%s)", f.name, S:_API_DATA_VAR())
    return string.format([[
%s %s(%s) {
    %s %s = {};
    %s;
    %s(IS_ENTER, %s, %s);

    %s;

    %s;
    %s(IS_EXIT, %s, %s);

    %s;
}

]], 
        f.return_type, f.name, table.concat(f.args, ", "),
        S:_API_DATA_T(), S:_API_DATA_VAR(),
        macro_call,
        S:_CALLBACK_FUNCTION(), S:_API_ID_PREFIX()..f.name, S:_API_DATA_VAR(), 
        fn_call,
        macro_call,
        S:_CALLBACK_FUNCTION(), S:_API_ID_PREFIX()..f.name, S:_API_DATA_VAR(), 
        fn_return
    )
end

return itcp_fnct_src
