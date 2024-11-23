local ContentManager = require("ContentManager")
local Content = require("Content")


dplugin_c = setmetatable({}, ContentManager)
dplugin_c.__index = dplugin_c

function dplugin_c:new(options, template_path, output_path)
    local do_not_gen = false
    if options.plugin_gen == false then
        do_not_gen = true
    elseif options.plugin_gen and not (options.plugin_gen["stdout"] or options.plugin_gen["all"]) then
        do_not_gen = false
    end
    local attribute = {
        file_name = S:STRING("DPLG_SRC"),
        do_not_gen = do_not_gen,
        subcontents = {
            ["case_block"] = Content:new(2)
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, dplugin_c)
    return instance
end

function dplugin_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <stdio.h>
#include <]]..S:STRING("INTERCEPTOR_HDR")..[[>
#include "]]..S:STRING("DPLG_HDR")..[["

]]..S:STRING("PLG_OE_CALLBACK_FUNC_DECL")..[[
{
    ]]..S:STRING("IF_GET_POINTED_ARGS")..[[(id, &activity->]]..S:STRING("DOMAIN")..[[_args, 1);
    activity->phase = ]]..S:STRING("LC_GET_PHASE_FUNC")..[[();
    activity->domain = domain;
    activity->corr_id = get_correlation_id();
    activity->id = push_id();
    activity->funid = id;
}

]]..S:STRING("PLG_OX_CALLBACK_FUNC_DECL")..[[
{
    ]]..S:STRING("IF_GET_POINTED_ARGS")..[[(id, &activity->]]..S:STRING("DOMAIN")..[[_args, 0);
    activity->pid = get_pid();
    activity->tid = get_tid();
    printf("-----------\n");
    printf("PHASE:%d : %s | ID: %lu | CID: %lu\n", activity->phase, ]]..S:STRING("IF_GET_FUNAME_FUNC")..[[(activity->funid), activity->id, activity->corr_id);
    ]]..S:STRING("PLG_PROCESS_FUNC")..[[(activity->funid, &activity->]]..S:STRING("DOMAIN")..[[_args);
    pop_id();
}

]]..S:STRING("PLG_PROCESS_FUNC_DECL")..[[
{
    switch(funid) {
]]..self.subcontents.case_block..[[ 
        default : break;
    }
}

]]
end

function dplugin_c:generate_subcontents(f)
    self.subcontents["case_block"]:addfLine("case %s%s : PROCESS_ARGS_%s(args); break;", S:STRING("IF_API_ID_PREFIX"), f.fname, f.fname) 
end

return dplugin_c, "DOMAIN"
