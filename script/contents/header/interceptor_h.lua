local interceptor_hdr = {}

function interceptor_hdr.content(subcontent)
    return string.format([[
#ifndef %s_H
#define %s_H

%s

#include "%s"

typedef enum {
%s,
    NB_DOMAIN
} %s_domain_t;

static inline const char* get_domain_name(%s_domain_t domain) {
	switch(domain) {
%s
		default : return "Unknown domain";
	}
	return "Unknown domain";
}

void %s_enable_domain(%s_domain_t domain);
void %s_disable_domain(%s_domain_t domain);
void %s_init();
void %s_fini();

#endif // %s_H
]],
        S._TOOLS_NAME_UPPER,
        S._TOOLS_NAME_UPPER,
        subcontent.include_block,
        S:_ENV_HEAD(),
        subcontent.enum_block,
        S._TOOLS_NAME,
        S._TOOLS_NAME,
        subcontent.domain_name_block,
        S._TOOLS_NAME, S._TOOLS_NAME,
        S._TOOLS_NAME, S._TOOLS_NAME,
        S._TOOLS_NAME,
        S._TOOLS_NAME,
        S._TOOLS_NAME_UPPER
    )
end

function interceptor_hdr.domain_name_block()
    return "\t\tcase "..S:_DOMAIN_ID()..": return \""..S:_DOMAIN_ID().."\";"
end

function interceptor_hdr.include_block()
    return "#include \""..S:_CB_HEAD().."\"\n"..
           "#include \""..S:_ATM_HEAD().."\"\n"..
           "#include \""..S:_IF_HEAD().."\"\n"
end

function interceptor_hdr.enum_block()
    return "\t"..S:_DOMAIN_ID()
end


return interceptor_hdr
