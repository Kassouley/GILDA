local ContentManager = require("ContentManager")
local Content = require("Content")
local c_manager = require("c_manager")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._PLG_SRC_PATH, do_gen = false, finalize_callback = finalize_subcontent})
local hdr = ContentManager:new({path = S._PLG_HDR_PATH, do_gen = false, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src:generate_content()
    return S._SAMPLE_MSG..[[ 

#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._PLG_HDR..[["

]]..self.subcontents.callback_block

end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src:init_subcontent("callback_block", Content:new())

function src:generate_subcontents()
    self.subcontents["callback_block"]:addfLine([[
%s
{
    if (is_enter)
        printf("%%s | CID: %%lu\n", %s(activity->funid), %s());
    else if (!is_enter)
        %s(activity->funid, &activity->args);
}
    ]], S._PLG_CALLBACK_FUNC_DECL,
        S._IF_GET_FUNAME_FUNC, S._CID_GET_NEXT_FUNC,
        S._PLG_PROCESS_FUNC)
end

-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr:generate_content()
    local def_header = "PLUGIN_H"
    return S._SAMPLE_MSG..[[ 

#ifndef PLUGIN_H
#define PLUGIN_H

]]..self.subcontents.include_block..[[ 

]]..self.subcontents.proto_block..[[


#endif // PLUGIN_H
]]
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------
hdr:init_subcontent("include_block", Content:new())
hdr:init_subcontent("proto_block", Content:new())

function hdr:generate_subcontents()
    self.subcontents.include_block:addfLine("#include \"%s\"", S._DPLG_HDR)
    self.subcontents.proto_block:addfLine("%s;", S._PLG_CALLBACK_FUNC_DECL)
end

return {src=src, hdr=hdr}
