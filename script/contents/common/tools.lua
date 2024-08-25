local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local src = ContentManager:new({path = S._TOOL_SRC_PATH, do_gen = false, finalize_callback = finalize_subcontent})


function src:generate_content()
    return S._SAMPLE_MSG..[[ 

#include <stdio.h>
#include <stdlib.h>
#include "]]..S._INTERCEPTOR_HDR..[["
#include "]]..S._PLG_HDR..[["

__attribute__((constructor)) void init(void) {
    ]]..S._I_INIT_FUNC..[[();

    bool* is_]]..S._TOOLS_NAME_ADJ..[[ = ]]..S._ENV_GET_DOMAIN_FUNC..[[();

]]..self.subcontents.subcontent..[[ 

    free(is_]]..S._TOOLS_NAME_ADJ..[[);
}

__attribute__((destructor)) void fini(void) {
    ]]..S._I_FINI_FUNC..[[();
}
]]
end

src:init_subcontent("subcontent", Content:new(1))

function src:generate_subcontents()
    self.subcontents.subcontent:addfLine("if (is_%s[%s]) {", S._TOOLS_NAME_ADJ, S._DOMAIN_ID)
    self.subcontents.subcontent:addfLine("\t%s(%s);", S._CB_SET_CALLBACK_FUNC, S._PLG_CALLBACK_FUNC)
    self.subcontents.subcontent:addfLine("\t%s(%s);", S._I_ENABLE_DOMAIN_FUNC, S._DOMAIN_ID)
    self.subcontents.subcontent:addLine("}")
end

return {src=src}
