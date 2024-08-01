local interceptor_hdr = {}

function interceptor_hdr.content(subcontent)
    local def_header = S._TOOLS_NAME_UPPER.."_H"
    return S._WARNING_MSG..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..subcontent.include_block..[[ 
#include "]]..S._ENV_HEAD..[["
#include "]]..S._CID_HEAD..[["

typedef enum {
]]..subcontent.enum_block..[[,
    ]]..S._TOOLS_NAME_UPPER..[[_NB_DOMAIN
} ]]..S._TOOLS_NAME..[[_domain_t;

static inline const char* get_domain_name(]]..S._TOOLS_NAME..[[_domain_t domain) {
	switch(domain) {
]]..subcontent.domain_name_block..[[ 
		default : return "Unknown domain";
	}
	return "Unknown domain";
}

void ]]..S._TOOLS_NAME..[[_enable_domain(]]..S._TOOLS_NAME..[[_domain_t domain);
void ]]..S._TOOLS_NAME..[[_disable_domain(]]..S._TOOLS_NAME..[[_domain_t domain);
void ]]..S._TOOLS_NAME..[[_init();
void ]]..S._TOOLS_NAME..[[_fini();

#endif // ]]..def_header
end

function interceptor_hdr.domain_name_block()
    return "\t\tcase "..S._DOMAIN_ID..": return \""..S._DOMAIN_ID.."\";"
end

function interceptor_hdr.include_block()
    return "#include \""..S._CB_HEAD.."\"\n"..
           "#include \""..S._ATM_HEAD.."\"\n"..
           "#include \""..S._IF_HEAD.."\"\n"
end

function interceptor_hdr.enum_block()
    return "\t"..S._DOMAIN_ID
end


return interceptor_hdr
