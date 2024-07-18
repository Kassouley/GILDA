local itcp_fnct_src = {}

-- AUTOGEN CONTENT INTERCEPTED_FUNCTIONS SOURCE --
function itcp_fnct_src.content_1(MACRO_STRING, includes_str)
    return  "#include \""..MACRO_STRING._IF_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._ITM_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._CB_HEAD.."\"\n"..
            includes_str..
            "extern "..MACRO_STRING._INTERCEPT_TABLE_T.." "..MACRO_STRING._INTERCEPT_TABLE_DECL..";\n\n"
end

function itcp_fnct_src.content_2(f, MACRO_STRING, names_param_str)
    local function_header = f.return_type.." "..f.name.."("..table.concat(f.args, ", ")..") {\n"
    local function_body = "\t"..MACRO_STRING._CB_FUNC_DECL.."(1, \""..f.name.."\");\n"
                          
    if f.return_type ~= "void" then
        function_body = function_body ..
                        "\t"..f.return_type.." ret = "..MACRO_STRING._INTERCEPT_TABLE_DECL.."."..MACRO_STRING._INTERCEPT_FUNC_PREFIX..f.name.."("..names_param_str..");\n"..
                        "\t"..MACRO_STRING._CB_FUNC_DECL.."(0, \""..f.name.."\");\n"..
                        "\treturn ret;\n"
    else
        function_body = function_body ..
                        "\t"..MACRO_STRING._INTERCEPT_TABLE_DECL.."."..MACRO_STRING._INTERCEPT_FUNC_PREFIX..f.name.."("..names_param_str..");\n"..
                        "\t"..MACRO_STRING._CB_FUNC_DECL.."(0, \""..f.name.."\");\n"..
                        "\treturn;\n"
    end
    
    function_body = function_body.."}\n\n"
    return function_header..function_body
end
-- AUTOGEN CONTENT INTERCEPTED_FUNCTIONS SOURCE --

return itcp_fnct_src
    