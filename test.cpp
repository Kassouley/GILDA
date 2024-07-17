#include <dlfcn.h>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <math.h>
#include <mutex>
#include <sstream>
#include <stdio.h>
#include <string.h>
#include <vector>
#include <functional>
#include <hsa/hsa.h>
#include <hsa/hsa_ext_amd.h>

#define HANDLE(v, handle) \
    do { \
        itcp_table.fn_##v = reinterpret_cast<decltype(&v)>(dlsym(handle, #v)); \
        if (!itcp_table.fn_##v) { \
            fprintf(stderr, "Failed to load \"%s\"\n", #v); \
            abort(); \
        } \
    } while (false)

extern "C" {
void (*stored_callback)(int is_enter, std::string func);

void init_callback(void (*callback)(int is_enter, std::string func)) {
    stored_callback = callback;
}

void callback_function(int is_enter, std::string func) {
	if (is_enter)
    	printf("%s\n", func.c_str());
    // if (stored_callback) {
    //     stored_callback(is_enter, func);
    // } else {
    //     std::cerr << "No callback function has been set." << std::endl;
    // }
}
void sample(int is_enter, std::string func) {
	printf("%s\n", func.c_str());
}
}

struct intercept_table_t {
	typeof(&hsa_shut_down) fn_hsa_shut_down;
	typeof(&hsa_init) fn_hsa_init;
	typeof(&hsa_system_get_info) fn_hsa_system_get_info;
	typeof(&hsa_extension_get_name) fn_hsa_extension_get_name;
	typeof(&hsa_system_extension_supported) fn_hsa_system_extension_supported;
	typeof(&hsa_system_major_extension_supported) fn_hsa_system_major_extension_supported;
	typeof(&hsa_system_get_extension_table) fn_hsa_system_get_extension_table;
	typeof(&hsa_system_get_major_extension_table) fn_hsa_system_get_major_extension_table;
	typeof(&hsa_iterate_agents) fn_hsa_iterate_agents;
	typeof(&hsa_agent_get_info) fn_hsa_agent_get_info;
	typeof(&hsa_agent_get_exception_policies) fn_hsa_agent_get_exception_policies;
	typeof(&hsa_cache_get_info) fn_hsa_cache_get_info;
	typeof(&hsa_agent_iterate_caches) fn_hsa_agent_iterate_caches;
	typeof(&hsa_agent_extension_supported) fn_hsa_agent_extension_supported;
	typeof(&hsa_agent_major_extension_supported) fn_hsa_agent_major_extension_supported;
	typeof(&hsa_queue_create) fn_hsa_queue_create;
	typeof(&hsa_soft_queue_create) fn_hsa_soft_queue_create;
	typeof(&hsa_queue_destroy) fn_hsa_queue_destroy;
	typeof(&hsa_queue_inactivate) fn_hsa_queue_inactivate;
	typeof(&hsa_queue_load_read_index_scacquire) fn_hsa_queue_load_read_index_scacquire;
	typeof(&hsa_queue_load_read_index_relaxed) fn_hsa_queue_load_read_index_relaxed;
	typeof(&hsa_queue_load_write_index_scacquire) fn_hsa_queue_load_write_index_scacquire;
	typeof(&hsa_queue_load_write_index_relaxed) fn_hsa_queue_load_write_index_relaxed;
	typeof(&hsa_queue_store_write_index_relaxed) fn_hsa_queue_store_write_index_relaxed;
	typeof(&hsa_queue_store_write_index_screlease) fn_hsa_queue_store_write_index_screlease;
	typeof(&hsa_queue_cas_write_index_scacq_screl) fn_hsa_queue_cas_write_index_scacq_screl;
	typeof(&hsa_queue_cas_write_index_scacquire) fn_hsa_queue_cas_write_index_scacquire;
	typeof(&hsa_queue_cas_write_index_relaxed) fn_hsa_queue_cas_write_index_relaxed;
	typeof(&hsa_queue_cas_write_index_screlease) fn_hsa_queue_cas_write_index_screlease;
	typeof(&hsa_queue_add_write_index_scacq_screl) fn_hsa_queue_add_write_index_scacq_screl;
	typeof(&hsa_queue_add_write_index_scacquire) fn_hsa_queue_add_write_index_scacquire;
	typeof(&hsa_queue_add_write_index_relaxed) fn_hsa_queue_add_write_index_relaxed;
	typeof(&hsa_queue_add_write_index_screlease) fn_hsa_queue_add_write_index_screlease;
	typeof(&hsa_queue_store_read_index_relaxed) fn_hsa_queue_store_read_index_relaxed;
	typeof(&hsa_queue_store_read_index_screlease) fn_hsa_queue_store_read_index_screlease;
	typeof(&hsa_agent_iterate_regions) fn_hsa_agent_iterate_regions;
	typeof(&hsa_region_get_info) fn_hsa_region_get_info;
	typeof(&hsa_memory_register) fn_hsa_memory_register;
	typeof(&hsa_memory_deregister) fn_hsa_memory_deregister;
	typeof(&hsa_memory_allocate) fn_hsa_memory_allocate;
	typeof(&hsa_memory_free) fn_hsa_memory_free;
	typeof(&hsa_memory_copy) fn_hsa_memory_copy;
	typeof(&hsa_memory_assign_agent) fn_hsa_memory_assign_agent;
	typeof(&hsa_signal_create) fn_hsa_signal_create;
	typeof(&hsa_signal_destroy) fn_hsa_signal_destroy;
	typeof(&hsa_signal_load_relaxed) fn_hsa_signal_load_relaxed;
	typeof(&hsa_signal_load_scacquire) fn_hsa_signal_load_scacquire;
	typeof(&hsa_signal_store_relaxed) fn_hsa_signal_store_relaxed;
	typeof(&hsa_signal_store_screlease) fn_hsa_signal_store_screlease;
	typeof(&hsa_signal_silent_store_relaxed) fn_hsa_signal_silent_store_relaxed;
	typeof(&hsa_signal_silent_store_screlease) fn_hsa_signal_silent_store_screlease;
	typeof(&hsa_signal_wait_relaxed) fn_hsa_signal_wait_relaxed;
	typeof(&hsa_signal_wait_scacquire) fn_hsa_signal_wait_scacquire;
	typeof(&hsa_signal_group_create) fn_hsa_signal_group_create;
	typeof(&hsa_signal_group_destroy) fn_hsa_signal_group_destroy;
	typeof(&hsa_signal_group_wait_any_scacquire) fn_hsa_signal_group_wait_any_scacquire;
	typeof(&hsa_signal_group_wait_any_relaxed) fn_hsa_signal_group_wait_any_relaxed;
	typeof(&hsa_signal_and_relaxed) fn_hsa_signal_and_relaxed;
	typeof(&hsa_signal_and_scacquire) fn_hsa_signal_and_scacquire;
	typeof(&hsa_signal_and_screlease) fn_hsa_signal_and_screlease;
	typeof(&hsa_signal_and_scacq_screl) fn_hsa_signal_and_scacq_screl;
	typeof(&hsa_signal_or_relaxed) fn_hsa_signal_or_relaxed;
	typeof(&hsa_signal_or_scacquire) fn_hsa_signal_or_scacquire;
	typeof(&hsa_signal_or_screlease) fn_hsa_signal_or_screlease;
	typeof(&hsa_signal_or_scacq_screl) fn_hsa_signal_or_scacq_screl;
	typeof(&hsa_signal_xor_relaxed) fn_hsa_signal_xor_relaxed;
	typeof(&hsa_signal_xor_scacquire) fn_hsa_signal_xor_scacquire;
	typeof(&hsa_signal_xor_screlease) fn_hsa_signal_xor_screlease;
	typeof(&hsa_signal_xor_scacq_screl) fn_hsa_signal_xor_scacq_screl;
	typeof(&hsa_signal_add_relaxed) fn_hsa_signal_add_relaxed;
	typeof(&hsa_signal_add_scacquire) fn_hsa_signal_add_scacquire;
	typeof(&hsa_signal_add_screlease) fn_hsa_signal_add_screlease;
	typeof(&hsa_signal_add_scacq_screl) fn_hsa_signal_add_scacq_screl;
	typeof(&hsa_signal_subtract_relaxed) fn_hsa_signal_subtract_relaxed;
	typeof(&hsa_signal_subtract_scacquire) fn_hsa_signal_subtract_scacquire;
	typeof(&hsa_signal_subtract_screlease) fn_hsa_signal_subtract_screlease;
	typeof(&hsa_signal_subtract_scacq_screl) fn_hsa_signal_subtract_scacq_screl;
	typeof(&hsa_signal_exchange_relaxed) fn_hsa_signal_exchange_relaxed;
	typeof(&hsa_signal_exchange_scacquire) fn_hsa_signal_exchange_scacquire;
	typeof(&hsa_signal_exchange_screlease) fn_hsa_signal_exchange_screlease;
	typeof(&hsa_signal_exchange_scacq_screl) fn_hsa_signal_exchange_scacq_screl;
	typeof(&hsa_signal_cas_relaxed) fn_hsa_signal_cas_relaxed;
	typeof(&hsa_signal_cas_scacquire) fn_hsa_signal_cas_scacquire;
	typeof(&hsa_signal_cas_screlease) fn_hsa_signal_cas_screlease;
	typeof(&hsa_signal_cas_scacq_screl) fn_hsa_signal_cas_scacq_screl;
	typeof(&hsa_isa_from_name) fn_hsa_isa_from_name;
	typeof(&hsa_agent_iterate_isas) fn_hsa_agent_iterate_isas;
	typeof(&hsa_isa_get_info) fn_hsa_isa_get_info;
	typeof(&hsa_isa_get_info_alt) fn_hsa_isa_get_info_alt;
	typeof(&hsa_isa_get_exception_policies) fn_hsa_isa_get_exception_policies;
	typeof(&hsa_isa_get_round_method) fn_hsa_isa_get_round_method;
	typeof(&hsa_wavefront_get_info) fn_hsa_wavefront_get_info;
	typeof(&hsa_isa_iterate_wavefronts) fn_hsa_isa_iterate_wavefronts;
	typeof(&hsa_isa_compatible) fn_hsa_isa_compatible;
	typeof(&hsa_code_object_serialize) fn_hsa_code_object_serialize;
	typeof(&hsa_code_object_deserialize) fn_hsa_code_object_deserialize;
	typeof(&hsa_code_object_destroy) fn_hsa_code_object_destroy;
	typeof(&hsa_code_object_get_info) fn_hsa_code_object_get_info;
	typeof(&hsa_code_object_get_symbol) fn_hsa_code_object_get_symbol;
	typeof(&hsa_code_object_get_symbol_from_name) fn_hsa_code_object_get_symbol_from_name;
	typeof(&hsa_code_symbol_get_info) fn_hsa_code_symbol_get_info;
	typeof(&hsa_code_object_iterate_symbols) fn_hsa_code_object_iterate_symbols;
	typeof(&hsa_code_object_reader_create_from_file) fn_hsa_code_object_reader_create_from_file;
	typeof(&hsa_code_object_reader_create_from_memory) fn_hsa_code_object_reader_create_from_memory;
	typeof(&hsa_code_object_reader_destroy) fn_hsa_code_object_reader_destroy;
	typeof(&hsa_executable_create) fn_hsa_executable_create;
	typeof(&hsa_executable_create_alt) fn_hsa_executable_create_alt;
	typeof(&hsa_executable_destroy) fn_hsa_executable_destroy;
	typeof(&hsa_executable_load_code_object) fn_hsa_executable_load_code_object;
	typeof(&hsa_executable_load_program_code_object) fn_hsa_executable_load_program_code_object;
	typeof(&hsa_executable_load_agent_code_object) fn_hsa_executable_load_agent_code_object;
	typeof(&hsa_executable_freeze) fn_hsa_executable_freeze;
	typeof(&hsa_executable_get_info) fn_hsa_executable_get_info;
	typeof(&hsa_executable_global_variable_define) fn_hsa_executable_global_variable_define;
	typeof(&hsa_executable_agent_global_variable_define) fn_hsa_executable_agent_global_variable_define;
	typeof(&hsa_executable_readonly_variable_define) fn_hsa_executable_readonly_variable_define;
	typeof(&hsa_executable_validate) fn_hsa_executable_validate;
	typeof(&hsa_executable_validate_alt) fn_hsa_executable_validate_alt;
	typeof(&hsa_executable_get_symbol) fn_hsa_executable_get_symbol;
	typeof(&hsa_executable_get_symbol_by_name) fn_hsa_executable_get_symbol_by_name;
	typeof(&hsa_executable_symbol_get_info) fn_hsa_executable_symbol_get_info;
	typeof(&hsa_executable_iterate_symbols) fn_hsa_executable_iterate_symbols;
	typeof(&hsa_executable_iterate_agent_symbols) fn_hsa_executable_iterate_agent_symbols;
	typeof(&hsa_executable_iterate_program_symbols) fn_hsa_executable_iterate_program_symbols;
	typeof(&hsa_status_string) fn_hsa_status_string;
	typeof(&hsa_amd_profiling_get_dispatch_time) fn_hsa_amd_profiling_get_dispatch_time;
	typeof(&hsa_amd_memory_async_copy) fn_hsa_amd_memory_async_copy;
};


static intercept_table_t itcp_table;

static void* load_handle() {
    void *handle = dlopen("/opt/rocm-6.1.1/lib/libhsa-runtime64.so.1", RTLD_LOCAL | RTLD_LAZY);
    if (handle)
        return handle;
    fprintf(stderr, "/opt/rocm-6.1.1/lib/libhsa-runtime64.so.1 not found\n");
    abort();\
}
static void load_itcp_table() {
    void *handle = load_handle();

	HANDLE(hsa_shut_down, handle);
	HANDLE(hsa_init, handle);
	HANDLE(hsa_system_get_info, handle);
	HANDLE(hsa_extension_get_name, handle);
	HANDLE(hsa_system_extension_supported, handle);
	HANDLE(hsa_system_major_extension_supported, handle);
	HANDLE(hsa_system_get_extension_table, handle);
	HANDLE(hsa_system_get_major_extension_table, handle);
	HANDLE(hsa_iterate_agents, handle);
	HANDLE(hsa_agent_get_info, handle);
	HANDLE(hsa_agent_get_exception_policies, handle);
	HANDLE(hsa_cache_get_info, handle);
	HANDLE(hsa_agent_iterate_caches, handle);
	HANDLE(hsa_agent_extension_supported, handle);
	HANDLE(hsa_agent_major_extension_supported, handle);
	HANDLE(hsa_queue_create, handle);
	HANDLE(hsa_soft_queue_create, handle);
	HANDLE(hsa_queue_destroy, handle);
	HANDLE(hsa_queue_inactivate, handle);
	HANDLE(hsa_queue_load_read_index_scacquire, handle);
	HANDLE(hsa_queue_load_read_index_relaxed, handle);
	HANDLE(hsa_queue_load_write_index_scacquire, handle);
	HANDLE(hsa_queue_load_write_index_relaxed, handle);
	HANDLE(hsa_queue_store_write_index_relaxed, handle);
	HANDLE(hsa_queue_store_write_index_screlease, handle);
	HANDLE(hsa_queue_cas_write_index_scacq_screl, handle);
	HANDLE(hsa_queue_cas_write_index_scacquire, handle);
	HANDLE(hsa_queue_cas_write_index_relaxed, handle);
	HANDLE(hsa_queue_cas_write_index_screlease, handle);
	HANDLE(hsa_queue_add_write_index_scacq_screl, handle);
	HANDLE(hsa_queue_add_write_index_scacquire, handle);
	HANDLE(hsa_queue_add_write_index_relaxed, handle);
	HANDLE(hsa_queue_add_write_index_screlease, handle);
	HANDLE(hsa_queue_store_read_index_relaxed, handle);
	HANDLE(hsa_queue_store_read_index_screlease, handle);
	HANDLE(hsa_agent_iterate_regions, handle);
	HANDLE(hsa_region_get_info, handle);
	HANDLE(hsa_memory_register, handle);
	HANDLE(hsa_memory_deregister, handle);
	HANDLE(hsa_memory_allocate, handle);
	HANDLE(hsa_memory_free, handle);
	HANDLE(hsa_memory_copy, handle);
	HANDLE(hsa_memory_assign_agent, handle);
	HANDLE(hsa_signal_create, handle);
	HANDLE(hsa_signal_destroy, handle);
	HANDLE(hsa_signal_load_relaxed, handle);
	HANDLE(hsa_signal_load_scacquire, handle);
	HANDLE(hsa_signal_store_relaxed, handle);
	HANDLE(hsa_signal_store_screlease, handle);
	HANDLE(hsa_signal_silent_store_relaxed, handle);
	HANDLE(hsa_signal_silent_store_screlease, handle);
	HANDLE(hsa_signal_wait_relaxed, handle);
	HANDLE(hsa_signal_wait_scacquire, handle);
	HANDLE(hsa_signal_group_create, handle);
	HANDLE(hsa_signal_group_destroy, handle);
	HANDLE(hsa_signal_group_wait_any_scacquire, handle);
	HANDLE(hsa_signal_group_wait_any_relaxed, handle);
	HANDLE(hsa_signal_and_relaxed, handle);
	HANDLE(hsa_signal_and_scacquire, handle);
	HANDLE(hsa_signal_and_screlease, handle);
	HANDLE(hsa_signal_and_scacq_screl, handle);
	HANDLE(hsa_signal_or_relaxed, handle);
	HANDLE(hsa_signal_or_scacquire, handle);
	HANDLE(hsa_signal_or_screlease, handle);
	HANDLE(hsa_signal_or_scacq_screl, handle);
	HANDLE(hsa_signal_xor_relaxed, handle);
	HANDLE(hsa_signal_xor_scacquire, handle);
	HANDLE(hsa_signal_xor_screlease, handle);
	HANDLE(hsa_signal_xor_scacq_screl, handle);
	HANDLE(hsa_signal_add_relaxed, handle);
	HANDLE(hsa_signal_add_scacquire, handle);
	HANDLE(hsa_signal_add_screlease, handle);
	HANDLE(hsa_signal_add_scacq_screl, handle);
	HANDLE(hsa_signal_subtract_relaxed, handle);
	HANDLE(hsa_signal_subtract_scacquire, handle);
	HANDLE(hsa_signal_subtract_screlease, handle);
	HANDLE(hsa_signal_subtract_scacq_screl, handle);
	HANDLE(hsa_signal_exchange_relaxed, handle);
	HANDLE(hsa_signal_exchange_scacquire, handle);
	HANDLE(hsa_signal_exchange_screlease, handle);
	HANDLE(hsa_signal_exchange_scacq_screl, handle);
	HANDLE(hsa_signal_cas_relaxed, handle);
	HANDLE(hsa_signal_cas_scacquire, handle);
	HANDLE(hsa_signal_cas_screlease, handle);
	HANDLE(hsa_signal_cas_scacq_screl, handle);
	HANDLE(hsa_isa_from_name, handle);
	HANDLE(hsa_agent_iterate_isas, handle);
	HANDLE(hsa_isa_get_info, handle);
	HANDLE(hsa_isa_get_info_alt, handle);
	HANDLE(hsa_isa_get_exception_policies, handle);
	HANDLE(hsa_isa_get_round_method, handle);
	HANDLE(hsa_wavefront_get_info, handle);
	HANDLE(hsa_isa_iterate_wavefronts, handle);
	HANDLE(hsa_isa_compatible, handle);
	HANDLE(hsa_code_object_serialize, handle);
	HANDLE(hsa_code_object_deserialize, handle);
	HANDLE(hsa_code_object_destroy, handle);
	HANDLE(hsa_code_object_get_info, handle);
	HANDLE(hsa_code_object_get_symbol, handle);
	HANDLE(hsa_code_object_get_symbol_from_name, handle);
	HANDLE(hsa_code_symbol_get_info, handle);
	HANDLE(hsa_code_object_iterate_symbols, handle);
	HANDLE(hsa_code_object_reader_create_from_file, handle);
	HANDLE(hsa_code_object_reader_create_from_memory, handle);
	HANDLE(hsa_code_object_reader_destroy, handle);
	HANDLE(hsa_executable_create, handle);
	HANDLE(hsa_executable_create_alt, handle);
	HANDLE(hsa_executable_destroy, handle);
	HANDLE(hsa_executable_load_code_object, handle);
	HANDLE(hsa_executable_load_program_code_object, handle);
	HANDLE(hsa_executable_load_agent_code_object, handle);
	HANDLE(hsa_executable_freeze, handle);
	HANDLE(hsa_executable_get_info, handle);
	HANDLE(hsa_executable_global_variable_define, handle);
	HANDLE(hsa_executable_agent_global_variable_define, handle);
	HANDLE(hsa_executable_readonly_variable_define, handle);
	HANDLE(hsa_executable_validate, handle);
	HANDLE(hsa_executable_validate_alt, handle);
	HANDLE(hsa_executable_get_symbol, handle);
	HANDLE(hsa_executable_get_symbol_by_name, handle);
	HANDLE(hsa_executable_symbol_get_info, handle);
	HANDLE(hsa_executable_iterate_symbols, handle);
	HANDLE(hsa_executable_iterate_agent_symbols, handle);
	HANDLE(hsa_executable_iterate_program_symbols, handle);
	HANDLE(hsa_status_string, handle);
	HANDLE(hsa_amd_profiling_get_dispatch_time, handle);
	HANDLE(hsa_amd_memory_async_copy, handle);

};


hsa_status_t hsa_amd_profiling_get_dispatch_time(
    hsa_agent_t agent, hsa_signal_t signal,
    hsa_amd_profiling_dispatch_time_t* time)
	{
		callback_function(1, "hsa_amd_profiling_get_dispatch_time");
		hsa_status_t ret = itcp_table.fn_hsa_amd_profiling_get_dispatch_time(agent, signal, time);
		callback_function(0, "hsa_amd_profiling_get_dispatch_time");
		// printf("%lu\n", time->end - time->start);
		return ret;
	}

hsa_status_t hsa_amd_memory_async_copy(void* dst, hsa_agent_t dst_agent, const void* src,
                              hsa_agent_t src_agent, size_t size,
                              uint32_t num_dep_signals,
                              const hsa_signal_t* dep_signals,
                              hsa_signal_t completion_signal) {
		callback_function(1, "hsa_amd_memory_async_copy");
		hsa_status_t ret = itcp_table.fn_hsa_amd_memory_async_copy(dst, dst_agent, src,
                              src_agent, size,
                              num_dep_signals,
                              dep_signals,
                              completion_signal);
		callback_function(0, "hsa_amd_memory_async_copy");
		return ret;
	}


hsa_status_t hsa_shut_down() {
	callback_function(1, "hsa_shut_down");
	hsa_status_t ret = itcp_table.fn_hsa_shut_down();
	callback_function(0, "hsa_shut_down");
	return ret;
}

hsa_status_t hsa_init() {
	load_itcp_table();
	callback_function(1, "hsa_init");
	hsa_status_t ret = itcp_table.fn_hsa_init();
	callback_function(0, "hsa_init");
	return ret;
}

hsa_status_t hsa_system_get_info(hsa_system_info_t attribute,  void *value) {
	callback_function(1, "hsa_system_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_system_get_info(attribute, value);
	callback_function(0, "hsa_system_get_info");
	return ret;
}

hsa_status_t hsa_extension_get_name(uint16_t extension,  const char** name) {
	callback_function(1, "hsa_extension_get_name");
	hsa_status_t ret = itcp_table.fn_hsa_extension_get_name(extension, name);
	callback_function(0, "hsa_extension_get_name");
	return ret;
}

hsa_status_t hsa_system_extension_supported(uint16_t extension,  uint16_t version_major,  uint16_t version_minor,  bool* result) {
	callback_function(1, "hsa_system_extension_supported");
	hsa_status_t ret = itcp_table.fn_hsa_system_extension_supported(extension, version_major, version_minor, result);
	callback_function(0, "hsa_system_extension_supported");
	return ret;
}

hsa_status_t hsa_system_major_extension_supported(uint16_t extension,  uint16_t version_major,  uint16_t* version_minor,  bool* result) {
	callback_function(1, "hsa_system_major_extension_supported");
	hsa_status_t ret = itcp_table.fn_hsa_system_major_extension_supported(extension, version_major, version_minor, result);
	callback_function(0, "hsa_system_major_extension_supported");
	return ret;
}

hsa_status_t hsa_system_get_extension_table(uint16_t extension,  uint16_t version_major,  uint16_t version_minor,  void *table) {
	callback_function(1, "hsa_system_get_extension_table");
	hsa_status_t ret = itcp_table.fn_hsa_system_get_extension_table(extension, version_major, version_minor, table);
	callback_function(0, "hsa_system_get_extension_table");
	return ret;
}

hsa_status_t hsa_system_get_major_extension_table(uint16_t extension,  uint16_t version_major,  size_t table_length,  void* table) {
	callback_function(1, "hsa_system_get_major_extension_table");
	hsa_status_t ret = itcp_table.fn_hsa_system_get_major_extension_table(extension, version_major, table_length, table);
	callback_function(0, "hsa_system_get_major_extension_table");
	return ret;
}

hsa_status_t hsa_iterate_agents(hsa_status_t (*callback)(hsa_agent_t agent, void *data),  void *data) {
	callback_function(1, "hsa_iterate_agents");
	hsa_status_t ret = itcp_table.fn_hsa_iterate_agents(callback, data);
	callback_function(0, "hsa_iterate_agents");
	return ret;
}

hsa_status_t hsa_agent_get_info(hsa_agent_t agent,  hsa_agent_info_t attribute,  void *value) {
	callback_function(1, "hsa_agent_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_agent_get_info(agent, attribute, value);
	callback_function(0, "hsa_agent_get_info");
	return ret;
}

hsa_status_t hsa_agent_get_exception_policies(hsa_agent_t agent,  hsa_profile_t profile,  uint16_t *mask) {
	callback_function(1, "hsa_agent_get_exception_policies");
	hsa_status_t ret = itcp_table.fn_hsa_agent_get_exception_policies(agent, profile, mask);
	callback_function(0, "hsa_agent_get_exception_policies");
	return ret;
}

hsa_status_t hsa_cache_get_info(hsa_cache_t cache,  hsa_cache_info_t attribute,  void* value) {
	callback_function(1, "hsa_cache_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_cache_get_info(cache, attribute, value);
	callback_function(0, "hsa_cache_get_info");
	return ret;
}

hsa_status_t hsa_agent_iterate_caches( hsa_agent_t agent,  hsa_status_t (*callback)(hsa_cache_t cache, void* data),  void* value) {
	callback_function(1, "hsa_agent_iterate_caches");
	hsa_status_t ret = itcp_table.fn_hsa_agent_iterate_caches(agent, callback, value);
	callback_function(0, "hsa_agent_iterate_caches");
	return ret;
}

hsa_status_t hsa_agent_extension_supported(uint16_t extension,  hsa_agent_t agent,  uint16_t version_major,  uint16_t version_minor,  bool *result) {
	callback_function(1, "hsa_agent_extension_supported");
	hsa_status_t ret = itcp_table.fn_hsa_agent_extension_supported(extension, agent, version_major, version_minor, result);
	callback_function(0, "hsa_agent_extension_supported");
	return ret;
}

hsa_status_t hsa_agent_major_extension_supported(uint16_t extension,  hsa_agent_t agent,  uint16_t version_major,  uint16_t* version_minor,  bool* result) {
	callback_function(1, "hsa_agent_major_extension_supported");
	hsa_status_t ret = itcp_table.fn_hsa_agent_major_extension_supported(extension, agent, version_major, version_minor, result);
	callback_function(0, "hsa_agent_major_extension_supported");
	return ret;
}

hsa_status_t hsa_queue_create(hsa_agent_t agent,  uint32_t size,  hsa_queue_type32_t type,  void (*callback)(hsa_status_t status, hsa_queue_t *source, void *data),  void *data,  uint32_t private_segment_size,  uint32_t group_segment_size,  hsa_queue_t **queue) {
	callback_function(1, "hsa_queue_create");
	hsa_status_t ret = itcp_table.fn_hsa_queue_create(agent, size, type, callback, data, private_segment_size, group_segment_size, queue);
	callback_function(0, "hsa_queue_create");
	return ret;
}

hsa_status_t hsa_soft_queue_create(hsa_region_t region,  uint32_t size,  hsa_queue_type32_t type,  uint32_t features,  hsa_signal_t completion_signal,  hsa_queue_t **queue) {
	callback_function(1, "hsa_soft_queue_create");
	hsa_status_t ret = itcp_table.fn_hsa_soft_queue_create(region, size, type, features, completion_signal, queue);
	callback_function(0, "hsa_soft_queue_create");
	return ret;
}

hsa_status_t hsa_queue_destroy(hsa_queue_t *queue) {
	callback_function(1, "hsa_queue_destroy");
	hsa_status_t ret = itcp_table.fn_hsa_queue_destroy(queue);
	callback_function(0, "hsa_queue_destroy");
	return ret;
}

hsa_status_t hsa_queue_inactivate(hsa_queue_t *queue) {
	callback_function(1, "hsa_queue_inactivate");
	hsa_status_t ret = itcp_table.fn_hsa_queue_inactivate(queue);
	callback_function(0, "hsa_queue_inactivate");
	return ret;
}

uint64_t hsa_queue_load_read_index_scacquire(const hsa_queue_t* queue) {
	callback_function(1, "hsa_queue_load_read_index_scacquire");
	uint64_t ret = itcp_table.fn_hsa_queue_load_read_index_scacquire(queue);
	callback_function(0, "hsa_queue_load_read_index_scacquire");
	return ret;
}

uint64_t hsa_queue_load_read_index_relaxed(const hsa_queue_t *queue) {
	callback_function(1, "hsa_queue_load_read_index_relaxed");
	uint64_t ret = itcp_table.fn_hsa_queue_load_read_index_relaxed(queue);
	callback_function(0, "hsa_queue_load_read_index_relaxed");
	return ret;
}

uint64_t hsa_queue_load_write_index_scacquire(const hsa_queue_t* queue) {
	callback_function(1, "hsa_queue_load_write_index_scacquire");
	uint64_t ret = itcp_table.fn_hsa_queue_load_write_index_scacquire(queue);
	callback_function(0, "hsa_queue_load_write_index_scacquire");
	return ret;
}

uint64_t hsa_queue_load_write_index_relaxed(const hsa_queue_t *queue) {
	callback_function(1, "hsa_queue_load_write_index_relaxed");
	uint64_t ret = itcp_table.fn_hsa_queue_load_write_index_relaxed(queue);
	callback_function(0, "hsa_queue_load_write_index_relaxed");
	return ret;
}

void hsa_queue_store_write_index_relaxed(const hsa_queue_t *queue,  uint64_t value) {
	callback_function(1, "hsa_queue_store_write_index_relaxed");
	itcp_table.fn_hsa_queue_store_write_index_relaxed(queue, value);
	callback_function(0, "hsa_queue_store_write_index_relaxed");
	return;
}

void hsa_queue_store_write_index_screlease(const hsa_queue_t* queue,  uint64_t value) {
	callback_function(1, "hsa_queue_store_write_index_screlease");
	itcp_table.fn_hsa_queue_store_write_index_screlease(queue, value);
	callback_function(0, "hsa_queue_store_write_index_screlease");
	return;
}

uint64_t hsa_queue_cas_write_index_scacq_screl(const hsa_queue_t* queue,  uint64_t expected,  uint64_t value) {
	callback_function(1, "hsa_queue_cas_write_index_scacq_screl");
	uint64_t ret = itcp_table.fn_hsa_queue_cas_write_index_scacq_screl(queue, expected, value);
	callback_function(0, "hsa_queue_cas_write_index_scacq_screl");
	return ret;
}

uint64_t hsa_queue_cas_write_index_scacquire(const hsa_queue_t* queue,  uint64_t expected,  uint64_t value) {
	callback_function(1, "hsa_queue_cas_write_index_scacquire");
	uint64_t ret = itcp_table.fn_hsa_queue_cas_write_index_scacquire(queue, expected, value);
	callback_function(0, "hsa_queue_cas_write_index_scacquire");
	return ret;
}

uint64_t hsa_queue_cas_write_index_relaxed(const hsa_queue_t *queue,  uint64_t expected,  uint64_t value) {
	callback_function(1, "hsa_queue_cas_write_index_relaxed");
	uint64_t ret = itcp_table.fn_hsa_queue_cas_write_index_relaxed(queue, expected, value);
	callback_function(0, "hsa_queue_cas_write_index_relaxed");
	return ret;
}

uint64_t hsa_queue_cas_write_index_screlease(const hsa_queue_t* queue,  uint64_t expected,  uint64_t value) {
	callback_function(1, "hsa_queue_cas_write_index_screlease");
	uint64_t ret = itcp_table.fn_hsa_queue_cas_write_index_screlease(queue, expected, value);
	callback_function(0, "hsa_queue_cas_write_index_screlease");
	return ret;
}

uint64_t hsa_queue_add_write_index_scacq_screl(const hsa_queue_t* queue,  uint64_t value) {
	callback_function(1, "hsa_queue_add_write_index_scacq_screl");
	uint64_t ret = itcp_table.fn_hsa_queue_add_write_index_scacq_screl(queue, value);
	callback_function(0, "hsa_queue_add_write_index_scacq_screl");
	return ret;
}

uint64_t hsa_queue_add_write_index_scacquire(const hsa_queue_t* queue,  uint64_t value) {
	callback_function(1, "hsa_queue_add_write_index_scacquire");
	uint64_t ret = itcp_table.fn_hsa_queue_add_write_index_scacquire(queue, value);
	callback_function(0, "hsa_queue_add_write_index_scacquire");
	return ret;
}

uint64_t hsa_queue_add_write_index_relaxed(const hsa_queue_t *queue,  uint64_t value) {
	callback_function(1, "hsa_queue_add_write_index_relaxed");
	uint64_t ret = itcp_table.fn_hsa_queue_add_write_index_relaxed(queue, value);
	callback_function(0, "hsa_queue_add_write_index_relaxed");
	return ret;
}

uint64_t hsa_queue_add_write_index_screlease(const hsa_queue_t* queue,  uint64_t value) {
	callback_function(1, "hsa_queue_add_write_index_screlease");
	uint64_t ret = itcp_table.fn_hsa_queue_add_write_index_screlease(queue, value);
	callback_function(0, "hsa_queue_add_write_index_screlease");
	return ret;
}

void hsa_queue_store_read_index_relaxed(const hsa_queue_t *queue,  uint64_t value) {
	callback_function(1, "hsa_queue_store_read_index_relaxed");
	itcp_table.fn_hsa_queue_store_read_index_relaxed(queue, value);
	callback_function(0, "hsa_queue_store_read_index_relaxed");
	return;
}

void hsa_queue_store_read_index_screlease(const hsa_queue_t* queue,  uint64_t value) {
	callback_function(1, "hsa_queue_store_read_index_screlease");
	itcp_table.fn_hsa_queue_store_read_index_screlease(queue, value);
	callback_function(0, "hsa_queue_store_read_index_screlease");
	return;
}

hsa_status_t hsa_agent_iterate_regions( hsa_agent_t agent,  hsa_status_t (*callback)(hsa_region_t region, void *data),  void *data) {
	callback_function(1, "hsa_agent_iterate_regions");
	hsa_status_t ret = itcp_table.fn_hsa_agent_iterate_regions(agent, callback, data);
	callback_function(0, "hsa_agent_iterate_regions");
	return ret;
}

hsa_status_t hsa_region_get_info(hsa_region_t region,  hsa_region_info_t attribute,  void *value) {
	callback_function(1, "hsa_region_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_region_get_info(region, attribute, value);
	callback_function(0, "hsa_region_get_info");
	return ret;
}

hsa_status_t hsa_memory_register(void *address,  size_t size) {
	callback_function(1, "hsa_memory_register");
	hsa_status_t ret = itcp_table.fn_hsa_memory_register(address, size);
	callback_function(0, "hsa_memory_register");
	return ret;
}

hsa_status_t hsa_memory_deregister(void *address,  size_t size) {
	callback_function(1, "hsa_memory_deregister");
	hsa_status_t ret = itcp_table.fn_hsa_memory_deregister(address, size);
	callback_function(0, "hsa_memory_deregister");
	return ret;
}

hsa_status_t hsa_memory_allocate(hsa_region_t region,  size_t size,  void **ptr) {
	callback_function(1, "hsa_memory_allocate");
	hsa_status_t ret = itcp_table.fn_hsa_memory_allocate(region, size, ptr);
	callback_function(0, "hsa_memory_allocate");
	return ret;
}

hsa_status_t hsa_memory_free(void *ptr) {
	callback_function(1, "hsa_memory_free");
	hsa_status_t ret = itcp_table.fn_hsa_memory_free(ptr);
	callback_function(0, "hsa_memory_free");
	return ret;
}

hsa_status_t hsa_memory_copy(void *dst,  const void *src,  size_t size) {
	callback_function(1, "hsa_memory_copy");
	hsa_status_t ret = itcp_table.fn_hsa_memory_copy(dst, src, size);
	callback_function(0, "hsa_memory_copy");
	return ret;
}

hsa_status_t hsa_memory_assign_agent(void *ptr,  hsa_agent_t agent,  hsa_access_permission_t access) {
	callback_function(1, "hsa_memory_assign_agent");
	hsa_status_t ret = itcp_table.fn_hsa_memory_assign_agent(ptr, agent, access);
	callback_function(0, "hsa_memory_assign_agent");
	return ret;
}

hsa_status_t hsa_signal_create(hsa_signal_value_t initial_value,  uint32_t num_consumers,  const hsa_agent_t *consumers,  hsa_signal_t *signal) {
	callback_function(1, "hsa_signal_create");
	hsa_status_t ret = itcp_table.fn_hsa_signal_create(initial_value, num_consumers, consumers, signal);
	callback_function(0, "hsa_signal_create");
	return ret;
}

hsa_status_t hsa_signal_destroy(hsa_signal_t signal) {
	callback_function(1, "hsa_signal_destroy");
	hsa_status_t ret = itcp_table.fn_hsa_signal_destroy(signal);
	callback_function(0, "hsa_signal_destroy");
	return ret;
}

hsa_signal_value_t hsa_signal_load_relaxed(hsa_signal_t signal) {
	callback_function(1, "hsa_signal_load_relaxed");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_load_relaxed(signal);
	callback_function(0, "hsa_signal_load_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_load_scacquire(hsa_signal_t signal) {
	callback_function(1, "hsa_signal_load_scacquire");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_load_scacquire(signal);
	callback_function(0, "hsa_signal_load_scacquire");
	return ret;
}

void hsa_signal_store_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_store_relaxed");
	itcp_table.fn_hsa_signal_store_relaxed(signal, value);
	callback_function(0, "hsa_signal_store_relaxed");
	return;
}

void hsa_signal_store_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_store_screlease");
	itcp_table.fn_hsa_signal_store_screlease(signal, value);
	callback_function(0, "hsa_signal_store_screlease");
	return;
}

void hsa_signal_silent_store_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_silent_store_relaxed");
	itcp_table.fn_hsa_signal_silent_store_relaxed(signal, value);
	callback_function(0, "hsa_signal_silent_store_relaxed");
	return;
}

void hsa_signal_silent_store_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_silent_store_screlease");
	itcp_table.fn_hsa_signal_silent_store_screlease(signal, value);
	callback_function(0, "hsa_signal_silent_store_screlease");
	return;
}

hsa_signal_value_t hsa_signal_wait_relaxed(hsa_signal_t signal,  hsa_signal_condition_t condition,  hsa_signal_value_t compare_value,  uint64_t timeout_hint,  hsa_wait_state_t wait_expectancy_hint) {
	callback_function(1, "hsa_signal_wait_relaxed");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_wait_relaxed(signal, condition, compare_value, timeout_hint, wait_expectancy_hint);
	callback_function(0, "hsa_signal_wait_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_wait_scacquire(hsa_signal_t signal,  hsa_signal_condition_t condition,  hsa_signal_value_t compare_value,  uint64_t timeout_hint,  hsa_wait_state_t wait_expectancy_hint) {
	callback_function(1, "hsa_signal_wait_scacquire");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_wait_scacquire(signal, condition, compare_value, timeout_hint, wait_expectancy_hint);
	callback_function(0, "hsa_signal_wait_scacquire");
	return ret;
}

hsa_status_t hsa_signal_group_create(uint32_t num_signals,  const hsa_signal_t* signals,  uint32_t num_consumers,  const hsa_agent_t* consumers,  hsa_signal_group_t* signal_group) {
	callback_function(1, "hsa_signal_group_create");
	hsa_status_t ret = itcp_table.fn_hsa_signal_group_create(num_signals, signals, num_consumers, consumers, signal_group);
	callback_function(0, "hsa_signal_group_create");
	return ret;
}

hsa_status_t hsa_signal_group_destroy(hsa_signal_group_t signal_group) {
	callback_function(1, "hsa_signal_group_destroy");
	hsa_status_t ret = itcp_table.fn_hsa_signal_group_destroy(signal_group);
	callback_function(0, "hsa_signal_group_destroy");
	return ret;
}

hsa_status_t hsa_signal_group_wait_any_scacquire(hsa_signal_group_t signal_group,  const hsa_signal_condition_t* conditions,  const hsa_signal_value_t* compare_values,  hsa_wait_state_t wait_state_hint,  hsa_signal_t* signal,  hsa_signal_value_t* value) {
	callback_function(1, "hsa_signal_group_wait_any_scacquire");
	hsa_status_t ret = itcp_table.fn_hsa_signal_group_wait_any_scacquire(signal_group, conditions, compare_values, wait_state_hint, signal, value);
	callback_function(0, "hsa_signal_group_wait_any_scacquire");
	return ret;
}

hsa_status_t hsa_signal_group_wait_any_relaxed(hsa_signal_group_t signal_group,  const hsa_signal_condition_t* conditions,  const hsa_signal_value_t* compare_values,  hsa_wait_state_t wait_state_hint,  hsa_signal_t* signal,  hsa_signal_value_t* value) {
	callback_function(1, "hsa_signal_group_wait_any_relaxed");
	hsa_status_t ret = itcp_table.fn_hsa_signal_group_wait_any_relaxed(signal_group, conditions, compare_values, wait_state_hint, signal, value);
	callback_function(0, "hsa_signal_group_wait_any_relaxed");
	return ret;
}

void hsa_signal_and_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_and_relaxed");
	itcp_table.fn_hsa_signal_and_relaxed(signal, value);
	callback_function(0, "hsa_signal_and_relaxed");
	return;
}

void hsa_signal_and_scacquire(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_and_scacquire");
	itcp_table.fn_hsa_signal_and_scacquire(signal, value);
	callback_function(0, "hsa_signal_and_scacquire");
	return;
}

void hsa_signal_and_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_and_screlease");
	itcp_table.fn_hsa_signal_and_screlease(signal, value);
	callback_function(0, "hsa_signal_and_screlease");
	return;
}

void hsa_signal_and_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_and_scacq_screl");
	itcp_table.fn_hsa_signal_and_scacq_screl(signal, value);
	callback_function(0, "hsa_signal_and_scacq_screl");
	return;
}

void hsa_signal_or_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_or_relaxed");
	itcp_table.fn_hsa_signal_or_relaxed(signal, value);
	callback_function(0, "hsa_signal_or_relaxed");
	return;
}

void hsa_signal_or_scacquire(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_or_scacquire");
	itcp_table.fn_hsa_signal_or_scacquire(signal, value);
	callback_function(0, "hsa_signal_or_scacquire");
	return;
}

void hsa_signal_or_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_or_screlease");
	itcp_table.fn_hsa_signal_or_screlease(signal, value);
	callback_function(0, "hsa_signal_or_screlease");
	return;
}

void hsa_signal_or_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_or_scacq_screl");
	itcp_table.fn_hsa_signal_or_scacq_screl(signal, value);
	callback_function(0, "hsa_signal_or_scacq_screl");
	return;
}

void hsa_signal_xor_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_xor_relaxed");
	itcp_table.fn_hsa_signal_xor_relaxed(signal, value);
	callback_function(0, "hsa_signal_xor_relaxed");
	return;
}

void hsa_signal_xor_scacquire(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_xor_scacquire");
	itcp_table.fn_hsa_signal_xor_scacquire(signal, value);
	callback_function(0, "hsa_signal_xor_scacquire");
	return;
}

void hsa_signal_xor_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_xor_screlease");
	itcp_table.fn_hsa_signal_xor_screlease(signal, value);
	callback_function(0, "hsa_signal_xor_screlease");
	return;
}

void hsa_signal_xor_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_xor_scacq_screl");
	itcp_table.fn_hsa_signal_xor_scacq_screl(signal, value);
	callback_function(0, "hsa_signal_xor_scacq_screl");
	return;
}

void hsa_signal_add_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_add_relaxed");
	itcp_table.fn_hsa_signal_add_relaxed(signal, value);
	callback_function(0, "hsa_signal_add_relaxed");
	return;
}

void hsa_signal_add_scacquire(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_add_scacquire");
	itcp_table.fn_hsa_signal_add_scacquire(signal, value);
	callback_function(0, "hsa_signal_add_scacquire");
	return;
}

void hsa_signal_add_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_add_screlease");
	itcp_table.fn_hsa_signal_add_screlease(signal, value);
	callback_function(0, "hsa_signal_add_screlease");
	return;
}

void hsa_signal_add_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_add_scacq_screl");
	itcp_table.fn_hsa_signal_add_scacq_screl(signal, value);
	callback_function(0, "hsa_signal_add_scacq_screl");
	return;
}

void hsa_signal_subtract_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_subtract_relaxed");
	itcp_table.fn_hsa_signal_subtract_relaxed(signal, value);
	callback_function(0, "hsa_signal_subtract_relaxed");
	return;
}

void hsa_signal_subtract_scacquire(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_subtract_scacquire");
	itcp_table.fn_hsa_signal_subtract_scacquire(signal, value);
	callback_function(0, "hsa_signal_subtract_scacquire");
	return;
}

void hsa_signal_subtract_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_subtract_screlease");
	itcp_table.fn_hsa_signal_subtract_screlease(signal, value);
	callback_function(0, "hsa_signal_subtract_screlease");
	return;
}

void hsa_signal_subtract_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_subtract_scacq_screl");
	itcp_table.fn_hsa_signal_subtract_scacq_screl(signal, value);
	callback_function(0, "hsa_signal_subtract_scacq_screl");
	return;
}

hsa_signal_value_t hsa_signal_exchange_relaxed(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_exchange_relaxed");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_exchange_relaxed(signal, value);
	callback_function(0, "hsa_signal_exchange_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_scacquire(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_exchange_scacquire");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_exchange_scacquire(signal, value);
	callback_function(0, "hsa_signal_exchange_scacquire");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_screlease(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_exchange_screlease");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_exchange_screlease(signal, value);
	callback_function(0, "hsa_signal_exchange_screlease");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_exchange_scacq_screl");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_exchange_scacq_screl(signal, value);
	callback_function(0, "hsa_signal_exchange_scacq_screl");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_relaxed(hsa_signal_t signal,  hsa_signal_value_t expected,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_cas_relaxed");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_cas_relaxed(signal, expected, value);
	callback_function(0, "hsa_signal_cas_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_scacquire(hsa_signal_t signal,  hsa_signal_value_t expected,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_cas_scacquire");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_cas_scacquire(signal, expected, value);
	callback_function(0, "hsa_signal_cas_scacquire");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_screlease(hsa_signal_t signal,  hsa_signal_value_t expected,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_cas_screlease");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_cas_screlease(signal, expected, value);
	callback_function(0, "hsa_signal_cas_screlease");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_scacq_screl(hsa_signal_t signal,  hsa_signal_value_t expected,  hsa_signal_value_t value) {
	callback_function(1, "hsa_signal_cas_scacq_screl");
	hsa_signal_value_t ret = itcp_table.fn_hsa_signal_cas_scacq_screl(signal, expected, value);
	callback_function(0, "hsa_signal_cas_scacq_screl");
	return ret;
}

hsa_status_t hsa_isa_from_name( const char *name,  hsa_isa_t *isa) {
	callback_function(1, "hsa_isa_from_name");
	hsa_status_t ret = itcp_table.fn_hsa_isa_from_name(name, isa);
	callback_function(0, "hsa_isa_from_name");
	return ret;
}

hsa_status_t hsa_agent_iterate_isas( hsa_agent_t agent,  hsa_status_t (*callback)(hsa_isa_t isa, void *data),  void *data) {
	callback_function(1, "hsa_agent_iterate_isas");
	hsa_status_t ret = itcp_table.fn_hsa_agent_iterate_isas(agent, callback, data);
	callback_function(0, "hsa_agent_iterate_isas");
	return ret;
}

/* deprecated */ hsa_status_t hsa_isa_get_info( hsa_isa_t isa,  hsa_isa_info_t attribute,  uint32_t index,  void *value) {
	callback_function(1, "hsa_isa_get_info");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_isa_get_info(isa, attribute, index, value);
	callback_function(0, "hsa_isa_get_info");
	return ret;
}

hsa_status_t hsa_isa_get_info_alt( hsa_isa_t isa,  hsa_isa_info_t attribute,  void *value) {
	callback_function(1, "hsa_isa_get_info_alt");
	hsa_status_t ret = itcp_table.fn_hsa_isa_get_info_alt(isa, attribute, value);
	callback_function(0, "hsa_isa_get_info_alt");
	return ret;
}

hsa_status_t hsa_isa_get_exception_policies( hsa_isa_t isa,  hsa_profile_t profile,  uint16_t *mask) {
	callback_function(1, "hsa_isa_get_exception_policies");
	hsa_status_t ret = itcp_table.fn_hsa_isa_get_exception_policies(isa, profile, mask);
	callback_function(0, "hsa_isa_get_exception_policies");
	return ret;
}

hsa_status_t hsa_isa_get_round_method( hsa_isa_t isa,  hsa_fp_type_t fp_type,  hsa_flush_mode_t flush_mode,  hsa_round_method_t *round_method) {
	callback_function(1, "hsa_isa_get_round_method");
	hsa_status_t ret = itcp_table.fn_hsa_isa_get_round_method(isa, fp_type, flush_mode, round_method);
	callback_function(0, "hsa_isa_get_round_method");
	return ret;
}

hsa_status_t hsa_wavefront_get_info( hsa_wavefront_t wavefront,  hsa_wavefront_info_t attribute,  void *value) {
	callback_function(1, "hsa_wavefront_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_wavefront_get_info(wavefront, attribute, value);
	callback_function(0, "hsa_wavefront_get_info");
	return ret;
}

hsa_status_t hsa_isa_iterate_wavefronts( hsa_isa_t isa,  hsa_status_t (*callback)(hsa_wavefront_t wavefront, void *data),  void *data) {
	callback_function(1, "hsa_isa_iterate_wavefronts");
	hsa_status_t ret = itcp_table.fn_hsa_isa_iterate_wavefronts(isa, callback, data);
	callback_function(0, "hsa_isa_iterate_wavefronts");
	return ret;
}

/* deprecated */ hsa_status_t hsa_isa_compatible( hsa_isa_t code_object_isa,  hsa_isa_t agent_isa,  bool *result) {
	callback_function(1, "hsa_isa_compatible");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_isa_compatible(code_object_isa, agent_isa, result);
	callback_function(0, "hsa_isa_compatible");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_serialize( hsa_code_object_t code_object,  hsa_status_t (*alloc_callback)(size_t size, hsa_callback_data_t data, void **address),  hsa_callback_data_t callback_data,  const char *options,  void **serialized_code_object,  size_t *serialized_code_object_size) {
	callback_function(1, "hsa_code_object_serialize");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_serialize(code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size);
	callback_function(0, "hsa_code_object_serialize");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_deserialize( void *serialized_code_object,  size_t serialized_code_object_size,  const char *options,  hsa_code_object_t *code_object) {
	callback_function(1, "hsa_code_object_deserialize");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_deserialize(serialized_code_object, serialized_code_object_size, options, code_object);
	callback_function(0, "hsa_code_object_deserialize");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_destroy( hsa_code_object_t code_object) {
	callback_function(1, "hsa_code_object_destroy");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_destroy(code_object);
	callback_function(0, "hsa_code_object_destroy");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_get_info( hsa_code_object_t code_object,  hsa_code_object_info_t attribute,  void *value) {
	callback_function(1, "hsa_code_object_get_info");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_get_info(code_object, attribute, value);
	callback_function(0, "hsa_code_object_get_info");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_get_symbol( hsa_code_object_t code_object,  const char *symbol_name,  hsa_code_symbol_t *symbol) {
	callback_function(1, "hsa_code_object_get_symbol");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_get_symbol(code_object, symbol_name, symbol);
	callback_function(0, "hsa_code_object_get_symbol");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_get_symbol_from_name( hsa_code_object_t code_object,  const char *module_name,  const char *symbol_name,  hsa_code_symbol_t *symbol) {
	callback_function(1, "hsa_code_object_get_symbol_from_name");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_get_symbol_from_name(code_object, module_name, symbol_name, symbol);
	callback_function(0, "hsa_code_object_get_symbol_from_name");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_symbol_get_info( hsa_code_symbol_t code_symbol,  hsa_code_symbol_info_t attribute,  void *value) {
	callback_function(1, "hsa_code_symbol_get_info");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_symbol_get_info(code_symbol, attribute, value);
	callback_function(0, "hsa_code_symbol_get_info");
	return ret;
}

/* deprecated */ hsa_status_t hsa_code_object_iterate_symbols( hsa_code_object_t code_object,  hsa_status_t (*callback)(hsa_code_object_t code_object, hsa_code_symbol_t symbol, void *data),  void *data) {
	callback_function(1, "hsa_code_object_iterate_symbols");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_code_object_iterate_symbols(code_object, callback, data);
	callback_function(0, "hsa_code_object_iterate_symbols");
	return ret;
}

hsa_status_t hsa_code_object_reader_create_from_file( hsa_file_t file,  hsa_code_object_reader_t *code_object_reader) {
	callback_function(1, "hsa_code_object_reader_create_from_file");
	hsa_status_t ret = itcp_table.fn_hsa_code_object_reader_create_from_file(file, code_object_reader);
	callback_function(0, "hsa_code_object_reader_create_from_file");
	return ret;
}

hsa_status_t hsa_code_object_reader_create_from_memory( const void *code_object,  size_t size,  hsa_code_object_reader_t *code_object_reader) {
	callback_function(1, "hsa_code_object_reader_create_from_memory");
	hsa_status_t ret = itcp_table.fn_hsa_code_object_reader_create_from_memory(code_object, size, code_object_reader);
	callback_function(0, "hsa_code_object_reader_create_from_memory");
	return ret;
}

hsa_status_t hsa_code_object_reader_destroy( hsa_code_object_reader_t code_object_reader) {
	callback_function(1, "hsa_code_object_reader_destroy");
	hsa_status_t ret = itcp_table.fn_hsa_code_object_reader_destroy(code_object_reader);
	callback_function(0, "hsa_code_object_reader_destroy");
	return ret;
}

/* deprecated */ hsa_status_t hsa_executable_create( hsa_profile_t profile,  hsa_executable_state_t executable_state,  const char *options,  hsa_executable_t *executable) {
	callback_function(1, "hsa_executable_create");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_executable_create(profile, executable_state, options, executable);
	callback_function(0, "hsa_executable_create");
	return ret;
}

hsa_status_t hsa_executable_create_alt( hsa_profile_t profile,  hsa_default_float_rounding_mode_t default_float_rounding_mode,  const char *options,  hsa_executable_t *executable) {
	callback_function(1, "hsa_executable_create_alt");
	hsa_status_t ret = itcp_table.fn_hsa_executable_create_alt(profile, default_float_rounding_mode, options, executable);
	callback_function(0, "hsa_executable_create_alt");
	return ret;
}

hsa_status_t hsa_executable_destroy( hsa_executable_t executable) {
	callback_function(1, "hsa_executable_destroy");
	hsa_status_t ret = itcp_table.fn_hsa_executable_destroy(executable);
	callback_function(0, "hsa_executable_destroy");
	return ret;
}

/* deprecated */ hsa_status_t hsa_executable_load_code_object( hsa_executable_t executable,  hsa_agent_t agent,  hsa_code_object_t code_object,  const char *options) {
	callback_function(1, "hsa_executable_load_code_object");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_executable_load_code_object(executable, agent, code_object, options);
	callback_function(0, "hsa_executable_load_code_object");
	return ret;
}

hsa_status_t hsa_executable_load_program_code_object( hsa_executable_t executable,  hsa_code_object_reader_t code_object_reader,  const char *options,  hsa_loaded_code_object_t *loaded_code_object) {
	callback_function(1, "hsa_executable_load_program_code_object");
	hsa_status_t ret = itcp_table.fn_hsa_executable_load_program_code_object(executable, code_object_reader, options, loaded_code_object);
	callback_function(0, "hsa_executable_load_program_code_object");
	return ret;
}

hsa_status_t hsa_executable_load_agent_code_object( hsa_executable_t executable,  hsa_agent_t agent,  hsa_code_object_reader_t code_object_reader,  const char *options,  hsa_loaded_code_object_t *loaded_code_object) {
	callback_function(1, "hsa_executable_load_agent_code_object");
	hsa_status_t ret = itcp_table.fn_hsa_executable_load_agent_code_object(executable, agent, code_object_reader, options, loaded_code_object);
	callback_function(0, "hsa_executable_load_agent_code_object");
	return ret;
}

hsa_status_t hsa_executable_freeze( hsa_executable_t executable,  const char *options) {
	callback_function(1, "hsa_executable_freeze");
	hsa_status_t ret = itcp_table.fn_hsa_executable_freeze(executable, options);
	callback_function(0, "hsa_executable_freeze");
	return ret;
}

hsa_status_t hsa_executable_get_info( hsa_executable_t executable,  hsa_executable_info_t attribute,  void *value) {
	callback_function(1, "hsa_executable_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_executable_get_info(executable, attribute, value);
	callback_function(0, "hsa_executable_get_info");
	return ret;
}

hsa_status_t hsa_executable_global_variable_define( hsa_executable_t executable,  const char *variable_name,  void *address) {
	callback_function(1, "hsa_executable_global_variable_define");
	hsa_status_t ret = itcp_table.fn_hsa_executable_global_variable_define(executable, variable_name, address);
	callback_function(0, "hsa_executable_global_variable_define");
	return ret;
}

hsa_status_t hsa_executable_agent_global_variable_define( hsa_executable_t executable,  hsa_agent_t agent,  const char *variable_name,  void *address) {
	callback_function(1, "hsa_executable_agent_global_variable_define");
	hsa_status_t ret = itcp_table.fn_hsa_executable_agent_global_variable_define(executable, agent, variable_name, address);
	callback_function(0, "hsa_executable_agent_global_variable_define");
	return ret;
}

hsa_status_t hsa_executable_readonly_variable_define( hsa_executable_t executable,  hsa_agent_t agent,  const char *variable_name,  void *address) {
	callback_function(1, "hsa_executable_readonly_variable_define");
	hsa_status_t ret = itcp_table.fn_hsa_executable_readonly_variable_define(executable, agent, variable_name, address);
	callback_function(0, "hsa_executable_readonly_variable_define");
	return ret;
}

hsa_status_t hsa_executable_validate( hsa_executable_t executable,  uint32_t *result) {
	callback_function(1, "hsa_executable_validate");
	hsa_status_t ret = itcp_table.fn_hsa_executable_validate(executable, result);
	callback_function(0, "hsa_executable_validate");
	return ret;
}

hsa_status_t hsa_executable_validate_alt( hsa_executable_t executable,  const char *options,  uint32_t *result) {
	callback_function(1, "hsa_executable_validate_alt");
	hsa_status_t ret = itcp_table.fn_hsa_executable_validate_alt(executable, options, result);
	callback_function(0, "hsa_executable_validate_alt");
	return ret;
}

/* deprecated */ hsa_status_t hsa_executable_get_symbol( hsa_executable_t executable,  const char *module_name,  const char *symbol_name,  hsa_agent_t agent,  int32_t call_convention,  hsa_executable_symbol_t *symbol) {
	callback_function(1, "hsa_executable_get_symbol");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_executable_get_symbol(executable, module_name, symbol_name, agent, call_convention, symbol);
	callback_function(0, "hsa_executable_get_symbol");
	return ret;
}

hsa_status_t hsa_executable_get_symbol_by_name( hsa_executable_t executable,  const char *symbol_name,  const hsa_agent_t *agent,  hsa_executable_symbol_t *symbol) {
	callback_function(1, "hsa_executable_get_symbol_by_name");
	hsa_status_t ret = itcp_table.fn_hsa_executable_get_symbol_by_name(executable, symbol_name, agent, symbol);
	callback_function(0, "hsa_executable_get_symbol_by_name");
	return ret;
}

hsa_status_t hsa_executable_symbol_get_info( hsa_executable_symbol_t executable_symbol,  hsa_executable_symbol_info_t attribute,  void *value) {
	callback_function(1, "hsa_executable_symbol_get_info");
	hsa_status_t ret = itcp_table.fn_hsa_executable_symbol_get_info(executable_symbol, attribute, value);
	callback_function(0, "hsa_executable_symbol_get_info");
	return ret;
}

/* deprecated */ hsa_status_t hsa_executable_iterate_symbols( hsa_executable_t executable,  hsa_status_t (*callback)(hsa_executable_t executable, hsa_executable_symbol_t symbol, void *data),  void *data) {
	callback_function(1, "hsa_executable_iterate_symbols");
	/* deprecated */ hsa_status_t ret = itcp_table.fn_hsa_executable_iterate_symbols(executable, callback, data);
	callback_function(0, "hsa_executable_iterate_symbols");
	return ret;
}

hsa_status_t hsa_executable_iterate_agent_symbols( hsa_executable_t executable,  hsa_agent_t agent,  hsa_status_t (*callback)(hsa_executable_t exec, hsa_agent_t agent, hsa_executable_symbol_t symbol, void *data),  void *data) {
	callback_function(1, "hsa_executable_iterate_agent_symbols");
	hsa_status_t ret = itcp_table.fn_hsa_executable_iterate_agent_symbols(executable, agent, callback, data);
	callback_function(0, "hsa_executable_iterate_agent_symbols");
	return ret;
}

hsa_status_t hsa_executable_iterate_program_symbols( hsa_executable_t executable,  hsa_status_t (*callback)(hsa_executable_t exec, hsa_executable_symbol_t symbol, void *data),  void *data) {
	callback_function(1, "hsa_executable_iterate_program_symbols");
	hsa_status_t ret = itcp_table.fn_hsa_executable_iterate_program_symbols(executable, callback, data);
	callback_function(0, "hsa_executable_iterate_program_symbols");
	return ret;
}

hsa_status_t hsa_status_string( hsa_status_t status,  const char **status_string) {
	callback_function(1, "hsa_status_string");
	hsa_status_t ret = itcp_table.fn_hsa_status_string(status, status_string);
	callback_function(0, "hsa_status_string");
	return ret;
}


// extern "C" {
// __attribute__((constructor)) void init(void) {
//     // init_callback(sample);
//     load_itcp_table();
//     printf("Profiler initialized.\n");
// }

// __attribute__((destructor)) void fini(void) {
//     printf("Profiler finalized.\n");
// }
// }

