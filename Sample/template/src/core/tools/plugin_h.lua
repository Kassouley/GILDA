local ContentManager = require("ContentManager")
local Content = require("Content")

plugin_h = setmetatable({}, ContentManager)
plugin_h.__index = plugin_h

function plugin_h:new(_, template_path, output_path)
    local attribute = {
        file_name = "plugin.h",
        is_sample = true,
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, plugin_h)
    return instance
end

function plugin_h:generate_content()
    local def_header = "RATELPROF_PLUGIN_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include <]]..S:STRING("INTERCEPTOR_HDR")..[[>

// Forward declaration of the opaque structure
typedef struct ]]..S:STRING("TOOLS_NAME")..[[_plugin_s ]]..S:STRING("PLG_STRUCT")..[[;

// Function declarations

/**
 * @brief Initializes the plugin.
 * 
 * @param plugin Pointer to the plugin instance.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ The status of the initialization:
 *         - ]]..S:STATUS("PLUGIN_INIT")..[[ if the plugin is already initialized.
 *         - ]]..S:STATUS("MALLOC_FAILED")..[[ if memory allocation failed.
 *         - ]]..S:STATUS("SUCCESS")..[[ if initialization was successful.
 */
]]..S:STRING("PLG_INIT_FUNC_DECL")..[[;

/**
 * @brief Finalizes the plugin.
 * 
 * @param plugin Pointer to the plugin instance.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ The status of the finalization:
 *         - ]]..S:STATUS("PLUGIN_IS_NULL")..[[ if the plugin is NULL.
 *         - ]]..S:STATUS("SUCCESS")..[[ if finalization was successful.
 */
]]..S:STRING("PLG_FINI_FUNC_DECL")..[[;

/**
 * @brief Retrieves the API callback handler based on the domain.
 * 
 * @param plugin Pointer to the plugin instance.
 * @param domain The domain for which the callback handler is requested.
 * @param callback_handler Pointer to where the retrieved callback handler will be stored.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ The status of the operation:
 *         - ]]..S:STATUS("UNKNOWN_DOMAIN")..[[ if the domain is not recognized.
 *         - ]]..S:STATUS("SUCCESS")..[[ if the callback handler was successfully retrieved.
 */
]]..S:STRING("PLG_GET_CB_FUNC_DECL")..[[;

#endif // ]]..def_header
end

return plugin_h, "COMMON"
