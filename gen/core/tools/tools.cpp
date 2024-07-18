#include <stdio.h>
#include <stdlib.h>
#include "interceptor.h"
#include "hsa_callback.h"
#include "hsa_intercepted_functions.h"

void sample(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data) 
{
    if (is_enter)
        printf("%s\n", get_hsa_funame_by_id(func_id));
}

__attribute__((constructor)) void init(void) {
    printf("Profiler INIT.\n");
    start_interceptor();
    set_hsa_interceptor_callback(sample);
    enable_interceptor_domain(INTERCEPTOR_DOMAIN_HSA);
}

__attribute__((destructor)) void fini(void) {
    printf("Profiler finalized.\n");
}