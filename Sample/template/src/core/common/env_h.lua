local ContentManager = require("ContentManager")
local Content = require("Content")

env_h = setmetatable({}, ContentManager)
env_h.__index = env_h

function env_h:new(_, template_path, output_path)
    local attribute = {
        file_name = "env.h",
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, env_h)
    return instance
end

function env_h:generate_content()
    local def_header = "ENV_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 
#include <stdbool.h>
#include <stddef.h>

#define ENV_PLUGIN_PATH "]]..S:STRING("TOOLS_NAME|upper")..[[_PLUGIN_PATH"
#define ENV_OUTPUT_FILE "]]..S:STRING("TOOLS_NAME|upper")..[[_OUTPUT_FILE"
#define ENV_BUFFER_SIZE "]]..S:STRING("TOOLS_NAME|upper")..[[_BUFFER_SIZE"

#define DEFAULT_OUTPUT_FILE "report.json"
#define DEFAULT_BUFFER_SIZE 0x200000

const char* get_function_filter(const char* env_function_filter);
bool is_set_domain(const char *domain);
void* get_plugin_lib();
const char* get_output_file();
size_t get_buffer_size();

#endif // ]]..def_header
end

return env_h, "COMMON"
