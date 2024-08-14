local c_manager = require("c_manager")

local src = {}
local hdr = {}

src.kpath = "_PLG_SRC_PATH"
hdr.kpath = "_PLG_HDR_PATH"

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._SAMPLE_MSG..[[ 

#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._PLG_HDR..[["

]]..subcontents.callback_block

end

function src.callback_block()
    return [[
]]..S._PLG_CALLBACK_FUNC_DECL..[[ 
{
    if (is_enter)
        printf("%s | CID: %lu\n", ]]..S._IF_GET_FUNAME_FUNC..[[(activity->funid), ]]..S._CID_GET_NEXT_FUNC..[[());
    else if (!is_enter)
        ]]..S._PLG_PROCESS_FUNC..[[(activity->funid, &activity->args);
}
]]
end


-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr.content(subcontents)
    local def_header = "PLUGIN_H"
    return S._SAMPLE_MSG..[[ 

#ifndef PLUGIN_H
#define PLUGIN_H

]]..subcontents.include_block..[[ 

]]..subcontents.proto_block..[[


#endif // PLUGIN_H
]]
end


function hdr.include_block()
    return "#include \""..S._DPLG_HDR.."\""
end


function hdr.proto_block()
    return S._PLG_CALLBACK_FUNC_DECL..";"
end

return {src=src, hdr=hdr}
