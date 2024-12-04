local ContentManager = require("ContentManager")
local Content = require("Content")

lifecycle_c = setmetatable({}, ContentManager)
lifecycle_c.__index = lifecycle_c

function lifecycle_c:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("LC_SRC"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, lifecycle_c)
    return instance
end

function lifecycle_c:generate_content()
    return S:STRING("WARNING_MSG")..[[ 

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dlfcn.h>
#include <time.h>
#include <unistd.h>
#include "]]..S:STRING("INTERCEPTOR_HDR")..[["
#include "]]..S:STRING("LC_HDR")..[["

static int (*main_fn)(int, char **, char **);

]]..S:STRING("LC_T")..[[ lifecycle;

]]..S:STRING("LC_INIT_FUNC_DECL")..[[ 
{
    lifecycle.current_phase = ]]..S:STRING("TOOLS_NAME|upper")..[[_IN_TOOL_INIT_PHASE;
	clock_gettime(CLOCK_MONOTONIC, &lifecycle.tool_init_start);
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("LC_FINI_FUNC_DECL")..[[ 
{
    free(lifecycle.main_data.argv);
	clock_gettime(CLOCK_MONOTONIC, &lifecycle.tool_fini_stop);
    return ]]..S:STATUS("SUCCESS")..[[;
}

]]..S:STRING("LC_GET_PHASE_FUNC_DECL")..[[ 
{
    return lifecycle.current_phase;
}


]]..S:STRING("LC_GET_LC_FUNC_DECL")..[[ 
{
    return &lifecycle;
}

int i_main(int argc, char **argv, char **envp)
{
    lifecycle.current_phase = ]]..S:STRING("TOOLS_NAME|upper")..[[_IN_MAIN_PHASE;
    lifecycle.main_data.argc = argc;
    lifecycle.main_data.argv = (char**)malloc(argc * sizeof(char*));
    for (int i = 0; i < argc; ++i) {
        lifecycle.main_data.argv[i] = strdup(argv[i]);
    }
	clock_gettime(CLOCK_MONOTONIC, &lifecycle.main_start);
    lifecycle.main_data.retval = main_fn(argc, argv, envp);
	clock_gettime(CLOCK_MONOTONIC, &lifecycle.main_stop);
    lifecycle.main_data.pid = get_pid();
    lifecycle.main_data.tid = get_tid();
    lifecycle.current_phase = ]]..S:STRING("TOOLS_NAME|upper")..[[_IN_DESTRUCTOR_PHASE;
    return lifecycle.main_data.retval;
}

int __libc_start_main(
    int (*main)(int, char **, char **),
    int argc,
    char **argv,
    int (*init)(int, char **, char **),
    void (*fini)(void),
    void (*rtld_fini)(void),
    void *stack_end)
{
    main_fn = main;
    typeof(&__libc_start_main) orig = dlsym(RTLD_NEXT, "__libc_start_main");
    return orig(i_main, argc, argv, init, fini, rtld_fini, stack_end);
}

]]
end

return lifecycle_c, "COMMON"
