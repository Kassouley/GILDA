#ifndef INTERCEPTOR_H
#define INTERCEPTOR_H

typedef enum {
    INTERCEPTOR_DOMAIN_HSA,
    INTERCEPTOR_DOMAIN_OMP
} interceptor_domain_t;

void enable_interceptor_domain(interceptor_domain_t domain);
void start_interceptor();

#endif