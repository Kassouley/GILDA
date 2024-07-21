local interceptor_hdr = {}

function interceptor_hdr.content(enum_block, include_block)
    return string.format([[
#ifndef %s_H
#define %s_H

%s

typedef enum {
%s
} %s_domain_t;

void enable_%s_domain(%s_domain_t domain);
void start_%s();
void end_%s();

#endif

]],
        S._TOOLS_NAME_UPPER,
        S._TOOLS_NAME_UPPER,
        include_block,
        enum_block,
        S._TOOLS_NAME,
        S._TOOLS_NAME,
        S._TOOLS_NAME,
        S._TOOLS_NAME,
        S._TOOLS_NAME
    )
end

function interceptor_hdr.include_line()
    return "#include \""..S:_CB_HEAD().."\"\n"..
           "#include \""..S:_ITM_HEAD().."\""
end

function interceptor_hdr.enum_line()
    return "\t"..S:_DOMAIN_ID()
end


return interceptor_hdr
