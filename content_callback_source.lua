local cb_src = {}

function cb_src.content_1(MACRO_STRING)
    return  "#include <stdio.h>\n"..
            "#include <stdlib.h>\n"..
            "#include \""..MACRO_STRING._IF_HEAD.."\"\n"..
            "#include \""..MACRO_STRING._CB_HEAD.."\"\n\n"..
            "void (*"..MACRO_STRING._STORED_CB_DECL..")("..MACRO_STRING._CB_ARGS..");\n\n"..
            "void "..MACRO_STRING._SET_CB_DECL.."(void (*"..MACRO_STRING._CB_DECL..")("..MACRO_STRING._CB_ARGS..")) {\n"..
                "\t"..MACRO_STRING._STORED_CB_DECL.." = "..MACRO_STRING._CB_DECL..";\n"..
            "}\n\n"..
            "void "..MACRO_STRING._CB_FUNC_DECL.."("..MACRO_STRING._CB_ARGS..") {\n"..
            "\tif ("..MACRO_STRING._STORED_CB_DECL..") {\n"..
                "\t\t"..MACRO_STRING._STORED_CB_DECL.."("..MACRO_STRING._CB_ARG1_NAME..", "..MACRO_STRING._CB_ARG2_NAME..", "..MACRO_STRING._CB_ARG3_NAME..");\n"..
            "\t} else {\n"..
                "\t\tfprintf(stderr, \"No "..MACRO_STRING._INTERCEPTOR_NAME.." callback function has been set.\\n\");\n"..
            "\t}\n"..
            "}"
end

return cb_src