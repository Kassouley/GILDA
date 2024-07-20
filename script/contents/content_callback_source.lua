local cb_src = {}

function cb_src.content()
    local stored_cb_decl = "stored_"..S:_DOMAIN().."_callback"
    return string.format([[
#include <stdio.h>
#include <stdlib.h>

#include "%s"
#include "%s"

void (*%s)(%s);

void %s(void (*%s)(%s)) {
    %s = %s;
}

void %s(bool is_enter, %s func_id, %s data) {
    if (%s) {
        %s(is_enter, func_id, data);
    } else {
        fprintf(stderr, "No %s callback function has been set.\n");
    }
}
]],
        S:_IF_HEAD(),
        S:_CB_HEAD(),
        stored_cb_decl, S:_CB_ARGS(),
        S:_SET_CALLBACK(), S:_CALLBACK(), S:_CB_ARGS(),
        stored_cb_decl, _CALLBACK,
        S:_CALLBACK_FUNCTION(), S:_API_ID_T(), S:_API_DATA_T(),
        stored_cb_decl,
        stored_cb_decl,
        S:_DOMAIN()
    )
end

return cb_src
