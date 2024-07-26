local fnct_src = {}

function fnct_src.content(includes_str, subcontent)
    return string.format([[
#include "%s"
%s
extern %s %s;

%s

]],
        S:_ITM_HEAD(),
        includes_str,
        S:_INTERCEPT_TABLE_T(), S:_INTERCEPT_TABLE_VAR(),
        subcontent.func_blk
    )
end

function fnct_src.func_blk(f, names_param_str)
    if f.return_type ~= "void" then
        return string.format([[
%s %s(%s) { 
    return %s.ptr_%s(%s); 
}

]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str
        )
    else
        return string.format([[
%s %s(%s) { 
    %s.ptr_%s(%s); 
}

]], 
            f.return_type, f.name, table.concat(f.args, ", "),
            S:_INTERCEPT_TABLE_VAR(), f.name, names_param_str
        )
    end
end

return fnct_src
