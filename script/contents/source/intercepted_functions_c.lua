local api_fnct_src = {}

function api_fnct_src.content(subcontent, includes_str)
    return S._WARNING_MSG..[[ 

#include <stdlib.h>
#include "]]..S._IF_HEAD..[["
#include "]]..S._ATM_HEAD..[["
#include "]]..S._CB_HEAD..[["

]]..includes_str..[[ 

extern ]]..S._INTERCEPT_TABLE_T..[[ ]]..S._INTERCEPT_TABLE_VAR..[[;

]]..subcontent.func_blk..[[ 

]]
end

function api_fnct_src.func_blk(f, names_param_str)
    if f.return_type ~= "void" then
        local function_ret_var = "__"..S._DOMAIN.."_ret__"
        return string.format([[
%s i_%s(%s) {
    %s* %s = (%s*)malloc(sizeof(%s));
    %s %s;
    %s_CALLBACK_BEFORE(%s, %s);
    %s = %s.fn_%s(%s);
    %s_CALLBACK_AFTER(%s, %s);
    return %s;
}
    
]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S._API_DATA_T, S._API_DATA_VAR, S._API_DATA_T, S._API_DATA_T,
            f.return_type, function_ret_var,
            S._DOMAIN_UPPER, f.name, S._API_DATA_VAR,
            function_ret_var, S._INTERCEPT_TABLE_VAR, f.name, names_param_str,
            S._DOMAIN_UPPER, f.name, S._API_DATA_VAR,
            function_ret_var
        )
    else
        return string.format([[
%s i_%s(%s) {
    %s* %s = (%s*)malloc(sizeof(%s));
    %s_CALLBACK_BEFORE(%s, %s);
    %s.fn_%s(%s);
    %s_CALLBACK_AFTER(%s, %s);
    return;
}

]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S._API_DATA_T, S._API_DATA_VAR, S._API_DATA_T, S._API_DATA_T,
            S._DOMAIN_UPPER, f.name, S._API_DATA_VAR,
            S._INTERCEPT_TABLE_VAR, f.name, names_param_str,
            S._DOMAIN_UPPER, f.name, S._API_DATA_VAR
        )
    end
end

return api_fnct_src
