#include <stdio.h>
#include "interceptor.h"
#include "hsa_interceptor/hsa_intercept_table_mgr.h"
#include "hip_interceptor/hip_intercept_table_mgr.h"
#include "logger.h"

void enable_interceptor_domain(interceptor_domain_t domain)
{
    switch (domain) {
        case INTERCEPTOR_DOMAIN_HSA: load_hsa_itcp_table(); break;
        case INTERCEPTOR_DOMAIN_HIP: load_hip_itcp_table(); break;
        default: break;
    }
}

void start_interceptor()
{
    INIT_LOGGER();
    printf("Profiler initialized.\n");
}

void end_interceptor()
{
    CLOSE_LOGGER();
    printf("Profiler finalized.\n");
}