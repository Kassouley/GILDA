#ifndef HSA_CALLBACK_H
#define HSA_CALLBACK_H

void hsa_callback_function(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data);
void set_hsa_interceptor_callback(void (*hsa_callback)(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data));

#endif