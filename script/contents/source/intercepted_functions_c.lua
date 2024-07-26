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
    if f.return_type ~= "void" then
        local function_ret_var = "__"..S:_DOMAIN().."_ret__"
        return string.format([[
%s i_%s(%s) {
    %s %s;
    %s_CALLBACK_BEFORE(%s);
    %s = %s.fn_%s(%s);
    %s_CALLBACK_AFTER(%s);
    return %s;
}
    
]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            f.return_type, function_ret_var,
            S:_DOMAIN_UPPER(), f.name,
            function_ret_var, S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str,
            S:_DOMAIN_UPPER(), f.name,
            function_ret_var
        )
    else
        return string.format([[
%s i_%s(%s) {
    %s_CALLBACK_BEFORE(%s);
    %s.fn_%s(%s);
    %s_CALLBACK_AFTER(%s);
    return;
}

]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S:_DOMAIN_UPPER(), f.name,
            S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str,
            S:_DOMAIN_UPPER(), f.name
        )
    end
end

return itcp_fnct_src
