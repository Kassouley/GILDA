#include <stdio.h>
#include <stdlib.h>

#include "hsa_intercepted_functions.h"
#include "hsa_callback.h"

void (*stored_hsa_callback)(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data);

void set_hsa_interceptor_callback(void (*hsa_callback)(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data)) {
    stored_hsa_callback = hsa_callback;
}

void hsa_callback_function(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data) {
    if (stored_hsa_callback) {
        stored_hsa_callback(is_enter, func_id, data);
    } else {
        fprintf(stderr, "No hsa callback function has been set.\n");
    }
}
