#include <stdio.h>
#include "interceptor.h"
#include "hsa_interceptor/hsa_intercept_table_mgr.h"

void enable_interceptor_domain(interceptor_domain_t domain)
{
    switch (domain)
    {
        case INTERCEPTOR_DOMAIN_HSA:
            load_hsa_itcp_table();
            break;

        // case INTERCEPTOR_DOMAIN_OMP:
        //     load_omp_itcp_table();
        //     break;
        
        default:
            break;
    }
}

void start_interceptor()
{
    printf("Profiler initialized.\n");
}