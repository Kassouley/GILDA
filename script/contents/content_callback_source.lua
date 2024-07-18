local cb_src = {}

function cb_src.content_1(MACRO_STRING)
    return string.format([[
#include <stdio.h>
#include <stdlib.h>

#include "%s"
#include "%s"

void (*%s)(%s);

void %s(void (*%s)(%s)) {
    %s = %s;
}

void %s(%s) {
    if (%s) {
        %s(%s, %s, %s);
    } else {
        fprintf(stderr, "No %s callback function has been set.\n");
    }
}
]],
        MACRO_STRING._IF_HEAD,
        MACRO_STRING._CB_HEAD,
        MACRO_STRING._STORED_CB_DECL, MACRO_STRING._CB_ARGS,
        MACRO_STRING._SET_CB_DECL, MACRO_STRING._CB_DECL, MACRO_STRING._CB_ARGS,
        MACRO_STRING._STORED_CB_DECL, MACRO_STRING._CB_DECL,
        MACRO_STRING._CB_FUNC_DECL, MACRO_STRING._CB_ARGS,
        MACRO_STRING._STORED_CB_DECL,
        MACRO_STRING._STORED_CB_DECL, MACRO_STRING._CB_ARG1_NAME, MACRO_STRING._CB_ARG2_NAME, MACRO_STRING._CB_ARG3_NAME,
        MACRO_STRING._INTERCEPTOR_NAME
    )
end

return cb_src
