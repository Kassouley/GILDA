local api_fnct_src = {}

function api_fnct_src.content(subcontent, includes_str)
    return string.format([[
#include "%s"
#include "%s"
#include "%s"
%s
extern %s %s;

%s

]],
        S:_IF_HEAD(),
        S:_ATM_HEAD(),
        S:_CB_HEAD(),
        includes_str,
        S:_INTERCEPT_TABLE_T(), S:_INTERCEPT_TABLE_VAR(),
        subcontent.func_blk
    )
end

function api_fnct_src.func_blk(f, names_param_str)
    if f.return_type ~= "void" then
        local function_ret_var = "__"..S:_DOMAIN().."_ret__"
        return string.format([[
%s i_%s(%s) {
    %s %s = {};
    %s %s;
    %s_CALLBACK_BEFORE(%s, %s);
    %s = %s.fn_%s(%s);
    %s_CALLBACK_AFTER(%s, %s);
    return %s;
}
    
]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S:_API_DATA_T(), S:_API_DATA_VAR(),
            f.return_type, function_ret_var,
            S:_DOMAIN_UPPER(), f.name, S:_API_DATA_VAR(),
            function_ret_var, S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str,
            S:_DOMAIN_UPPER(), f.name, S:_API_DATA_VAR(),
            function_ret_var
        )
    else
        return string.format([[
%s i_%s(%s) {
    %s %s = {};
    %s_CALLBACK_BEFORE(%s, %s);
    %s.fn_%s(%s);
    %s_CALLBACK_AFTER(%s, %s);
    return;
}

]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S:_API_DATA_T(), S:_API_DATA_VAR(),
            S:_DOMAIN_UPPER(), f.name, S:_API_DATA_VAR(),
            S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str,
            S:_DOMAIN_UPPER(), f.name, S:_API_DATA_VAR()
        )
    end
end

return api_fnct_src
