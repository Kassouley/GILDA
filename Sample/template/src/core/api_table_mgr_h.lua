local ContentManager = require("ContentManager")
local Content = require("Content")

api_table_mgr_h = setmetatable({}, ContentManager)
api_table_mgr_h.__index = api_table_mgr_h

function api_table_mgr_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("ATM_HDR"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, api_table_mgr_h)
    return instance
end

function api_table_mgr_h:generate_content()
    local def_header = "API_TABLE_MANAGER_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

#include <stddef.h>
#include <stdbool.h>
#include "]]..S:STRING("INTERCEPTOR_HDR")..[["

// Structure representing an API table entry
typedef struct api_table_s {
    ]]..S:STRING("I_DOMAIN_T")..[[ domain;
    void* handler;
    void** api_fn;
    void** api_ptr;
    ]]..S:STRING("I_API_ID_T")..[[ size;
    bool is_populate;
} ]]..S:STRING("ATM_API_TABLE_T")..[[;

// Function declarations

/**
 * Initializes the API table for a given domain.
 * @param domain The domain for which to initialize the API table.
 * @param api_table A pointer to the API table structure to initialize.
 * @param size The number of entries in the API table.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ indicating success or failure.
 */
]]..S:STRING("ATM_INIT_FUNC_DECL")..[[;

/**
 * Populate the API table.
 * @param api_table A pointer to the API table structure to initialize.
 * @param lib_path The library to dlopen.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ indicating success or failure.
 */
]]..S:STRING("ATM_POPU_FUNC_DECL")..[[;

/**
 * Cleans up resources allocated for the API table.
 * @param api_table A pointer to the API table structure to clean up.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ indicating success or failure.
 */
]]..S:STRING("ATM_FINI_FUNC_DECL")..[[;

/**
 * Enables the API table by mapping functions according to the provided environment variable.
 * @param api_table A pointer to the API table structure to enable.
 * @param env_var_name The name of the environment variable containing the function filter.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ indicating success or failure.
 */
]]..S:STRING("ATM_ENABLE_FUNC_DECL")..[[;

/**
 * Disables the API table by restoring the original function pointers.
 * @param api_table A pointer to the API table structure to disable.
 * @return ]]..S:STRING("I_STATUS_TYPE")..[[ indicating success or failure.
 */
]]..S:STRING("ATM_DISABLE_FUNC_DECL")..[[;

/**
 * Fallback function that handles errors when an API function cannot be loaded.
 */
void fallback(void);

#endif // ]]..def_header
end

return api_table_mgr_h, "COMMON"
