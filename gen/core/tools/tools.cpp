#include <stdio.h>
#include <stdlib.h>
#include "interceptor.h"
#include "callback.h"

void sample(int is_enter, const char* func) 
{
    if (is_enter)
        printf("%s\n", func);
}

__attribute__((constructor)) void init(void) {
    printf("Profiler INIT.\n");
    start_interceptor();
    set_interceptor_callback(sample);
    enable_interceptor_domain(INTERCEPTOR_DOMAIN_HSA);
}

__attribute__((destructor)) void fini(void) {
    printf("Profiler finalized.\n");
}