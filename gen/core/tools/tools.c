#include <stdio.h>
#include <stdlib.h>
#include "interceptor.h"
#include "hsa_callback.h"
#include "hsa_intercepted_functions.h"
#include "hip_callback.h"
#include "hip_intercepted_functions.h"

void sample(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data) 
{
    if (is_enter)
        printf("%s\n", get_hsa_funame_by_id(func_id));
}

void sample2(bool is_enter, hip_api_id_t func_id, hip_api_data_t data) 
{
    if (is_enter)
        printf("%s\n", get_hip_funame_by_id(func_id));
}

__attribute__((constructor)) void init(void) {
    start_interceptor();
    set_hsa_interceptor_callback(sample);
    set_hip_interceptor_callback(sample2);
    enable_interceptor_domain(INTERCEPTOR_DOMAIN_HSA);
    enable_interceptor_domain(INTERCEPTOR_DOMAIN_HIP);
}

__attribute__((destructor)) void fini(void) {
    end_interceptor();
}