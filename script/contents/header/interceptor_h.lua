local interceptor_hdr = {}

function interceptor_hdr.content(subcontents)
    return string.format([[
#ifndef %s_H
#define %s_H

%s

typedef enum {
%s
} %s_domain_t;

void %s_enable_domain(%s_domain_t domain);
void %s_disable_domain(%s_domain_t domain);
void %s_init();
void %s_fini();

#endif
]],
        S._TOOLS_NAME_UPPER,
        S._TOOLS_NAME_UPPER,
        subcontents.include_block,
        subcontents.enum_block,
        S._TOOLS_NAME,
        S._TOOLS_NAME, S._TOOLS_NAME,
        S._TOOLS_NAME, S._TOOLS_NAME,
        S._TOOLS_NAME,
        S._TOOLS_NAME
    )
end

function interceptor_hdr.include_line()
    return "#include \""..S:_CB_HEAD().."\"\n"..
           "#include \""..S:_ITM_HEAD().."\"\n"..
           "#include \""..S:_IF_HEAD().."\"\n"
end

function interceptor_hdr.enum_line()
    return "\t"..S:_DOMAIN_ID()
end


return interceptor_hdr
