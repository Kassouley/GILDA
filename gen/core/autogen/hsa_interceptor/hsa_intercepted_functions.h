#ifndef HSA_INTERCEPTED_FUNCTIONS_H
#define HSA_INTERCEPTED_FUNCTIONS_H

#include "hsa.h"
#include "hsa_ext_amd.h"

// HSA API ID enum
enum hsa_api_id_t {
	HSA_API_ID_hsa_amd_coherency_get_type = 1,
	HSA_API_ID_hsa_amd_coherency_set_type = 2,
	HSA_API_ID_hsa_amd_profiling_set_profiler_enabled = 3,
	HSA_API_ID_hsa_amd_profiling_async_copy_enable = 4,
	HSA_API_ID_hsa_amd_profiling_get_dispatch_time = 5,
	HSA_API_ID_hsa_amd_profiling_get_async_copy_time = 6,
	HSA_API_ID_hsa_amd_profiling_convert_tick_to_system_domain = 7,
	HSA_API_ID_hsa_amd_signal_create = 8,
	HSA_API_ID_hsa_amd_signal_value_pointer = 9,
	HSA_API_ID_hsa_amd_signal_async_handler = 10,
	HSA_API_ID_hsa_amd_async_function = 11,
	HSA_API_ID_hsa_amd_signal_wait_any = 12,
	HSA_API_ID_hsa_amd_image_get_info_max_dim = 13,
	HSA_API_ID_hsa_amd_queue_cu_set_mask = 14,
	HSA_API_ID_hsa_amd_queue_cu_get_mask = 15,
	HSA_API_ID_hsa_amd_memory_pool_get_info = 16,
	HSA_API_ID_hsa_amd_agent_iterate_memory_pools = 17,
	HSA_API_ID_hsa_amd_memory_pool_allocate = 18,
	HSA_API_ID_hsa_amd_memory_pool_free = 19,
	HSA_API_ID_hsa_amd_memory_async_copy = 20,
	HSA_API_ID_hsa_amd_memory_async_copy_on_engine = 21,
	HSA_API_ID_hsa_amd_memory_copy_engine_status = 22,
	HSA_API_ID_hsa_amd_memory_async_copy_rect = 23,
	HSA_API_ID_hsa_amd_agent_memory_pool_get_info = 24,
	HSA_API_ID_hsa_amd_agents_allow_access = 25,
	HSA_API_ID_hsa_amd_memory_pool_can_migrate = 26,
	HSA_API_ID_hsa_amd_memory_migrate = 27,
	HSA_API_ID_hsa_amd_memory_lock = 28,
	HSA_API_ID_hsa_amd_memory_lock_to_pool = 29,
	HSA_API_ID_hsa_amd_memory_unlock = 30,
	HSA_API_ID_hsa_amd_memory_fill = 31,
	HSA_API_ID_hsa_amd_interop_map_buffer = 32,
	HSA_API_ID_hsa_amd_interop_unmap_buffer = 33,
	HSA_API_ID_hsa_amd_image_create = 34,
	HSA_API_ID_hsa_amd_pointer_info = 35,
	HSA_API_ID_hsa_amd_pointer_info_set_userdata = 36,
	HSA_API_ID_hsa_amd_ipc_memory_create = 37,
	HSA_API_ID_hsa_amd_ipc_memory_attach = 38,
	HSA_API_ID_hsa_amd_ipc_memory_detach = 39,
	HSA_API_ID_hsa_amd_ipc_signal_create = 40,
	HSA_API_ID_hsa_amd_ipc_signal_attach = 41,
	HSA_API_ID_hsa_amd_register_system_event_handler = 42,
	HSA_API_ID_hsa_amd_queue_set_priority = 43,
	HSA_API_ID_hsa_amd_register_deallocation_callback = 44,
	HSA_API_ID_hsa_amd_deregister_deallocation_callback = 45,
	HSA_API_ID_hsa_amd_svm_attributes_set = 46,
	HSA_API_ID_hsa_amd_svm_attributes_get = 47,
	HSA_API_ID_hsa_amd_svm_prefetch_async = 48,
	HSA_API_ID_hsa_amd_spm_acquire = 49,
	HSA_API_ID_hsa_amd_spm_release = 50,
	HSA_API_ID_hsa_amd_spm_set_dest_buffer = 51,
	HSA_API_ID_hsa_amd_portable_export_dmabuf = 52,
	HSA_API_ID_hsa_amd_portable_close_dmabuf = 53,
	HSA_API_ID_hsa_amd_vmem_address_reserve = 54,
	HSA_API_ID_hsa_amd_vmem_address_free = 55,
	HSA_API_ID_hsa_amd_vmem_handle_create = 56,
	HSA_API_ID_hsa_amd_vmem_handle_release = 57,
	HSA_API_ID_hsa_amd_vmem_map = 58,
	HSA_API_ID_hsa_amd_vmem_unmap = 59,
	HSA_API_ID_hsa_amd_vmem_set_access = 60,
	HSA_API_ID_hsa_amd_vmem_get_access = 61,
	HSA_API_ID_hsa_amd_vmem_export_shareable_handle = 62,
	HSA_API_ID_hsa_amd_vmem_import_shareable_handle = 63,
	HSA_API_ID_hsa_amd_vmem_retain_alloc_handle = 64,
	HSA_API_ID_hsa_amd_vmem_get_alloc_properties_from_handle = 65,
	HSA_API_ID_hsa_amd_agent_set_async_scratch_limit = 66,
	HSA_API_ID_hsa_status_string = 67,
	HSA_API_ID_hsa_init = 68,
	HSA_API_ID_hsa_shut_down = 69,
	HSA_API_ID_hsa_system_get_info = 70,
	HSA_API_ID_hsa_extension_get_name = 71,
	HSA_API_ID_hsa_system_extension_supported = 72,
	HSA_API_ID_hsa_system_major_extension_supported = 73,
	HSA_API_ID_hsa_system_get_extension_table = 74,
	HSA_API_ID_hsa_system_get_major_extension_table = 75,
	HSA_API_ID_hsa_agent_get_info = 76,
	HSA_API_ID_hsa_iterate_agents = 77,
	HSA_API_ID_hsa_agent_get_exception_policies = 78,
	HSA_API_ID_hsa_cache_get_info = 79,
	HSA_API_ID_hsa_agent_iterate_caches = 80,
	HSA_API_ID_hsa_agent_extension_supported = 81,
	HSA_API_ID_hsa_agent_major_extension_supported = 82,
	HSA_API_ID_hsa_signal_create = 83,
	HSA_API_ID_hsa_signal_destroy = 84,
	HSA_API_ID_hsa_signal_load_scacquire = 85,
	HSA_API_ID_hsa_signal_load_relaxed = 86,
	HSA_API_ID_hsa_signal_load_acquire = 87,
	HSA_API_ID_hsa_signal_store_relaxed = 88,
	HSA_API_ID_hsa_signal_store_screlease = 89,
	HSA_API_ID_hsa_signal_store_release = 90,
	HSA_API_ID_hsa_signal_silent_store_relaxed = 91,
	HSA_API_ID_hsa_signal_silent_store_screlease = 92,
	HSA_API_ID_hsa_signal_exchange_scacq_screl = 93,
	HSA_API_ID_hsa_signal_exchange_acq_rel = 94,
	HSA_API_ID_hsa_signal_exchange_scacquire = 95,
	HSA_API_ID_hsa_signal_exchange_acquire = 96,
	HSA_API_ID_hsa_signal_exchange_relaxed = 97,
	HSA_API_ID_hsa_signal_exchange_screlease = 98,
	HSA_API_ID_hsa_signal_exchange_release = 99,
	HSA_API_ID_hsa_signal_cas_scacq_screl = 100,
	HSA_API_ID_hsa_signal_cas_acq_rel = 101,
	HSA_API_ID_hsa_signal_cas_scacquire = 102,
	HSA_API_ID_hsa_signal_cas_acquire = 103,
	HSA_API_ID_hsa_signal_cas_relaxed = 104,
	HSA_API_ID_hsa_signal_cas_screlease = 105,
	HSA_API_ID_hsa_signal_cas_release = 106,
	HSA_API_ID_hsa_signal_add_scacq_screl = 107,
	HSA_API_ID_hsa_signal_add_acq_rel = 108,
	HSA_API_ID_hsa_signal_add_scacquire = 109,
	HSA_API_ID_hsa_signal_add_acquire = 110,
	HSA_API_ID_hsa_signal_add_relaxed = 111,
	HSA_API_ID_hsa_signal_add_screlease = 112,
	HSA_API_ID_hsa_signal_add_release = 113,
	HSA_API_ID_hsa_signal_subtract_scacq_screl = 114,
	HSA_API_ID_hsa_signal_subtract_acq_rel = 115,
	HSA_API_ID_hsa_signal_subtract_scacquire = 116,
	HSA_API_ID_hsa_signal_subtract_acquire = 117,
	HSA_API_ID_hsa_signal_subtract_relaxed = 118,
	HSA_API_ID_hsa_signal_subtract_screlease = 119,
	HSA_API_ID_hsa_signal_subtract_release = 120,
	HSA_API_ID_hsa_signal_and_scacq_screl = 121,
	HSA_API_ID_hsa_signal_and_acq_rel = 122,
	HSA_API_ID_hsa_signal_and_scacquire = 123,
	HSA_API_ID_hsa_signal_and_acquire = 124,
	HSA_API_ID_hsa_signal_and_relaxed = 125,
	HSA_API_ID_hsa_signal_and_screlease = 126,
	HSA_API_ID_hsa_signal_and_release = 127,
	HSA_API_ID_hsa_signal_or_scacq_screl = 128,
	HSA_API_ID_hsa_signal_or_acq_rel = 129,
	HSA_API_ID_hsa_signal_or_scacquire = 130,
	HSA_API_ID_hsa_signal_or_acquire = 131,
	HSA_API_ID_hsa_signal_or_relaxed = 132,
	HSA_API_ID_hsa_signal_or_screlease = 133,
	HSA_API_ID_hsa_signal_or_release = 134,
	HSA_API_ID_hsa_signal_xor_scacq_screl = 135,
	HSA_API_ID_hsa_signal_xor_acq_rel = 136,
	HSA_API_ID_hsa_signal_xor_scacquire = 137,
	HSA_API_ID_hsa_signal_xor_acquire = 138,
	HSA_API_ID_hsa_signal_xor_relaxed = 139,
	HSA_API_ID_hsa_signal_xor_screlease = 140,
	HSA_API_ID_hsa_signal_xor_release = 141,
	HSA_API_ID_hsa_signal_wait_scacquire = 142,
	HSA_API_ID_hsa_signal_wait_relaxed = 143,
	HSA_API_ID_hsa_signal_wait_acquire = 144,
	HSA_API_ID_hsa_signal_group_create = 145,
	HSA_API_ID_hsa_signal_group_destroy = 146,
	HSA_API_ID_hsa_signal_group_wait_any_scacquire = 147,
	HSA_API_ID_hsa_signal_group_wait_any_relaxed = 148,
	HSA_API_ID_hsa_queue_create = 149,
	HSA_API_ID_hsa_soft_queue_create = 150,
	HSA_API_ID_hsa_queue_destroy = 151,
	HSA_API_ID_hsa_queue_inactivate = 152,
	HSA_API_ID_hsa_queue_load_read_index_acquire = 153,
	HSA_API_ID_hsa_queue_load_read_index_scacquire = 154,
	HSA_API_ID_hsa_queue_load_read_index_relaxed = 155,
	HSA_API_ID_hsa_queue_load_write_index_acquire = 156,
	HSA_API_ID_hsa_queue_load_write_index_scacquire = 157,
	HSA_API_ID_hsa_queue_load_write_index_relaxed = 158,
	HSA_API_ID_hsa_queue_store_write_index_relaxed = 159,
	HSA_API_ID_hsa_queue_store_write_index_release = 160,
	HSA_API_ID_hsa_queue_store_write_index_screlease = 161,
	HSA_API_ID_hsa_queue_cas_write_index_acq_rel = 162,
	HSA_API_ID_hsa_queue_cas_write_index_scacq_screl = 163,
	HSA_API_ID_hsa_queue_cas_write_index_acquire = 164,
	HSA_API_ID_hsa_queue_cas_write_index_scacquire = 165,
	HSA_API_ID_hsa_queue_cas_write_index_relaxed = 166,
	HSA_API_ID_hsa_queue_cas_write_index_release = 167,
	HSA_API_ID_hsa_queue_cas_write_index_screlease = 168,
	HSA_API_ID_hsa_queue_add_write_index_acq_rel = 169,
	HSA_API_ID_hsa_queue_add_write_index_scacq_screl = 170,
	HSA_API_ID_hsa_queue_add_write_index_acquire = 171,
	HSA_API_ID_hsa_queue_add_write_index_scacquire = 172,
	HSA_API_ID_hsa_queue_add_write_index_relaxed = 173,
	HSA_API_ID_hsa_queue_add_write_index_release = 174,
	HSA_API_ID_hsa_queue_add_write_index_screlease = 175,
	HSA_API_ID_hsa_queue_store_read_index_relaxed = 176,
	HSA_API_ID_hsa_queue_store_read_index_release = 177,
	HSA_API_ID_hsa_queue_store_read_index_screlease = 178,
	HSA_API_ID_hsa_region_get_info = 179,
	HSA_API_ID_hsa_agent_iterate_regions = 180,
	HSA_API_ID_hsa_memory_allocate = 181,
	HSA_API_ID_hsa_memory_free = 182,
	HSA_API_ID_hsa_memory_copy = 183,
	HSA_API_ID_hsa_memory_assign_agent = 184,
	HSA_API_ID_hsa_memory_register = 185,
	HSA_API_ID_hsa_memory_deregister = 186,
	HSA_API_ID_hsa_isa_from_name = 187,
	HSA_API_ID_hsa_agent_iterate_isas = 188,
	HSA_API_ID_hsa_isa_get_info = 189,
	HSA_API_ID_hsa_isa_get_info_alt = 190,
	HSA_API_ID_hsa_isa_get_exception_policies = 191,
	HSA_API_ID_hsa_isa_get_round_method = 192,
	HSA_API_ID_hsa_wavefront_get_info = 193,
	HSA_API_ID_hsa_isa_iterate_wavefronts = 194,
	HSA_API_ID_hsa_isa_compatible = 195,
	HSA_API_ID_hsa_code_object_reader_create_from_file = 196,
	HSA_API_ID_hsa_code_object_reader_create_from_memory = 197,
	HSA_API_ID_hsa_code_object_reader_destroy = 198,
	HSA_API_ID_hsa_executable_create = 199,
	HSA_API_ID_hsa_executable_create_alt = 200,
	HSA_API_ID_hsa_executable_destroy = 201,
	HSA_API_ID_hsa_executable_load_program_code_object = 202,
	HSA_API_ID_hsa_executable_load_agent_code_object = 203,
	HSA_API_ID_hsa_executable_freeze = 204,
	HSA_API_ID_hsa_executable_get_info = 205,
	HSA_API_ID_hsa_executable_global_variable_define = 206,
	HSA_API_ID_hsa_executable_agent_global_variable_define = 207,
	HSA_API_ID_hsa_executable_readonly_variable_define = 208,
	HSA_API_ID_hsa_executable_validate = 209,
	HSA_API_ID_hsa_executable_validate_alt = 210,
	HSA_API_ID_hsa_executable_get_symbol = 211,
	HSA_API_ID_hsa_executable_get_symbol_by_name = 212,
	HSA_API_ID_hsa_executable_symbol_get_info = 213,
	HSA_API_ID_hsa_executable_iterate_symbols = 214,
	HSA_API_ID_hsa_executable_iterate_agent_symbols = 215,
	HSA_API_ID_hsa_executable_iterate_program_symbols = 216,
	HSA_API_ID_hsa_code_object_serialize = 217,
	HSA_API_ID_hsa_code_object_deserialize = 218,
	HSA_API_ID_hsa_code_object_destroy = 219,
	HSA_API_ID_hsa_code_object_get_info = 220,
	HSA_API_ID_hsa_executable_load_code_object = 221,
	HSA_API_ID_hsa_code_object_get_symbol = 222,
	HSA_API_ID_hsa_code_object_get_symbol_from_name = 223,
	HSA_API_ID_hsa_code_symbol_get_info = 224,
	HSA_API_ID_hsa_code_object_iterate_symbols = 225,
};

// Return HSA API function name for a given ID
const char* get_hsa_funame_by_id(hsa_api_id_t id) {
	switch(id) {
		case HSA_API_ID_hsa_amd_coherency_get_type : return "hsa_amd_coherency_get_type";
		case HSA_API_ID_hsa_amd_coherency_set_type : return "hsa_amd_coherency_set_type";
		case HSA_API_ID_hsa_amd_profiling_set_profiler_enabled : return "hsa_amd_profiling_set_profiler_enabled";
		case HSA_API_ID_hsa_amd_profiling_async_copy_enable : return "hsa_amd_profiling_async_copy_enable";
		case HSA_API_ID_hsa_amd_profiling_get_dispatch_time : return "hsa_amd_profiling_get_dispatch_time";
		case HSA_API_ID_hsa_amd_profiling_get_async_copy_time : return "hsa_amd_profiling_get_async_copy_time";
		case HSA_API_ID_hsa_amd_profiling_convert_tick_to_system_domain : return "hsa_amd_profiling_convert_tick_to_system_domain";
		case HSA_API_ID_hsa_amd_signal_create : return "hsa_amd_signal_create";
		case HSA_API_ID_hsa_amd_signal_value_pointer : return "hsa_amd_signal_value_pointer";
		case HSA_API_ID_hsa_amd_signal_async_handler : return "hsa_amd_signal_async_handler";
		case HSA_API_ID_hsa_amd_async_function : return "hsa_amd_async_function";
		case HSA_API_ID_hsa_amd_signal_wait_any : return "hsa_amd_signal_wait_any";
		case HSA_API_ID_hsa_amd_image_get_info_max_dim : return "hsa_amd_image_get_info_max_dim";
		case HSA_API_ID_hsa_amd_queue_cu_set_mask : return "hsa_amd_queue_cu_set_mask";
		case HSA_API_ID_hsa_amd_queue_cu_get_mask : return "hsa_amd_queue_cu_get_mask";
		case HSA_API_ID_hsa_amd_memory_pool_get_info : return "hsa_amd_memory_pool_get_info";
		case HSA_API_ID_hsa_amd_agent_iterate_memory_pools : return "hsa_amd_agent_iterate_memory_pools";
		case HSA_API_ID_hsa_amd_memory_pool_allocate : return "hsa_amd_memory_pool_allocate";
		case HSA_API_ID_hsa_amd_memory_pool_free : return "hsa_amd_memory_pool_free";
		case HSA_API_ID_hsa_amd_memory_async_copy : return "hsa_amd_memory_async_copy";
		case HSA_API_ID_hsa_amd_memory_async_copy_on_engine : return "hsa_amd_memory_async_copy_on_engine";
		case HSA_API_ID_hsa_amd_memory_copy_engine_status : return "hsa_amd_memory_copy_engine_status";
		case HSA_API_ID_hsa_amd_memory_async_copy_rect : return "hsa_amd_memory_async_copy_rect";
		case HSA_API_ID_hsa_amd_agent_memory_pool_get_info : return "hsa_amd_agent_memory_pool_get_info";
		case HSA_API_ID_hsa_amd_agents_allow_access : return "hsa_amd_agents_allow_access";
		case HSA_API_ID_hsa_amd_memory_pool_can_migrate : return "hsa_amd_memory_pool_can_migrate";
		case HSA_API_ID_hsa_amd_memory_migrate : return "hsa_amd_memory_migrate";
		case HSA_API_ID_hsa_amd_memory_lock : return "hsa_amd_memory_lock";
		case HSA_API_ID_hsa_amd_memory_lock_to_pool : return "hsa_amd_memory_lock_to_pool";
		case HSA_API_ID_hsa_amd_memory_unlock : return "hsa_amd_memory_unlock";
		case HSA_API_ID_hsa_amd_memory_fill : return "hsa_amd_memory_fill";
		case HSA_API_ID_hsa_amd_interop_map_buffer : return "hsa_amd_interop_map_buffer";
		case HSA_API_ID_hsa_amd_interop_unmap_buffer : return "hsa_amd_interop_unmap_buffer";
		case HSA_API_ID_hsa_amd_image_create : return "hsa_amd_image_create";
		case HSA_API_ID_hsa_amd_pointer_info : return "hsa_amd_pointer_info";
		case HSA_API_ID_hsa_amd_pointer_info_set_userdata : return "hsa_amd_pointer_info_set_userdata";
		case HSA_API_ID_hsa_amd_ipc_memory_create : return "hsa_amd_ipc_memory_create";
		case HSA_API_ID_hsa_amd_ipc_memory_attach : return "hsa_amd_ipc_memory_attach";
		case HSA_API_ID_hsa_amd_ipc_memory_detach : return "hsa_amd_ipc_memory_detach";
		case HSA_API_ID_hsa_amd_ipc_signal_create : return "hsa_amd_ipc_signal_create";
		case HSA_API_ID_hsa_amd_ipc_signal_attach : return "hsa_amd_ipc_signal_attach";
		case HSA_API_ID_hsa_amd_register_system_event_handler : return "hsa_amd_register_system_event_handler";
		case HSA_API_ID_hsa_amd_queue_set_priority : return "hsa_amd_queue_set_priority";
		case HSA_API_ID_hsa_amd_register_deallocation_callback : return "hsa_amd_register_deallocation_callback";
		case HSA_API_ID_hsa_amd_deregister_deallocation_callback : return "hsa_amd_deregister_deallocation_callback";
		case HSA_API_ID_hsa_amd_svm_attributes_set : return "hsa_amd_svm_attributes_set";
		case HSA_API_ID_hsa_amd_svm_attributes_get : return "hsa_amd_svm_attributes_get";
		case HSA_API_ID_hsa_amd_svm_prefetch_async : return "hsa_amd_svm_prefetch_async";
		case HSA_API_ID_hsa_amd_spm_acquire : return "hsa_amd_spm_acquire";
		case HSA_API_ID_hsa_amd_spm_release : return "hsa_amd_spm_release";
		case HSA_API_ID_hsa_amd_spm_set_dest_buffer : return "hsa_amd_spm_set_dest_buffer";
		case HSA_API_ID_hsa_amd_portable_export_dmabuf : return "hsa_amd_portable_export_dmabuf";
		case HSA_API_ID_hsa_amd_portable_close_dmabuf : return "hsa_amd_portable_close_dmabuf";
		case HSA_API_ID_hsa_amd_vmem_address_reserve : return "hsa_amd_vmem_address_reserve";
		case HSA_API_ID_hsa_amd_vmem_address_free : return "hsa_amd_vmem_address_free";
		case HSA_API_ID_hsa_amd_vmem_handle_create : return "hsa_amd_vmem_handle_create";
		case HSA_API_ID_hsa_amd_vmem_handle_release : return "hsa_amd_vmem_handle_release";
		case HSA_API_ID_hsa_amd_vmem_map : return "hsa_amd_vmem_map";
		case HSA_API_ID_hsa_amd_vmem_unmap : return "hsa_amd_vmem_unmap";
		case HSA_API_ID_hsa_amd_vmem_set_access : return "hsa_amd_vmem_set_access";
		case HSA_API_ID_hsa_amd_vmem_get_access : return "hsa_amd_vmem_get_access";
		case HSA_API_ID_hsa_amd_vmem_export_shareable_handle : return "hsa_amd_vmem_export_shareable_handle";
		case HSA_API_ID_hsa_amd_vmem_import_shareable_handle : return "hsa_amd_vmem_import_shareable_handle";
		case HSA_API_ID_hsa_amd_vmem_retain_alloc_handle : return "hsa_amd_vmem_retain_alloc_handle";
		case HSA_API_ID_hsa_amd_vmem_get_alloc_properties_from_handle : return "hsa_amd_vmem_get_alloc_properties_from_handle";
		case HSA_API_ID_hsa_amd_agent_set_async_scratch_limit : return "hsa_amd_agent_set_async_scratch_limit";
		case HSA_API_ID_hsa_status_string : return "hsa_status_string";
		case HSA_API_ID_hsa_init : return "hsa_init";
		case HSA_API_ID_hsa_shut_down : return "hsa_shut_down";
		case HSA_API_ID_hsa_system_get_info : return "hsa_system_get_info";
		case HSA_API_ID_hsa_extension_get_name : return "hsa_extension_get_name";
		case HSA_API_ID_hsa_system_extension_supported : return "hsa_system_extension_supported";
		case HSA_API_ID_hsa_system_major_extension_supported : return "hsa_system_major_extension_supported";
		case HSA_API_ID_hsa_system_get_extension_table : return "hsa_system_get_extension_table";
		case HSA_API_ID_hsa_system_get_major_extension_table : return "hsa_system_get_major_extension_table";
		case HSA_API_ID_hsa_agent_get_info : return "hsa_agent_get_info";
		case HSA_API_ID_hsa_iterate_agents : return "hsa_iterate_agents";
		case HSA_API_ID_hsa_agent_get_exception_policies : return "hsa_agent_get_exception_policies";
		case HSA_API_ID_hsa_cache_get_info : return "hsa_cache_get_info";
		case HSA_API_ID_hsa_agent_iterate_caches : return "hsa_agent_iterate_caches";
		case HSA_API_ID_hsa_agent_extension_supported : return "hsa_agent_extension_supported";
		case HSA_API_ID_hsa_agent_major_extension_supported : return "hsa_agent_major_extension_supported";
		case HSA_API_ID_hsa_signal_create : return "hsa_signal_create";
		case HSA_API_ID_hsa_signal_destroy : return "hsa_signal_destroy";
		case HSA_API_ID_hsa_signal_load_scacquire : return "hsa_signal_load_scacquire";
		case HSA_API_ID_hsa_signal_load_relaxed : return "hsa_signal_load_relaxed";
		case HSA_API_ID_hsa_signal_load_acquire : return "hsa_signal_load_acquire";
		case HSA_API_ID_hsa_signal_store_relaxed : return "hsa_signal_store_relaxed";
		case HSA_API_ID_hsa_signal_store_screlease : return "hsa_signal_store_screlease";
		case HSA_API_ID_hsa_signal_store_release : return "hsa_signal_store_release";
		case HSA_API_ID_hsa_signal_silent_store_relaxed : return "hsa_signal_silent_store_relaxed";
		case HSA_API_ID_hsa_signal_silent_store_screlease : return "hsa_signal_silent_store_screlease";
		case HSA_API_ID_hsa_signal_exchange_scacq_screl : return "hsa_signal_exchange_scacq_screl";
		case HSA_API_ID_hsa_signal_exchange_acq_rel : return "hsa_signal_exchange_acq_rel";
		case HSA_API_ID_hsa_signal_exchange_scacquire : return "hsa_signal_exchange_scacquire";
		case HSA_API_ID_hsa_signal_exchange_acquire : return "hsa_signal_exchange_acquire";
		case HSA_API_ID_hsa_signal_exchange_relaxed : return "hsa_signal_exchange_relaxed";
		case HSA_API_ID_hsa_signal_exchange_screlease : return "hsa_signal_exchange_screlease";
		case HSA_API_ID_hsa_signal_exchange_release : return "hsa_signal_exchange_release";
		case HSA_API_ID_hsa_signal_cas_scacq_screl : return "hsa_signal_cas_scacq_screl";
		case HSA_API_ID_hsa_signal_cas_acq_rel : return "hsa_signal_cas_acq_rel";
		case HSA_API_ID_hsa_signal_cas_scacquire : return "hsa_signal_cas_scacquire";
		case HSA_API_ID_hsa_signal_cas_acquire : return "hsa_signal_cas_acquire";
		case HSA_API_ID_hsa_signal_cas_relaxed : return "hsa_signal_cas_relaxed";
		case HSA_API_ID_hsa_signal_cas_screlease : return "hsa_signal_cas_screlease";
		case HSA_API_ID_hsa_signal_cas_release : return "hsa_signal_cas_release";
		case HSA_API_ID_hsa_signal_add_scacq_screl : return "hsa_signal_add_scacq_screl";
		case HSA_API_ID_hsa_signal_add_acq_rel : return "hsa_signal_add_acq_rel";
		case HSA_API_ID_hsa_signal_add_scacquire : return "hsa_signal_add_scacquire";
		case HSA_API_ID_hsa_signal_add_acquire : return "hsa_signal_add_acquire";
		case HSA_API_ID_hsa_signal_add_relaxed : return "hsa_signal_add_relaxed";
		case HSA_API_ID_hsa_signal_add_screlease : return "hsa_signal_add_screlease";
		case HSA_API_ID_hsa_signal_add_release : return "hsa_signal_add_release";
		case HSA_API_ID_hsa_signal_subtract_scacq_screl : return "hsa_signal_subtract_scacq_screl";
		case HSA_API_ID_hsa_signal_subtract_acq_rel : return "hsa_signal_subtract_acq_rel";
		case HSA_API_ID_hsa_signal_subtract_scacquire : return "hsa_signal_subtract_scacquire";
		case HSA_API_ID_hsa_signal_subtract_acquire : return "hsa_signal_subtract_acquire";
		case HSA_API_ID_hsa_signal_subtract_relaxed : return "hsa_signal_subtract_relaxed";
		case HSA_API_ID_hsa_signal_subtract_screlease : return "hsa_signal_subtract_screlease";
		case HSA_API_ID_hsa_signal_subtract_release : return "hsa_signal_subtract_release";
		case HSA_API_ID_hsa_signal_and_scacq_screl : return "hsa_signal_and_scacq_screl";
		case HSA_API_ID_hsa_signal_and_acq_rel : return "hsa_signal_and_acq_rel";
		case HSA_API_ID_hsa_signal_and_scacquire : return "hsa_signal_and_scacquire";
		case HSA_API_ID_hsa_signal_and_acquire : return "hsa_signal_and_acquire";
		case HSA_API_ID_hsa_signal_and_relaxed : return "hsa_signal_and_relaxed";
		case HSA_API_ID_hsa_signal_and_screlease : return "hsa_signal_and_screlease";
		case HSA_API_ID_hsa_signal_and_release : return "hsa_signal_and_release";
		case HSA_API_ID_hsa_signal_or_scacq_screl : return "hsa_signal_or_scacq_screl";
		case HSA_API_ID_hsa_signal_or_acq_rel : return "hsa_signal_or_acq_rel";
		case HSA_API_ID_hsa_signal_or_scacquire : return "hsa_signal_or_scacquire";
		case HSA_API_ID_hsa_signal_or_acquire : return "hsa_signal_or_acquire";
		case HSA_API_ID_hsa_signal_or_relaxed : return "hsa_signal_or_relaxed";
		case HSA_API_ID_hsa_signal_or_screlease : return "hsa_signal_or_screlease";
		case HSA_API_ID_hsa_signal_or_release : return "hsa_signal_or_release";
		case HSA_API_ID_hsa_signal_xor_scacq_screl : return "hsa_signal_xor_scacq_screl";
		case HSA_API_ID_hsa_signal_xor_acq_rel : return "hsa_signal_xor_acq_rel";
		case HSA_API_ID_hsa_signal_xor_scacquire : return "hsa_signal_xor_scacquire";
		case HSA_API_ID_hsa_signal_xor_acquire : return "hsa_signal_xor_acquire";
		case HSA_API_ID_hsa_signal_xor_relaxed : return "hsa_signal_xor_relaxed";
		case HSA_API_ID_hsa_signal_xor_screlease : return "hsa_signal_xor_screlease";
		case HSA_API_ID_hsa_signal_xor_release : return "hsa_signal_xor_release";
		case HSA_API_ID_hsa_signal_wait_scacquire : return "hsa_signal_wait_scacquire";
		case HSA_API_ID_hsa_signal_wait_relaxed : return "hsa_signal_wait_relaxed";
		case HSA_API_ID_hsa_signal_wait_acquire : return "hsa_signal_wait_acquire";
		case HSA_API_ID_hsa_signal_group_create : return "hsa_signal_group_create";
		case HSA_API_ID_hsa_signal_group_destroy : return "hsa_signal_group_destroy";
		case HSA_API_ID_hsa_signal_group_wait_any_scacquire : return "hsa_signal_group_wait_any_scacquire";
		case HSA_API_ID_hsa_signal_group_wait_any_relaxed : return "hsa_signal_group_wait_any_relaxed";
		case HSA_API_ID_hsa_queue_create : return "hsa_queue_create";
		case HSA_API_ID_hsa_soft_queue_create : return "hsa_soft_queue_create";
		case HSA_API_ID_hsa_queue_destroy : return "hsa_queue_destroy";
		case HSA_API_ID_hsa_queue_inactivate : return "hsa_queue_inactivate";
		case HSA_API_ID_hsa_queue_load_read_index_acquire : return "hsa_queue_load_read_index_acquire";
		case HSA_API_ID_hsa_queue_load_read_index_scacquire : return "hsa_queue_load_read_index_scacquire";
		case HSA_API_ID_hsa_queue_load_read_index_relaxed : return "hsa_queue_load_read_index_relaxed";
		case HSA_API_ID_hsa_queue_load_write_index_acquire : return "hsa_queue_load_write_index_acquire";
		case HSA_API_ID_hsa_queue_load_write_index_scacquire : return "hsa_queue_load_write_index_scacquire";
		case HSA_API_ID_hsa_queue_load_write_index_relaxed : return "hsa_queue_load_write_index_relaxed";
		case HSA_API_ID_hsa_queue_store_write_index_relaxed : return "hsa_queue_store_write_index_relaxed";
		case HSA_API_ID_hsa_queue_store_write_index_release : return "hsa_queue_store_write_index_release";
		case HSA_API_ID_hsa_queue_store_write_index_screlease : return "hsa_queue_store_write_index_screlease";
		case HSA_API_ID_hsa_queue_cas_write_index_acq_rel : return "hsa_queue_cas_write_index_acq_rel";
		case HSA_API_ID_hsa_queue_cas_write_index_scacq_screl : return "hsa_queue_cas_write_index_scacq_screl";
		case HSA_API_ID_hsa_queue_cas_write_index_acquire : return "hsa_queue_cas_write_index_acquire";
		case HSA_API_ID_hsa_queue_cas_write_index_scacquire : return "hsa_queue_cas_write_index_scacquire";
		case HSA_API_ID_hsa_queue_cas_write_index_relaxed : return "hsa_queue_cas_write_index_relaxed";
		case HSA_API_ID_hsa_queue_cas_write_index_release : return "hsa_queue_cas_write_index_release";
		case HSA_API_ID_hsa_queue_cas_write_index_screlease : return "hsa_queue_cas_write_index_screlease";
		case HSA_API_ID_hsa_queue_add_write_index_acq_rel : return "hsa_queue_add_write_index_acq_rel";
		case HSA_API_ID_hsa_queue_add_write_index_scacq_screl : return "hsa_queue_add_write_index_scacq_screl";
		case HSA_API_ID_hsa_queue_add_write_index_acquire : return "hsa_queue_add_write_index_acquire";
		case HSA_API_ID_hsa_queue_add_write_index_scacquire : return "hsa_queue_add_write_index_scacquire";
		case HSA_API_ID_hsa_queue_add_write_index_relaxed : return "hsa_queue_add_write_index_relaxed";
		case HSA_API_ID_hsa_queue_add_write_index_release : return "hsa_queue_add_write_index_release";
		case HSA_API_ID_hsa_queue_add_write_index_screlease : return "hsa_queue_add_write_index_screlease";
		case HSA_API_ID_hsa_queue_store_read_index_relaxed : return "hsa_queue_store_read_index_relaxed";
		case HSA_API_ID_hsa_queue_store_read_index_release : return "hsa_queue_store_read_index_release";
		case HSA_API_ID_hsa_queue_store_read_index_screlease : return "hsa_queue_store_read_index_screlease";
		case HSA_API_ID_hsa_region_get_info : return "hsa_region_get_info";
		case HSA_API_ID_hsa_agent_iterate_regions : return "hsa_agent_iterate_regions";
		case HSA_API_ID_hsa_memory_allocate : return "hsa_memory_allocate";
		case HSA_API_ID_hsa_memory_free : return "hsa_memory_free";
		case HSA_API_ID_hsa_memory_copy : return "hsa_memory_copy";
		case HSA_API_ID_hsa_memory_assign_agent : return "hsa_memory_assign_agent";
		case HSA_API_ID_hsa_memory_register : return "hsa_memory_register";
		case HSA_API_ID_hsa_memory_deregister : return "hsa_memory_deregister";
		case HSA_API_ID_hsa_isa_from_name : return "hsa_isa_from_name";
		case HSA_API_ID_hsa_agent_iterate_isas : return "hsa_agent_iterate_isas";
		case HSA_API_ID_hsa_isa_get_info : return "hsa_isa_get_info";
		case HSA_API_ID_hsa_isa_get_info_alt : return "hsa_isa_get_info_alt";
		case HSA_API_ID_hsa_isa_get_exception_policies : return "hsa_isa_get_exception_policies";
		case HSA_API_ID_hsa_isa_get_round_method : return "hsa_isa_get_round_method";
		case HSA_API_ID_hsa_wavefront_get_info : return "hsa_wavefront_get_info";
		case HSA_API_ID_hsa_isa_iterate_wavefronts : return "hsa_isa_iterate_wavefronts";
		case HSA_API_ID_hsa_isa_compatible : return "hsa_isa_compatible";
		case HSA_API_ID_hsa_code_object_reader_create_from_file : return "hsa_code_object_reader_create_from_file";
		case HSA_API_ID_hsa_code_object_reader_create_from_memory : return "hsa_code_object_reader_create_from_memory";
		case HSA_API_ID_hsa_code_object_reader_destroy : return "hsa_code_object_reader_destroy";
		case HSA_API_ID_hsa_executable_create : return "hsa_executable_create";
		case HSA_API_ID_hsa_executable_create_alt : return "hsa_executable_create_alt";
		case HSA_API_ID_hsa_executable_destroy : return "hsa_executable_destroy";
		case HSA_API_ID_hsa_executable_load_program_code_object : return "hsa_executable_load_program_code_object";
		case HSA_API_ID_hsa_executable_load_agent_code_object : return "hsa_executable_load_agent_code_object";
		case HSA_API_ID_hsa_executable_freeze : return "hsa_executable_freeze";
		case HSA_API_ID_hsa_executable_get_info : return "hsa_executable_get_info";
		case HSA_API_ID_hsa_executable_global_variable_define : return "hsa_executable_global_variable_define";
		case HSA_API_ID_hsa_executable_agent_global_variable_define : return "hsa_executable_agent_global_variable_define";
		case HSA_API_ID_hsa_executable_readonly_variable_define : return "hsa_executable_readonly_variable_define";
		case HSA_API_ID_hsa_executable_validate : return "hsa_executable_validate";
		case HSA_API_ID_hsa_executable_validate_alt : return "hsa_executable_validate_alt";
		case HSA_API_ID_hsa_executable_get_symbol : return "hsa_executable_get_symbol";
		case HSA_API_ID_hsa_executable_get_symbol_by_name : return "hsa_executable_get_symbol_by_name";
		case HSA_API_ID_hsa_executable_symbol_get_info : return "hsa_executable_symbol_get_info";
		case HSA_API_ID_hsa_executable_iterate_symbols : return "hsa_executable_iterate_symbols";
		case HSA_API_ID_hsa_executable_iterate_agent_symbols : return "hsa_executable_iterate_agent_symbols";
		case HSA_API_ID_hsa_executable_iterate_program_symbols : return "hsa_executable_iterate_program_symbols";
		case HSA_API_ID_hsa_code_object_serialize : return "hsa_code_object_serialize";
		case HSA_API_ID_hsa_code_object_deserialize : return "hsa_code_object_deserialize";
		case HSA_API_ID_hsa_code_object_destroy : return "hsa_code_object_destroy";
		case HSA_API_ID_hsa_code_object_get_info : return "hsa_code_object_get_info";
		case HSA_API_ID_hsa_executable_load_code_object : return "hsa_executable_load_code_object";
		case HSA_API_ID_hsa_code_object_get_symbol : return "hsa_code_object_get_symbol";
		case HSA_API_ID_hsa_code_object_get_symbol_from_name : return "hsa_code_object_get_symbol_from_name";
		case HSA_API_ID_hsa_code_symbol_get_info : return "hsa_code_symbol_get_info";
		case HSA_API_ID_hsa_code_object_iterate_symbols : return "hsa_code_object_iterate_symbols";
	}
	return NULL;
}

// HSA API data
typedef struct hsa_api_data_s {
	uint64_t corrId;
	bool is_enter;
	union {
		struct {
			hsa_agent_t agent;
			hsa_amd_coherency_type_t* type;
		} hsa_amd_coherency_get_type;
		struct {
			hsa_agent_t agent;
			hsa_amd_coherency_type_t type;
		} hsa_amd_coherency_set_type;
		struct {
			hsa_queue_t* queue;
			int enable;
		} hsa_amd_profiling_set_profiler_enabled;
		struct {
			bool enable;
		} hsa_amd_profiling_async_copy_enable;
		struct {
			hsa_agent_t agent;
			hsa_signal_t signal;
			hsa_amd_profiling_dispatch_time_t* time;
		} hsa_amd_profiling_get_dispatch_time;
		struct {
			hsa_signal_t signal;
			hsa_amd_profiling_async_copy_time_t* time;
		} hsa_amd_profiling_get_async_copy_time;
		struct {
			hsa_agent_t agent;
			uint64_t agent_tick;
			uint64_t* system_tick;
		} hsa_amd_profiling_convert_tick_to_system_domain;
		struct {
			hsa_signal_value_t initial_value;
			uint32_t num_consumers;
			const hsa_agent_t* consumers;
			uint64_t attributes;
			hsa_signal_t* signal;
		} hsa_amd_signal_create;
		struct {
			hsa_signal_t signal;
			volatile hsa_signal_value_t** value_ptr;
		} hsa_amd_signal_value_pointer;
		struct {
			hsa_signal_t signal;
			hsa_signal_condition_t cond;
			hsa_signal_value_t value;
			hsa_amd_signal_handler handler;
			void* arg;
		} hsa_amd_signal_async_handler;
		struct {
			void (*callback)(void* arg);
			void* arg;
		} hsa_amd_async_function;
		struct {
			uint32_t signal_count;
			hsa_signal_t* signals;
			hsa_signal_condition_t* conds;
			hsa_signal_value_t* values;
			uint64_t timeout_hint;
			hsa_wait_state_t wait_hint;
			hsa_signal_value_t* satisfying_value;
		} hsa_amd_signal_wait_any;
		struct {
			hsa_agent_t agent;
			hsa_agent_info_t attribute;
			void* value;
		} hsa_amd_image_get_info_max_dim;
		struct {
			const hsa_queue_t* queue;
			uint32_t num_cu_mask_count;
			const uint32_t* cu_mask;
		} hsa_amd_queue_cu_set_mask;
		struct {
			const hsa_queue_t* queue;
			uint32_t num_cu_mask_count;
			uint32_t* cu_mask;
		} hsa_amd_queue_cu_get_mask;
		struct {
			hsa_amd_memory_pool_t memory_pool;
			hsa_amd_memory_pool_info_t attribute;
			void* value;
		} hsa_amd_memory_pool_get_info;
		struct {
			hsa_agent_t agent;
			hsa_status_t (*callback)(hsa_amd_memory_pool_t memory_pool, void* data);
			void* data;
		} hsa_amd_agent_iterate_memory_pools;
		struct {
			hsa_amd_memory_pool_t memory_pool;
			size_t size;
			uint32_t flags;
			void** ptr;
		} hsa_amd_memory_pool_allocate;
		struct {
			void* ptr;
		} hsa_amd_memory_pool_free;
		struct {
			void* dst;
			hsa_agent_t dst_agent;
			const void* src;
			hsa_agent_t src_agent;
			size_t size;
			uint32_t num_dep_signals;
			const hsa_signal_t* dep_signals;
			hsa_signal_t completion_signal;
		} hsa_amd_memory_async_copy;
		struct {
			void* dst;
			hsa_agent_t dst_agent;
			const void* src;
			hsa_agent_t src_agent;
			size_t size;
			uint32_t num_dep_signals;
			const hsa_signal_t* dep_signals;
			hsa_signal_t completion_signal;
			hsa_amd_sdma_engine_id_t engine_id;
			bool force_copy_on_sdma;
		} hsa_amd_memory_async_copy_on_engine;
		struct {
			hsa_agent_t dst_agent;
			hsa_agent_t src_agent;
			uint32_t *engine_ids_mask;
		} hsa_amd_memory_copy_engine_status;
		struct {
			const hsa_pitched_ptr_t* dst;
			const hsa_dim3_t* dst_offset;
			const hsa_pitched_ptr_t* src;
			const hsa_dim3_t* src_offset;
			const hsa_dim3_t* range;
			hsa_agent_t copy_agent;
			hsa_amd_copy_direction_t dir;
			uint32_t num_dep_signals;
			const hsa_signal_t* dep_signals;
			hsa_signal_t completion_signal;
		} hsa_amd_memory_async_copy_rect;
		struct {
			hsa_agent_t agent;
			hsa_amd_memory_pool_t memory_pool;
			hsa_amd_agent_memory_pool_info_t attribute;
			void* value;
		} hsa_amd_agent_memory_pool_get_info;
		struct {
			uint32_t num_agents;
			const hsa_agent_t* agents;
			const uint32_t* flags;
			const void* ptr;
		} hsa_amd_agents_allow_access;
		struct {
			hsa_amd_memory_pool_t src_memory_pool;
			hsa_amd_memory_pool_t dst_memory_pool;
			bool* result;
		} hsa_amd_memory_pool_can_migrate;
		struct {
			const void* ptr;
			hsa_amd_memory_pool_t memory_pool;
			uint32_t flags;
		} hsa_amd_memory_migrate;
		struct {
			void* host_ptr;
			size_t size;
			hsa_agent_t* agents;
			int num_agent;
			void** agent_ptr;
		} hsa_amd_memory_lock;
		struct {
			void* host_ptr;
			size_t size;
			hsa_agent_t* agents;
			int num_agent;
			hsa_amd_memory_pool_t pool;
			uint32_t flags;
			void** agent_ptr;
		} hsa_amd_memory_lock_to_pool;
		struct {
			void* host_ptr;
		} hsa_amd_memory_unlock;
		struct {
			void* ptr;
			uint32_t value;
			size_t count;
		} hsa_amd_memory_fill;
		struct {
			uint32_t num_agents;
			hsa_agent_t* agents;
			int interop_handle;
			uint32_t flags;
			size_t* size;
			void** ptr;
			size_t* metadata_size;
			const void** metadata;
		} hsa_amd_interop_map_buffer;
		struct {
			void* ptr;
		} hsa_amd_interop_unmap_buffer;
		struct {
			hsa_agent_t agent;
			const hsa_ext_image_descriptor_t *image_descriptor;
			const hsa_amd_image_descriptor_t *image_layout;
			const void *image_data;
			hsa_access_permission_t access_permission;
			hsa_ext_image_t *image;
		} hsa_amd_image_create;
		struct {
			const void* ptr;
			hsa_amd_pointer_info_t* info;
			void* (*alloc)(size_t);
			uint32_t* num_agents_accessible;
			hsa_agent_t** accessible;
		} hsa_amd_pointer_info;
		struct {
			const void* ptr;
			void* userdata;
		} hsa_amd_pointer_info_set_userdata;
		struct {
			void* ptr;
			size_t len;
			hsa_amd_ipc_memory_t* handle;
		} hsa_amd_ipc_memory_create;
		struct {
			const hsa_amd_ipc_memory_t* handle;
			size_t len;
			uint32_t num_agents;
			const hsa_agent_t* mapping_agents;
			void** mapped_ptr;
		} hsa_amd_ipc_memory_attach;
		struct {
			void* mapped_ptr;
		} hsa_amd_ipc_memory_detach;
		struct {
			hsa_signal_t signal;
			hsa_amd_ipc_signal_t* handle;
		} hsa_amd_ipc_signal_create;
		struct {
			const hsa_amd_ipc_signal_t* handle;
			hsa_signal_t* signal;
		} hsa_amd_ipc_signal_attach;
		struct {
			hsa_amd_system_event_callback_t callback;
			void* data;
		} hsa_amd_register_system_event_handler;
		struct {
			hsa_queue_t* queue;
			hsa_amd_queue_priority_t priority;
		} hsa_amd_queue_set_priority;
		struct {
			void* ptr;
			hsa_amd_deallocation_callback_t callback;
			void* user_data;
		} hsa_amd_register_deallocation_callback;
		struct {
			void* ptr;
			hsa_amd_deallocation_callback_t callback;
		} hsa_amd_deregister_deallocation_callback;
		struct {
			void* ptr;
			size_t size;
			hsa_amd_svm_attribute_pair_t* attribute_list;
			size_t attribute_count;
		} hsa_amd_svm_attributes_set;
		struct {
			void* ptr;
			size_t size;
			hsa_amd_svm_attribute_pair_t* attribute_list;
			size_t attribute_count;
		} hsa_amd_svm_attributes_get;
		struct {
			void* ptr;
			size_t size;
			hsa_agent_t agent;
			uint32_t num_dep_signals;
			const hsa_signal_t* dep_signals;
			hsa_signal_t completion_signal;
		} hsa_amd_svm_prefetch_async;
		struct {
			hsa_agent_t preferred_agent;
		} hsa_amd_spm_acquire;
		struct {
			hsa_agent_t preferred_agent;
		} hsa_amd_spm_release;
		struct {
			hsa_agent_t preferred_agent;
			size_t size_in_bytes;
			uint32_t* timeout;
			uint32_t* size_copied;
			void* dest;
			bool* is_data_loss;
		} hsa_amd_spm_set_dest_buffer;
		struct {
			const void* ptr;
			size_t size;
			int* dmabuf;
			uint64_t* offset;
		} hsa_amd_portable_export_dmabuf;
		struct {
			int dmabuf;
		} hsa_amd_portable_close_dmabuf;
		struct {
			void** va;
			size_t size;
			uint64_t address;
			uint64_t flags;
		} hsa_amd_vmem_address_reserve;
		struct {
			void* va;
			size_t size;
		} hsa_amd_vmem_address_free;
		struct {
			hsa_amd_memory_pool_t pool;
			size_t size;
			hsa_amd_memory_type_t type;
			uint64_t flags;
			hsa_amd_vmem_alloc_handle_t* memory_handle;
		} hsa_amd_vmem_handle_create;
		struct {
			hsa_amd_vmem_alloc_handle_t memory_handle;
		} hsa_amd_vmem_handle_release;
		struct {
			void* va;
			size_t size;
			size_t in_offset;
			hsa_amd_vmem_alloc_handle_t memory_handle;
			uint64_t flags;
		} hsa_amd_vmem_map;
		struct {
			void* va;
			size_t size;
		} hsa_amd_vmem_unmap;
		struct {
			void* va;
			size_t size;
			const hsa_amd_memory_access_desc_t* desc;
			size_t desc_cnt;
		} hsa_amd_vmem_set_access;
		struct {
			void* va;
			hsa_access_permission_t* perms;
			hsa_agent_t agent_handle;
		} hsa_amd_vmem_get_access;
		struct {
			int* dmabuf_fd;
			hsa_amd_vmem_alloc_handle_t handle;
			uint64_t flags;
		} hsa_amd_vmem_export_shareable_handle;
		struct {
			int dmabuf_fd;
			hsa_amd_vmem_alloc_handle_t* handle;
		} hsa_amd_vmem_import_shareable_handle;
		struct {
			hsa_amd_vmem_alloc_handle_t* memory_handle;
			void* addr;
		} hsa_amd_vmem_retain_alloc_handle;
		struct {
			hsa_amd_vmem_alloc_handle_t memory_handle;
			hsa_amd_memory_pool_t* pool;
			hsa_amd_memory_type_t* type;
		} hsa_amd_vmem_get_alloc_properties_from_handle;
		struct {
			hsa_agent_t agent;
			size_t threshold;
		} hsa_amd_agent_set_async_scratch_limit;
		struct {
			hsa_status_t status;
			const char ** status_string;
		} hsa_status_string;
		struct {
		} hsa_init;
		struct {
		} hsa_shut_down;
		struct {
			hsa_system_info_t attribute;
			void* value;
		} hsa_system_get_info;
		struct {
			uint16_t extension;
			const char **name;
		} hsa_extension_get_name;
		struct {
			uint16_t extension;
			uint16_t version_major;
			uint16_t version_minor;
			bool* result;
		} hsa_system_extension_supported;
		struct {
			uint16_t extension;
			uint16_t version_major;
			uint16_t *version_minor;
			bool* result;
		} hsa_system_major_extension_supported;
		struct {
			uint16_t extension;
			uint16_t version_major;
			uint16_t version_minor;
			void *table;
		} hsa_system_get_extension_table;
		struct {
			uint16_t extension;
			uint16_t version_major;
			size_t table_length;
			void *table;
		} hsa_system_get_major_extension_table;
		struct {
			hsa_agent_t agent;
			hsa_agent_info_t attribute;
			void* value;
		} hsa_agent_get_info;
		struct {
			hsa_status_t (*callback)(hsa_agent_t agent, void* data);
			void* data;
		} hsa_iterate_agents;
		struct {
			hsa_agent_t agent;
			hsa_profile_t profile;
			uint16_t *mask;
		} hsa_agent_get_exception_policies;
		struct {
			hsa_cache_t cache;
			hsa_cache_info_t attribute;
			void* value;
		} hsa_cache_get_info;
		struct {
			hsa_agent_t agent;
			hsa_status_t (*callback)(hsa_cache_t cache, void* data);
			void* data;
		} hsa_agent_iterate_caches;
		struct {
			uint16_t extension;
			hsa_agent_t agent;
			uint16_t version_major;
			uint16_t version_minor;
			bool* result;
		} hsa_agent_extension_supported;
		struct {
			uint16_t extension;
			hsa_agent_t agent;
			uint16_t version_major;
			uint16_t *version_minor;
			bool* result;
		} hsa_agent_major_extension_supported;
		struct {
			hsa_signal_value_t initial_value;
			uint32_t num_consumers;
			const hsa_agent_t *consumers;
			hsa_signal_t *signal;
		} hsa_signal_create;
		struct {
			hsa_signal_t signal;
		} hsa_signal_destroy;
		struct {
			hsa_signal_t signal;
		} hsa_signal_load_scacquire;
		struct {
			hsa_signal_t signal;
		} hsa_signal_load_relaxed;
		struct {
			hsa_signal_t signal;
		} hsa_signal_load_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_store_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_store_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_store_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_silent_store_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_silent_store_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_exchange_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t expected;
			hsa_signal_value_t value;
		} hsa_signal_cas_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_add_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_subtract_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_and_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_or_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_scacq_screl;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_acq_rel;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_acquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_screlease;
		struct {
			hsa_signal_t signal;
			hsa_signal_value_t value;
		} hsa_signal_xor_release;
		struct {
			hsa_signal_t signal;
			hsa_signal_condition_t condition;
			hsa_signal_value_t compare_value;
			uint64_t timeout_hint;
			hsa_wait_state_t wait_state_hint;
		} hsa_signal_wait_scacquire;
		struct {
			hsa_signal_t signal;
			hsa_signal_condition_t condition;
			hsa_signal_value_t compare_value;
			uint64_t timeout_hint;
			hsa_wait_state_t wait_state_hint;
		} hsa_signal_wait_relaxed;
		struct {
			hsa_signal_t signal;
			hsa_signal_condition_t condition;
			hsa_signal_value_t compare_value;
			uint64_t timeout_hint;
			hsa_wait_state_t wait_state_hint;
		} hsa_signal_wait_acquire;
		struct {
			uint32_t num_signals;
			const hsa_signal_t *signals;
			uint32_t num_consumers;
			const hsa_agent_t *consumers;
			hsa_signal_group_t *signal_group;
		} hsa_signal_group_create;
		struct {
			hsa_signal_group_t signal_group;
		} hsa_signal_group_destroy;
		struct {
			hsa_signal_group_t signal_group;
			const hsa_signal_condition_t *conditions;
			const hsa_signal_value_t *compare_values;
			hsa_wait_state_t wait_state_hint;
			hsa_signal_t *signal;
			hsa_signal_value_t *value;
		} hsa_signal_group_wait_any_scacquire;
		struct {
			hsa_signal_group_t signal_group;
			const hsa_signal_condition_t *conditions;
			const hsa_signal_value_t *compare_values;
			hsa_wait_state_t wait_state_hint;
			hsa_signal_t *signal;
			hsa_signal_value_t *value;
		} hsa_signal_group_wait_any_relaxed;
		struct {
			hsa_agent_t agent;
			uint32_t size;
			hsa_queue_type32_t type;
			void (*callback)(hsa_status_t status, hsa_queue_t *source, void *data);
			void *data;
			uint32_t private_segment_size;
			uint32_t group_segment_size;
			hsa_queue_t **queue;
		} hsa_queue_create;
		struct {
			hsa_region_t region;
			uint32_t size;
			hsa_queue_type32_t type;
			uint32_t features;
			hsa_signal_t doorbell_signal;
			hsa_queue_t **queue;
		} hsa_soft_queue_create;
		struct {
			hsa_queue_t *queue;
		} hsa_queue_destroy;
		struct {
			hsa_queue_t *queue;
		} hsa_queue_inactivate;
		struct {
			const hsa_queue_t *queue;
		} hsa_queue_load_read_index_acquire;
		struct {
			const hsa_queue_t *queue;
		} hsa_queue_load_read_index_scacquire;
		struct {
			const hsa_queue_t *queue;
		} hsa_queue_load_read_index_relaxed;
		struct {
			const hsa_queue_t *queue;
		} hsa_queue_load_write_index_acquire;
		struct {
			const hsa_queue_t *queue;
		} hsa_queue_load_write_index_scacquire;
		struct {
			const hsa_queue_t *queue;
		} hsa_queue_load_write_index_relaxed;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_store_write_index_relaxed;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_store_write_index_release;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_store_write_index_screlease;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_acq_rel;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_scacq_screl;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_acquire;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_scacquire;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_relaxed;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_release;
		struct {
			const hsa_queue_t *queue;
			uint64_t expected;
			uint64_t value;
		} hsa_queue_cas_write_index_screlease;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_acq_rel;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_scacq_screl;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_acquire;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_scacquire;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_relaxed;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_release;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_add_write_index_screlease;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_store_read_index_relaxed;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_store_read_index_release;
		struct {
			const hsa_queue_t *queue;
			uint64_t value;
		} hsa_queue_store_read_index_screlease;
		struct {
			hsa_region_t region;
			hsa_region_info_t attribute;
			void* value;
		} hsa_region_get_info;
		struct {
			hsa_agent_t agent;
			hsa_status_t (*callback)(hsa_region_t region, void* data);
			void* data;
		} hsa_agent_iterate_regions;
		struct {
			hsa_region_t region;
			size_t size;
			void** ptr;
		} hsa_memory_allocate;
		struct {
			void* ptr;
		} hsa_memory_free;
		struct {
			void *dst;
			const void *src;
			size_t size;
		} hsa_memory_copy;
		struct {
			void *ptr;
			hsa_agent_t agent;
			hsa_access_permission_t access;
		} hsa_memory_assign_agent;
		struct {
			void *ptr;
			size_t size;
		} hsa_memory_register;
		struct {
			void *ptr;
			size_t size;
		} hsa_memory_deregister;
		struct {
			const char *name;
			hsa_isa_t *isa;
		} hsa_isa_from_name;
		struct {
			hsa_agent_t agent;
			hsa_status_t (*callback)(hsa_isa_t isa, void *data);
			void *data;
		} hsa_agent_iterate_isas;
		struct {
			hsa_isa_t isa;
			hsa_isa_info_t attribute;
			uint32_t index;
			void *value;
		} hsa_isa_get_info;
		struct {
			hsa_isa_t isa;
			hsa_isa_info_t attribute;
			void *value;
		} hsa_isa_get_info_alt;
		struct {
			hsa_isa_t isa;
			hsa_profile_t profile;
			uint16_t *mask;
		} hsa_isa_get_exception_policies;
		struct {
			hsa_isa_t isa;
			hsa_fp_type_t fp_type;
			hsa_flush_mode_t flush_mode;
			hsa_round_method_t *round_method;
		} hsa_isa_get_round_method;
		struct {
			hsa_wavefront_t wavefront;
			hsa_wavefront_info_t attribute;
			void *value;
		} hsa_wavefront_get_info;
		struct {
			hsa_isa_t isa;
			hsa_status_t (*callback)(hsa_wavefront_t wavefront, void *data);
			void *data;
		} hsa_isa_iterate_wavefronts;
		struct {
			hsa_isa_t code_object_isa;
			hsa_isa_t agent_isa;
			bool *result;
		} hsa_isa_compatible;
		struct {
			hsa_file_t file;
			hsa_code_object_reader_t *code_object_reader;
		} hsa_code_object_reader_create_from_file;
		struct {
			const void *code_object;
			size_t size;
			hsa_code_object_reader_t *code_object_reader;
		} hsa_code_object_reader_create_from_memory;
		struct {
			hsa_code_object_reader_t code_object_reader;
		} hsa_code_object_reader_destroy;
		struct {
			hsa_profile_t profile;
			hsa_executable_state_t executable_state;
			const char *options;
			hsa_executable_t *executable;
		} hsa_executable_create;
		struct {
			hsa_profile_t profile;
			hsa_default_float_rounding_mode_t default_float_rounding_mode;
			const char *options;
			hsa_executable_t *executable;
		} hsa_executable_create_alt;
		struct {
			hsa_executable_t executable;
		} hsa_executable_destroy;
		struct {
			hsa_executable_t executable;
			hsa_code_object_reader_t code_object_reader;
			const char *options;
			hsa_loaded_code_object_t *loaded_code_object;
		} hsa_executable_load_program_code_object;
		struct {
			hsa_executable_t executable;
			hsa_agent_t agent;
			hsa_code_object_reader_t code_object_reader;
			const char *options;
			hsa_loaded_code_object_t *loaded_code_object;
		} hsa_executable_load_agent_code_object;
		struct {
			hsa_executable_t executable;
			const char *options;
		} hsa_executable_freeze;
		struct {
			hsa_executable_t executable;
			hsa_executable_info_t attribute;
			void *value;
		} hsa_executable_get_info;
		struct {
			hsa_executable_t executable;
			const char *variable_name;
			void *address;
		} hsa_executable_global_variable_define;
		struct {
			hsa_executable_t executable;
			hsa_agent_t agent;
			const char *variable_name;
			void *address;
		} hsa_executable_agent_global_variable_define;
		struct {
			hsa_executable_t executable;
			hsa_agent_t agent;
			const char *variable_name;
			void *address;
		} hsa_executable_readonly_variable_define;
		struct {
			hsa_executable_t executable;
			uint32_t *result;
		} hsa_executable_validate;
		struct {
			hsa_executable_t executable;
			const char *options;
			uint32_t *result;
		} hsa_executable_validate_alt;
		struct {
			hsa_executable_t executable;
			const char *module_name;
			const char *symbol_name;
			hsa_agent_t agent;
			int32_t call_convention;
			hsa_executable_symbol_t *symbol;
		} hsa_executable_get_symbol;
		struct {
			hsa_executable_t executable;
			const char *symbol_name;
			const hsa_agent_t *agent;
			hsa_executable_symbol_t *symbol;
		} hsa_executable_get_symbol_by_name;
		struct {
			hsa_executable_symbol_t executable_symbol;
			hsa_executable_symbol_info_t attribute;
			void *value;
		} hsa_executable_symbol_get_info;
		struct {
			hsa_executable_t executable;
			hsa_status_t (*callback)(hsa_executable_t exec,hsa_executable_symbol_t symbol,void *data);
			void *data;
		} hsa_executable_iterate_symbols;
		struct {
			hsa_executable_t executable;
			hsa_agent_t agent;
			hsa_status_t (*callback)(hsa_executable_t exec,hsa_agent_t agent,hsa_executable_symbol_t symbol,void *data);
			void *data;
		} hsa_executable_iterate_agent_symbols;
		struct {
			hsa_executable_t executable;
			hsa_status_t (*callback)(hsa_executable_t exec,hsa_executable_symbol_t symbol,void *data);
			void *data;
		} hsa_executable_iterate_program_symbols;
		struct {
			hsa_code_object_t code_object;
			hsa_status_t (*alloc_callback)(size_t size,hsa_callback_data_t data,void **address);
			hsa_callback_data_t callback_data;
			const char *options;
			void **serialized_code_object;
			size_t *serialized_code_object_size;
		} hsa_code_object_serialize;
		struct {
			void *serialized_code_object;
			size_t serialized_code_object_size;
			const char *options;
			hsa_code_object_t *code_object;
		} hsa_code_object_deserialize;
		struct {
			hsa_code_object_t code_object;
		} hsa_code_object_destroy;
		struct {
			hsa_code_object_t code_object;
			hsa_code_object_info_t attribute;
			void *value;
		} hsa_code_object_get_info;
		struct {
			hsa_executable_t executable;
			hsa_agent_t agent;
			hsa_code_object_t code_object;
			const char *options;
		} hsa_executable_load_code_object;
		struct {
			hsa_code_object_t code_object;
			const char *symbol_name;
			hsa_code_symbol_t *symbol;
		} hsa_code_object_get_symbol;
		struct {
			hsa_code_object_t code_object;
			const char *module_name;
			const char *symbol_name;
			hsa_code_symbol_t *symbol;
		} hsa_code_object_get_symbol_from_name;
		struct {
			hsa_code_symbol_t code_symbol;
			hsa_code_symbol_info_t attribute;
			void *value;
		} hsa_code_symbol_get_info;
		struct {
			hsa_code_object_t code_object;
			hsa_status_t (*callback)(hsa_code_object_t code_object,hsa_code_symbol_t symbol,void *data);
			void *data;
		} hsa_code_object_iterate_symbols;
	} args;
} hsa_api_data_t;

#endif