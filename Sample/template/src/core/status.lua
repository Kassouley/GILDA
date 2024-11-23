local ContentManager = require("ContentManager")
local Content = require("Content")

status_h = setmetatable({}, ContentManager)
status_h.__index = status_h

function status_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME").."/"..S:STRING("STATUS_HDR"),
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, status_h)
    return instance
end

function status_h:generate_content()
    function status_block()
        local status_t = {}
        local status_s = ""
        for status, _ in pairs(S.config.STATUS) do
            if status == "SUCCESS" then
                table.insert(status_t, 1, S:STATUS(status))
            else
                table.insert(status_t, S:STATUS(status))
            end
            local msg_key = status .. "_MSG"
            local message = S.config.STATUS_MSG[msg_key]:trim()
            if message then
                status_s = status_s.."\t\tcase "..S:STATUS(status)..": return \""..message.."\";\n"
            end
        end
        return table.concat(status_t, ",\n\t"), status_s
    end
    local status_t, status_s = status_block()
    local def_header = S:STRING("TOOLS_NAME|upper").."_STATUS_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

typedef enum {
	]]..status_t..[[ 
} ]]..S:STRING("I_STATUS_TYPE")..[[;


static inline const char* get_error_string(]]..S:STRING("I_STATUS_TYPE")..[[ status) {
    switch (status)
    {	
]]..status_s..[[
        default: break;
    }
    return "Unknown error";
}
    
#ifdef ]]..S:STRING("TOOLS_NAME|upper")..[[_DEBUG

#define CHECK_]]..S:STRING("TOOLS_NAME|upper")..[[_CALL(call) { \
    ]]..S:STRING("I_STATUS_TYPE")..[[ ret = call; \
    if (ret != ]]..S:STATUS("SUCCESS")..[[) \
    { \
        fprintf(stderr, "]]..S:STRING("TOOLS_NAME|upper")..[[ Error : %s (code: %d)\n", \
                    get_error_string(ret), ret); \
    } \
};

#else

#define CHECK_]]..S:STRING("TOOLS_NAME|upper")..[[_CALL(call) { call; }; // for debug

#endif // ]]..S:STRING("TOOLS_NAME|upper")..[[_DEBUG

#endif // ]]..def_header
end

return status_h, "COMMON"
