local cb_src = {}

function cb_src.content(subcontents)
    local stored_cb_decl = "stored_"..S._DOMAIN.."_callback"
    return S._WARNING_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>

#include "]]..S._IF_HEAD..[["
#include "]]..S._CB_HEAD..[["

void (*]]..stored_cb_decl..[[)(]]..S._CB_ARGS..[[);

void ]]..S._SET_CALLBACK..[[(void (*]]..S._CALLBACK..[[)(]]..S._CB_ARGS..[[)) {
    ]]..stored_cb_decl..[[ = ]]..S._CALLBACK..[[;
}

void ]]..S._CALLBACK_FUNCTION..[[(bool is_enter, ]]..S._API_DATA_T..[[* activity) {
    if (]]..stored_cb_decl..[[) {
        ]]..stored_cb_decl..[[(is_enter, activity);
    } else {
        fprintf(stderr, "No ]]..S._DOMAIN..[[ callback function has been set.\n");
    }
}
]]
end

return cb_src
