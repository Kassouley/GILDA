#include "hsa_intercepted_functions.h"
#include "hsa_intercept_table_mgr.h"
#include "hsa_callback.h"

#include "hsa.h"
#include "hsa_ext_amd.h"

extern hsa_intercept_table_t hsa_itcp_table;

hsa_status_t hsa_amd_coherency_get_type(hsa_agent_t agent, hsa_amd_coherency_type_t* type) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_coherency_get_type(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_coherency_get_type, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_coherency_get_type(agent, type);
	GET_CB_ARGS_DATA_hsa_amd_coherency_get_type(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_coherency_get_type, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_coherency_set_type(hsa_agent_t agent, hsa_amd_coherency_type_t type) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_coherency_set_type(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_coherency_set_type, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_coherency_set_type(agent, type);
	GET_CB_ARGS_DATA_hsa_amd_coherency_set_type(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_coherency_set_type, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_profiling_set_profiler_enabled(hsa_queue_t* queue, int enable) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_profiling_set_profiler_enabled(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_profiling_set_profiler_enabled, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_profiling_set_profiler_enabled(queue, enable);
	GET_CB_ARGS_DATA_hsa_amd_profiling_set_profiler_enabled(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_profiling_set_profiler_enabled, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_profiling_async_copy_enable(bool enable) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_profiling_async_copy_enable(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_profiling_async_copy_enable, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_profiling_async_copy_enable(enable);
	GET_CB_ARGS_DATA_hsa_amd_profiling_async_copy_enable(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_profiling_async_copy_enable, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_profiling_get_dispatch_time(hsa_agent_t agent, hsa_signal_t signal, hsa_amd_profiling_dispatch_time_t* time) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_profiling_get_dispatch_time(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_profiling_get_dispatch_time, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_profiling_get_dispatch_time(agent, signal, time);
	GET_CB_ARGS_DATA_hsa_amd_profiling_get_dispatch_time(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_profiling_get_dispatch_time, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_profiling_get_async_copy_time(hsa_signal_t signal, hsa_amd_profiling_async_copy_time_t* time) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_profiling_get_async_copy_time(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_profiling_get_async_copy_time, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_profiling_get_async_copy_time(signal, time);
	GET_CB_ARGS_DATA_hsa_amd_profiling_get_async_copy_time(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_profiling_get_async_copy_time, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_profiling_convert_tick_to_system_domain(hsa_agent_t agent, uint64_t agent_tick, uint64_t* system_tick) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_profiling_convert_tick_to_system_domain(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_profiling_convert_tick_to_system_domain, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_profiling_convert_tick_to_system_domain(agent, agent_tick, system_tick);
	GET_CB_ARGS_DATA_hsa_amd_profiling_convert_tick_to_system_domain(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_profiling_convert_tick_to_system_domain, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_signal_create(hsa_signal_value_t initial_value, uint32_t num_consumers, const hsa_agent_t* consumers, uint64_t attributes, hsa_signal_t* signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_signal_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_signal_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_signal_create(initial_value, num_consumers, consumers, attributes, signal);
	GET_CB_ARGS_DATA_hsa_amd_signal_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_signal_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_signal_value_pointer(hsa_signal_t signal, volatile hsa_signal_value_t** value_ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_signal_value_pointer(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_signal_value_pointer, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_signal_value_pointer(signal, value_ptr);
	GET_CB_ARGS_DATA_hsa_amd_signal_value_pointer(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_signal_value_pointer, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_signal_async_handler(hsa_signal_t signal, hsa_signal_condition_t cond, hsa_signal_value_t value, hsa_amd_signal_handler handler, void* arg) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_signal_async_handler(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_signal_async_handler, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_signal_async_handler(signal, cond, value, handler, arg);
	GET_CB_ARGS_DATA_hsa_amd_signal_async_handler(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_signal_async_handler, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_async_function(void (*callback)(void* arg), void* arg) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_async_function(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_async_function, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_async_function(callback, arg);
	GET_CB_ARGS_DATA_hsa_amd_async_function(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_async_function, __hsa_data__);
	return __hsa_ret__;
}

uint32_t hsa_amd_signal_wait_any(uint32_t signal_count, hsa_signal_t* signals, hsa_signal_condition_t* conds, hsa_signal_value_t* values, uint64_t timeout_hint, hsa_wait_state_t wait_hint, hsa_signal_value_t* satisfying_value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_signal_wait_any(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_signal_wait_any, __hsa_data__);
	uint32_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_signal_wait_any(signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value);
	GET_CB_ARGS_DATA_hsa_amd_signal_wait_any(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_signal_wait_any, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_image_get_info_max_dim(hsa_agent_t agent, hsa_agent_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_image_get_info_max_dim(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_image_get_info_max_dim, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_image_get_info_max_dim(agent, attribute, value);
	GET_CB_ARGS_DATA_hsa_amd_image_get_info_max_dim(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_image_get_info_max_dim, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_queue_cu_set_mask(const hsa_queue_t* queue, uint32_t num_cu_mask_count, const uint32_t* cu_mask) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_queue_cu_set_mask(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_queue_cu_set_mask, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_queue_cu_set_mask(queue, num_cu_mask_count, cu_mask);
	GET_CB_ARGS_DATA_hsa_amd_queue_cu_set_mask(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_queue_cu_set_mask, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_queue_cu_get_mask(const hsa_queue_t* queue, uint32_t num_cu_mask_count, uint32_t* cu_mask) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_queue_cu_get_mask(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_queue_cu_get_mask, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_queue_cu_get_mask(queue, num_cu_mask_count, cu_mask);
	GET_CB_ARGS_DATA_hsa_amd_queue_cu_get_mask(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_queue_cu_get_mask, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_pool_get_info(hsa_amd_memory_pool_t memory_pool, hsa_amd_memory_pool_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_pool_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_pool_get_info(memory_pool, attribute, value);
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_pool_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_agent_iterate_memory_pools(hsa_agent_t agent, hsa_status_t (*callback)(hsa_amd_memory_pool_t memory_pool, void* data), void* data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_agent_iterate_memory_pools(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_agent_iterate_memory_pools, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_agent_iterate_memory_pools(agent, callback, data);
	GET_CB_ARGS_DATA_hsa_amd_agent_iterate_memory_pools(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_agent_iterate_memory_pools, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_pool_allocate(hsa_amd_memory_pool_t memory_pool, size_t size, uint32_t flags, void** ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_allocate(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_pool_allocate, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_pool_allocate(memory_pool, size, flags, ptr);
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_allocate(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_pool_allocate, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_pool_free(void* ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_free(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_pool_free, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_pool_free(ptr);
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_free(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_pool_free, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_async_copy(void* dst, hsa_agent_t dst_agent, const void* src, hsa_agent_t src_agent, size_t size, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_async_copy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_async_copy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_async_copy(dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal);
	GET_CB_ARGS_DATA_hsa_amd_memory_async_copy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_async_copy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_async_copy_on_engine(void* dst, hsa_agent_t dst_agent, const void* src, hsa_agent_t src_agent, size_t size, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal, hsa_amd_sdma_engine_id_t engine_id, bool force_copy_on_sdma) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_async_copy_on_engine(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_async_copy_on_engine, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_async_copy_on_engine(dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal, engine_id, force_copy_on_sdma);
	GET_CB_ARGS_DATA_hsa_amd_memory_async_copy_on_engine(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_async_copy_on_engine, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_copy_engine_status(hsa_agent_t dst_agent, hsa_agent_t src_agent, uint32_t *engine_ids_mask) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_copy_engine_status(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_copy_engine_status, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_copy_engine_status(dst_agent, src_agent, engine_ids_mask);
	GET_CB_ARGS_DATA_hsa_amd_memory_copy_engine_status(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_copy_engine_status, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_async_copy_rect(const hsa_pitched_ptr_t* dst, const hsa_dim3_t* dst_offset, const hsa_pitched_ptr_t* src, const hsa_dim3_t* src_offset, const hsa_dim3_t* range, hsa_agent_t copy_agent, hsa_amd_copy_direction_t dir, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_async_copy_rect(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_async_copy_rect, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_async_copy_rect(dst, dst_offset, src, src_offset, range, copy_agent, dir, num_dep_signals, dep_signals, completion_signal);
	GET_CB_ARGS_DATA_hsa_amd_memory_async_copy_rect(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_async_copy_rect, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_agent_memory_pool_get_info(hsa_agent_t agent, hsa_amd_memory_pool_t memory_pool, hsa_amd_agent_memory_pool_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_agent_memory_pool_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_agent_memory_pool_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_agent_memory_pool_get_info(agent, memory_pool, attribute, value);
	GET_CB_ARGS_DATA_hsa_amd_agent_memory_pool_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_agent_memory_pool_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_agents_allow_access(uint32_t num_agents, const hsa_agent_t* agents, const uint32_t* flags, const void* ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_agents_allow_access(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_agents_allow_access, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_agents_allow_access(num_agents, agents, flags, ptr);
	GET_CB_ARGS_DATA_hsa_amd_agents_allow_access(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_agents_allow_access, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_pool_can_migrate(hsa_amd_memory_pool_t src_memory_pool, hsa_amd_memory_pool_t dst_memory_pool, bool* result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_can_migrate(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_pool_can_migrate, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_pool_can_migrate(src_memory_pool, dst_memory_pool, result);
	GET_CB_ARGS_DATA_hsa_amd_memory_pool_can_migrate(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_pool_can_migrate, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_migrate(const void* ptr, hsa_amd_memory_pool_t memory_pool, uint32_t flags) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_migrate(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_migrate, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_migrate(ptr, memory_pool, flags);
	GET_CB_ARGS_DATA_hsa_amd_memory_migrate(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_migrate, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_lock(void* host_ptr, size_t size, hsa_agent_t* agents, int num_agent, void** agent_ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_lock(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_lock, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_lock(host_ptr, size, agents, num_agent, agent_ptr);
	GET_CB_ARGS_DATA_hsa_amd_memory_lock(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_lock, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_lock_to_pool(void* host_ptr, size_t size, hsa_agent_t* agents, int num_agent, hsa_amd_memory_pool_t pool, uint32_t flags, void** agent_ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_lock_to_pool(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_lock_to_pool, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_lock_to_pool(host_ptr, size, agents, num_agent, pool, flags, agent_ptr);
	GET_CB_ARGS_DATA_hsa_amd_memory_lock_to_pool(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_lock_to_pool, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_unlock(void* host_ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_unlock(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_unlock, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_unlock(host_ptr);
	GET_CB_ARGS_DATA_hsa_amd_memory_unlock(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_unlock, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_memory_fill(void* ptr, uint32_t value, size_t count) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_memory_fill(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_memory_fill, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_memory_fill(ptr, value, count);
	GET_CB_ARGS_DATA_hsa_amd_memory_fill(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_memory_fill, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_interop_map_buffer(uint32_t num_agents, hsa_agent_t* agents, int interop_handle, uint32_t flags, size_t* size, void** ptr, size_t* metadata_size, const void** metadata) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_interop_map_buffer(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_interop_map_buffer, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_interop_map_buffer(num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata);
	GET_CB_ARGS_DATA_hsa_amd_interop_map_buffer(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_interop_map_buffer, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_interop_unmap_buffer(void* ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_interop_unmap_buffer(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_interop_unmap_buffer, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_interop_unmap_buffer(ptr);
	GET_CB_ARGS_DATA_hsa_amd_interop_unmap_buffer(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_interop_unmap_buffer, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_image_create(hsa_agent_t agent, const hsa_ext_image_descriptor_t *image_descriptor, const hsa_amd_image_descriptor_t *image_layout, const void *image_data, hsa_access_permission_t access_permission, hsa_ext_image_t *image) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_image_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_image_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_image_create(agent, image_descriptor, image_layout, image_data, access_permission, image);
	GET_CB_ARGS_DATA_hsa_amd_image_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_image_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_pointer_info(const void* ptr, hsa_amd_pointer_info_t* info, void* (*alloc)(size_t), uint32_t* num_agents_accessible, hsa_agent_t** accessible) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_pointer_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_pointer_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_pointer_info(ptr, info, alloc, num_agents_accessible, accessible);
	GET_CB_ARGS_DATA_hsa_amd_pointer_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_pointer_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_pointer_info_set_userdata(const void* ptr, void* userdata) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_pointer_info_set_userdata(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_pointer_info_set_userdata, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_pointer_info_set_userdata(ptr, userdata);
	GET_CB_ARGS_DATA_hsa_amd_pointer_info_set_userdata(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_pointer_info_set_userdata, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_ipc_memory_create(void* ptr, size_t len, hsa_amd_ipc_memory_t* handle) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_ipc_memory_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_ipc_memory_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_ipc_memory_create(ptr, len, handle);
	GET_CB_ARGS_DATA_hsa_amd_ipc_memory_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_ipc_memory_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_ipc_memory_attach(const hsa_amd_ipc_memory_t* handle, size_t len, uint32_t num_agents, const hsa_agent_t* mapping_agents, void** mapped_ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_ipc_memory_attach(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_ipc_memory_attach, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_ipc_memory_attach(handle, len, num_agents, mapping_agents, mapped_ptr);
	GET_CB_ARGS_DATA_hsa_amd_ipc_memory_attach(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_ipc_memory_attach, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_ipc_memory_detach(void* mapped_ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_ipc_memory_detach(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_ipc_memory_detach, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_ipc_memory_detach(mapped_ptr);
	GET_CB_ARGS_DATA_hsa_amd_ipc_memory_detach(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_ipc_memory_detach, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_ipc_signal_create(hsa_signal_t signal, hsa_amd_ipc_signal_t* handle) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_ipc_signal_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_ipc_signal_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_ipc_signal_create(signal, handle);
	GET_CB_ARGS_DATA_hsa_amd_ipc_signal_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_ipc_signal_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_ipc_signal_attach(const hsa_amd_ipc_signal_t* handle, hsa_signal_t* signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_ipc_signal_attach(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_ipc_signal_attach, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_ipc_signal_attach(handle, signal);
	GET_CB_ARGS_DATA_hsa_amd_ipc_signal_attach(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_ipc_signal_attach, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_register_system_event_handler(hsa_amd_system_event_callback_t callback, void* data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_register_system_event_handler(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_register_system_event_handler, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_register_system_event_handler(callback, data);
	GET_CB_ARGS_DATA_hsa_amd_register_system_event_handler(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_register_system_event_handler, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_queue_set_priority(hsa_queue_t* queue, hsa_amd_queue_priority_t priority) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_queue_set_priority(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_queue_set_priority, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_queue_set_priority(queue, priority);
	GET_CB_ARGS_DATA_hsa_amd_queue_set_priority(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_queue_set_priority, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_register_deallocation_callback(void* ptr, hsa_amd_deallocation_callback_t callback, void* user_data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_register_deallocation_callback(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_register_deallocation_callback, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_register_deallocation_callback(ptr, callback, user_data);
	GET_CB_ARGS_DATA_hsa_amd_register_deallocation_callback(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_register_deallocation_callback, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_deregister_deallocation_callback(void* ptr, hsa_amd_deallocation_callback_t callback) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_deregister_deallocation_callback(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_deregister_deallocation_callback, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_deregister_deallocation_callback(ptr, callback);
	GET_CB_ARGS_DATA_hsa_amd_deregister_deallocation_callback(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_deregister_deallocation_callback, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_svm_attributes_set(void* ptr, size_t size, hsa_amd_svm_attribute_pair_t* attribute_list, size_t attribute_count) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_svm_attributes_set(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_svm_attributes_set, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_svm_attributes_set(ptr, size, attribute_list, attribute_count);
	GET_CB_ARGS_DATA_hsa_amd_svm_attributes_set(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_svm_attributes_set, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_svm_attributes_get(void* ptr, size_t size, hsa_amd_svm_attribute_pair_t* attribute_list, size_t attribute_count) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_svm_attributes_get(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_svm_attributes_get, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_svm_attributes_get(ptr, size, attribute_list, attribute_count);
	GET_CB_ARGS_DATA_hsa_amd_svm_attributes_get(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_svm_attributes_get, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_svm_prefetch_async(void* ptr, size_t size, hsa_agent_t agent, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_svm_prefetch_async(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_svm_prefetch_async, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_svm_prefetch_async(ptr, size, agent, num_dep_signals, dep_signals, completion_signal);
	GET_CB_ARGS_DATA_hsa_amd_svm_prefetch_async(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_svm_prefetch_async, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_spm_acquire(hsa_agent_t preferred_agent) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_spm_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_spm_acquire, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_spm_acquire(preferred_agent);
	GET_CB_ARGS_DATA_hsa_amd_spm_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_spm_acquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_spm_release(hsa_agent_t preferred_agent) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_spm_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_spm_release, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_spm_release(preferred_agent);
	GET_CB_ARGS_DATA_hsa_amd_spm_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_spm_release, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_spm_set_dest_buffer(hsa_agent_t preferred_agent, size_t size_in_bytes, uint32_t* timeout, uint32_t* size_copied, void* dest, bool* is_data_loss) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_spm_set_dest_buffer(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_spm_set_dest_buffer, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_spm_set_dest_buffer(preferred_agent, size_in_bytes, timeout, size_copied, dest, is_data_loss);
	GET_CB_ARGS_DATA_hsa_amd_spm_set_dest_buffer(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_spm_set_dest_buffer, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_portable_export_dmabuf(const void* ptr, size_t size, int* dmabuf, uint64_t* offset) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_portable_export_dmabuf(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_portable_export_dmabuf, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_portable_export_dmabuf(ptr, size, dmabuf, offset);
	GET_CB_ARGS_DATA_hsa_amd_portable_export_dmabuf(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_portable_export_dmabuf, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_portable_close_dmabuf(int dmabuf) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_portable_close_dmabuf(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_portable_close_dmabuf, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_portable_close_dmabuf(dmabuf);
	GET_CB_ARGS_DATA_hsa_amd_portable_close_dmabuf(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_portable_close_dmabuf, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_address_reserve(void** va, size_t size, uint64_t address, uint64_t flags) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_address_reserve(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_address_reserve, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_address_reserve(va, size, address, flags);
	GET_CB_ARGS_DATA_hsa_amd_vmem_address_reserve(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_address_reserve, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_address_free(void* va, size_t size) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_address_free(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_address_free, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_address_free(va, size);
	GET_CB_ARGS_DATA_hsa_amd_vmem_address_free(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_address_free, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_handle_create(hsa_amd_memory_pool_t pool, size_t size, hsa_amd_memory_type_t type, uint64_t flags, hsa_amd_vmem_alloc_handle_t* memory_handle) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_handle_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_handle_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_handle_create(pool, size, type, flags, memory_handle);
	GET_CB_ARGS_DATA_hsa_amd_vmem_handle_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_handle_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_handle_release(hsa_amd_vmem_alloc_handle_t memory_handle) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_handle_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_handle_release, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_handle_release(memory_handle);
	GET_CB_ARGS_DATA_hsa_amd_vmem_handle_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_handle_release, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_map(void* va, size_t size, size_t in_offset, hsa_amd_vmem_alloc_handle_t memory_handle, uint64_t flags) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_map(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_map, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_map(va, size, in_offset, memory_handle, flags);
	GET_CB_ARGS_DATA_hsa_amd_vmem_map(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_map, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_unmap(void* va, size_t size) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_unmap(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_unmap, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_unmap(va, size);
	GET_CB_ARGS_DATA_hsa_amd_vmem_unmap(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_unmap, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_set_access(void* va, size_t size, const hsa_amd_memory_access_desc_t* desc, size_t desc_cnt) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_set_access(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_set_access, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_set_access(va, size, desc, desc_cnt);
	GET_CB_ARGS_DATA_hsa_amd_vmem_set_access(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_set_access, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_get_access(void* va, hsa_access_permission_t* perms, hsa_agent_t agent_handle) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_get_access(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_get_access, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_get_access(va, perms, agent_handle);
	GET_CB_ARGS_DATA_hsa_amd_vmem_get_access(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_get_access, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_export_shareable_handle(int* dmabuf_fd, hsa_amd_vmem_alloc_handle_t handle, uint64_t flags) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_export_shareable_handle(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_export_shareable_handle, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_export_shareable_handle(dmabuf_fd, handle, flags);
	GET_CB_ARGS_DATA_hsa_amd_vmem_export_shareable_handle(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_export_shareable_handle, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_import_shareable_handle(int dmabuf_fd, hsa_amd_vmem_alloc_handle_t* handle) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_import_shareable_handle(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_import_shareable_handle, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_import_shareable_handle(dmabuf_fd, handle);
	GET_CB_ARGS_DATA_hsa_amd_vmem_import_shareable_handle(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_import_shareable_handle, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_retain_alloc_handle(hsa_amd_vmem_alloc_handle_t* memory_handle, void* addr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_retain_alloc_handle(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_retain_alloc_handle, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_retain_alloc_handle(memory_handle, addr);
	GET_CB_ARGS_DATA_hsa_amd_vmem_retain_alloc_handle(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_retain_alloc_handle, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_vmem_get_alloc_properties_from_handle(hsa_amd_vmem_alloc_handle_t memory_handle, hsa_amd_memory_pool_t* pool, hsa_amd_memory_type_t* type) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_vmem_get_alloc_properties_from_handle(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_vmem_get_alloc_properties_from_handle, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_vmem_get_alloc_properties_from_handle(memory_handle, pool, type);
	GET_CB_ARGS_DATA_hsa_amd_vmem_get_alloc_properties_from_handle(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_vmem_get_alloc_properties_from_handle, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_amd_agent_set_async_scratch_limit(hsa_agent_t agent, size_t threshold) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_amd_agent_set_async_scratch_limit(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_amd_agent_set_async_scratch_limit, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_amd_agent_set_async_scratch_limit(agent, threshold);
	GET_CB_ARGS_DATA_hsa_amd_agent_set_async_scratch_limit(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_amd_agent_set_async_scratch_limit, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_status_string(hsa_status_t status, const char ** status_string) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_status_string(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_status_string, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_status_string(status, status_string);
	GET_CB_ARGS_DATA_hsa_status_string(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_status_string, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_init() {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_init(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_init, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_init();
	GET_CB_ARGS_DATA_hsa_init(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_init, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_shut_down() {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_shut_down(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_shut_down, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_shut_down();
	GET_CB_ARGS_DATA_hsa_shut_down(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_shut_down, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_system_get_info(hsa_system_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_system_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_system_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_system_get_info(attribute, value);
	GET_CB_ARGS_DATA_hsa_system_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_system_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_extension_get_name(uint16_t extension, const char **name) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_extension_get_name(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_extension_get_name, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_extension_get_name(extension, name);
	GET_CB_ARGS_DATA_hsa_extension_get_name(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_extension_get_name, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_system_extension_supported(uint16_t extension, uint16_t version_major, uint16_t version_minor, bool* result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_system_extension_supported(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_system_extension_supported, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_system_extension_supported(extension, version_major, version_minor, result);
	GET_CB_ARGS_DATA_hsa_system_extension_supported(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_system_extension_supported, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_system_major_extension_supported(uint16_t extension, uint16_t version_major, uint16_t *version_minor, bool* result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_system_major_extension_supported(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_system_major_extension_supported, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_system_major_extension_supported(extension, version_major, version_minor, result);
	GET_CB_ARGS_DATA_hsa_system_major_extension_supported(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_system_major_extension_supported, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_system_get_extension_table(uint16_t extension, uint16_t version_major, uint16_t version_minor, void *table) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_system_get_extension_table(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_system_get_extension_table, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_system_get_extension_table(extension, version_major, version_minor, table);
	GET_CB_ARGS_DATA_hsa_system_get_extension_table(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_system_get_extension_table, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_system_get_major_extension_table(uint16_t extension, uint16_t version_major, size_t table_length, void *table) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_system_get_major_extension_table(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_system_get_major_extension_table, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_system_get_major_extension_table(extension, version_major, table_length, table);
	GET_CB_ARGS_DATA_hsa_system_get_major_extension_table(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_system_get_major_extension_table, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_get_info(hsa_agent_t agent, hsa_agent_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_get_info(agent, attribute, value);
	GET_CB_ARGS_DATA_hsa_agent_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_iterate_agents(hsa_status_t (*callback)(hsa_agent_t agent, void* data), void* data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_iterate_agents(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_iterate_agents, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_iterate_agents(callback, data);
	GET_CB_ARGS_DATA_hsa_iterate_agents(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_iterate_agents, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_get_exception_policies(hsa_agent_t agent, hsa_profile_t profile, uint16_t *mask) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_get_exception_policies(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_get_exception_policies, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_get_exception_policies(agent, profile, mask);
	GET_CB_ARGS_DATA_hsa_agent_get_exception_policies(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_get_exception_policies, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_cache_get_info(hsa_cache_t cache, hsa_cache_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_cache_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_cache_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_cache_get_info(cache, attribute, value);
	GET_CB_ARGS_DATA_hsa_cache_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_cache_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_iterate_caches(hsa_agent_t agent, hsa_status_t (*callback)(hsa_cache_t cache, void* data), void* data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_iterate_caches(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_iterate_caches, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_iterate_caches(agent, callback, data);
	GET_CB_ARGS_DATA_hsa_agent_iterate_caches(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_iterate_caches, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_extension_supported(uint16_t extension, hsa_agent_t agent, uint16_t version_major, uint16_t version_minor, bool* result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_extension_supported(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_extension_supported, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_extension_supported(extension, agent, version_major, version_minor, result);
	GET_CB_ARGS_DATA_hsa_agent_extension_supported(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_extension_supported, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_major_extension_supported(uint16_t extension, hsa_agent_t agent, uint16_t version_major, uint16_t *version_minor, bool* result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_major_extension_supported(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_major_extension_supported, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_major_extension_supported(extension, agent, version_major, version_minor, result);
	GET_CB_ARGS_DATA_hsa_agent_major_extension_supported(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_major_extension_supported, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_signal_create(hsa_signal_value_t initial_value, uint32_t num_consumers, const hsa_agent_t *consumers, hsa_signal_t *signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_create(initial_value, num_consumers, consumers, signal);
	GET_CB_ARGS_DATA_hsa_signal_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_signal_destroy(hsa_signal_t signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_destroy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_destroy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_destroy(signal);
	GET_CB_ARGS_DATA_hsa_signal_destroy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_destroy, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_load_scacquire(hsa_signal_t signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_load_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_load_scacquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_load_scacquire(signal);
	GET_CB_ARGS_DATA_hsa_signal_load_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_load_scacquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_load_relaxed(hsa_signal_t signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_load_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_load_relaxed, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_load_relaxed(signal);
	GET_CB_ARGS_DATA_hsa_signal_load_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_load_relaxed, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_load_acquire(hsa_signal_t signal) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_load_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_load_acquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_load_acquire(signal);
	GET_CB_ARGS_DATA_hsa_signal_load_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_load_acquire, __hsa_data__);
	return __hsa_ret__;
}

void hsa_signal_store_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_store_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_store_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_store_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_store_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_store_relaxed, __hsa_data__);
	return;
}

void hsa_signal_store_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_store_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_store_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_store_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_store_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_store_screlease, __hsa_data__);
	return;
}

void hsa_signal_store_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_store_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_store_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_store_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_store_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_store_release, __hsa_data__);
	return;
}

void hsa_signal_silent_store_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_silent_store_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_silent_store_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_silent_store_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_silent_store_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_silent_store_relaxed, __hsa_data__);
	return;
}

void hsa_signal_silent_store_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_silent_store_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_silent_store_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_silent_store_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_silent_store_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_silent_store_screlease, __hsa_data__);
	return;
}

hsa_signal_value_t hsa_signal_exchange_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_scacq_screl, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_scacq_screl(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_scacq_screl, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_exchange_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_acq_rel, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_acq_rel(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_acq_rel, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_exchange_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_scacquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_scacquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_scacquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_exchange_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_acquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_acquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_acquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_exchange_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_relaxed, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_relaxed, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_exchange_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_screlease, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_screlease, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_exchange_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_exchange_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_exchange_release, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_exchange_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_exchange_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_exchange_release, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_scacq_screl(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_scacq_screl, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_scacq_screl(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_scacq_screl, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_acq_rel(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_acq_rel, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_acq_rel(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_acq_rel, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_scacquire(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_scacquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_scacquire(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_scacquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_acquire(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_acquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_acquire(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_acquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_relaxed(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_relaxed, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_relaxed(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_relaxed, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_screlease(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_screlease, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_screlease(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_screlease, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_cas_release(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_cas_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_cas_release, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_cas_release(signal, expected, value);
	GET_CB_ARGS_DATA_hsa_signal_cas_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_cas_release, __hsa_data__);
	return __hsa_ret__;
}

void hsa_signal_add_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_scacq_screl, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_scacq_screl(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_scacq_screl, __hsa_data__);
	return;
}

void hsa_signal_add_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_acq_rel, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_acq_rel(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_acq_rel, __hsa_data__);
	return;
}

void hsa_signal_add_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_scacquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_scacquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_scacquire, __hsa_data__);
	return;
}

void hsa_signal_add_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_acquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_acquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_acquire, __hsa_data__);
	return;
}

void hsa_signal_add_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_relaxed, __hsa_data__);
	return;
}

void hsa_signal_add_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_screlease, __hsa_data__);
	return;
}

void hsa_signal_add_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_add_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_add_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_add_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_add_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_add_release, __hsa_data__);
	return;
}

void hsa_signal_subtract_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_scacq_screl, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_scacq_screl(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_scacq_screl, __hsa_data__);
	return;
}

void hsa_signal_subtract_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_acq_rel, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_acq_rel(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_acq_rel, __hsa_data__);
	return;
}

void hsa_signal_subtract_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_scacquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_scacquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_scacquire, __hsa_data__);
	return;
}

void hsa_signal_subtract_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_acquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_acquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_acquire, __hsa_data__);
	return;
}

void hsa_signal_subtract_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_relaxed, __hsa_data__);
	return;
}

void hsa_signal_subtract_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_screlease, __hsa_data__);
	return;
}

void hsa_signal_subtract_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_subtract_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_subtract_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_subtract_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_subtract_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_subtract_release, __hsa_data__);
	return;
}

void hsa_signal_and_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_scacq_screl, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_scacq_screl(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_scacq_screl, __hsa_data__);
	return;
}

void hsa_signal_and_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_acq_rel, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_acq_rel(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_acq_rel, __hsa_data__);
	return;
}

void hsa_signal_and_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_scacquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_scacquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_scacquire, __hsa_data__);
	return;
}

void hsa_signal_and_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_acquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_acquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_acquire, __hsa_data__);
	return;
}

void hsa_signal_and_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_relaxed, __hsa_data__);
	return;
}

void hsa_signal_and_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_screlease, __hsa_data__);
	return;
}

void hsa_signal_and_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_and_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_and_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_and_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_and_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_and_release, __hsa_data__);
	return;
}

void hsa_signal_or_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_scacq_screl, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_scacq_screl(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_scacq_screl, __hsa_data__);
	return;
}

void hsa_signal_or_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_acq_rel, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_acq_rel(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_acq_rel, __hsa_data__);
	return;
}

void hsa_signal_or_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_scacquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_scacquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_scacquire, __hsa_data__);
	return;
}

void hsa_signal_or_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_acquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_acquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_acquire, __hsa_data__);
	return;
}

void hsa_signal_or_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_relaxed, __hsa_data__);
	return;
}

void hsa_signal_or_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_screlease, __hsa_data__);
	return;
}

void hsa_signal_or_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_or_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_or_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_or_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_or_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_or_release, __hsa_data__);
	return;
}

void hsa_signal_xor_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_scacq_screl, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_scacq_screl(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_scacq_screl, __hsa_data__);
	return;
}

void hsa_signal_xor_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_acq_rel, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_acq_rel(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_acq_rel, __hsa_data__);
	return;
}

void hsa_signal_xor_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_scacquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_scacquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_scacquire, __hsa_data__);
	return;
}

void hsa_signal_xor_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_acquire, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_acquire(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_acquire, __hsa_data__);
	return;
}

void hsa_signal_xor_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_relaxed(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_relaxed, __hsa_data__);
	return;
}

void hsa_signal_xor_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_screlease(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_screlease, __hsa_data__);
	return;
}

void hsa_signal_xor_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_xor_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_xor_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_signal_xor_release(signal, value);
	GET_CB_ARGS_DATA_hsa_signal_xor_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_xor_release, __hsa_data__);
	return;
}

hsa_signal_value_t hsa_signal_wait_scacquire(hsa_signal_t signal, hsa_signal_condition_t condition, hsa_signal_value_t compare_value, uint64_t timeout_hint, hsa_wait_state_t wait_state_hint) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_wait_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_wait_scacquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_wait_scacquire(signal, condition, compare_value, timeout_hint, wait_state_hint);
	GET_CB_ARGS_DATA_hsa_signal_wait_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_wait_scacquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_wait_relaxed(hsa_signal_t signal, hsa_signal_condition_t condition, hsa_signal_value_t compare_value, uint64_t timeout_hint, hsa_wait_state_t wait_state_hint) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_wait_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_wait_relaxed, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_wait_relaxed(signal, condition, compare_value, timeout_hint, wait_state_hint);
	GET_CB_ARGS_DATA_hsa_signal_wait_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_wait_relaxed, __hsa_data__);
	return __hsa_ret__;
}

hsa_signal_value_t hsa_signal_wait_acquire(hsa_signal_t signal, hsa_signal_condition_t condition, hsa_signal_value_t compare_value, uint64_t timeout_hint, hsa_wait_state_t wait_state_hint) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_wait_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_wait_acquire, __hsa_data__);
	hsa_signal_value_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_wait_acquire(signal, condition, compare_value, timeout_hint, wait_state_hint);
	GET_CB_ARGS_DATA_hsa_signal_wait_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_wait_acquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_signal_group_create(uint32_t num_signals, const hsa_signal_t *signals, uint32_t num_consumers, const hsa_agent_t *consumers, hsa_signal_group_t *signal_group) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_group_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_group_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_group_create(num_signals, signals, num_consumers, consumers, signal_group);
	GET_CB_ARGS_DATA_hsa_signal_group_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_group_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_signal_group_destroy(hsa_signal_group_t signal_group) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_group_destroy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_group_destroy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_group_destroy(signal_group);
	GET_CB_ARGS_DATA_hsa_signal_group_destroy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_group_destroy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_signal_group_wait_any_scacquire(hsa_signal_group_t signal_group, const hsa_signal_condition_t *conditions, const hsa_signal_value_t *compare_values, hsa_wait_state_t wait_state_hint, hsa_signal_t *signal, hsa_signal_value_t *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_group_wait_any_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_group_wait_any_scacquire, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_group_wait_any_scacquire(signal_group, conditions, compare_values, wait_state_hint, signal, value);
	GET_CB_ARGS_DATA_hsa_signal_group_wait_any_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_group_wait_any_scacquire, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_signal_group_wait_any_relaxed(hsa_signal_group_t signal_group, const hsa_signal_condition_t *conditions, const hsa_signal_value_t *compare_values, hsa_wait_state_t wait_state_hint, hsa_signal_t *signal, hsa_signal_value_t *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_signal_group_wait_any_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_signal_group_wait_any_relaxed, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_signal_group_wait_any_relaxed(signal_group, conditions, compare_values, wait_state_hint, signal, value);
	GET_CB_ARGS_DATA_hsa_signal_group_wait_any_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_signal_group_wait_any_relaxed, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_queue_create(hsa_agent_t agent, uint32_t size, hsa_queue_type32_t type, void (*callback)(hsa_status_t status, hsa_queue_t *source, void *data), void *data, uint32_t private_segment_size, uint32_t group_segment_size, hsa_queue_t **queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_create(agent, size, type, callback, data, private_segment_size, group_segment_size, queue);
	GET_CB_ARGS_DATA_hsa_queue_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_soft_queue_create(hsa_region_t region, uint32_t size, hsa_queue_type32_t type, uint32_t features, hsa_signal_t doorbell_signal, hsa_queue_t **queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_soft_queue_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_soft_queue_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_soft_queue_create(region, size, type, features, doorbell_signal, queue);
	GET_CB_ARGS_DATA_hsa_soft_queue_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_soft_queue_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_queue_destroy(hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_destroy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_destroy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_destroy(queue);
	GET_CB_ARGS_DATA_hsa_queue_destroy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_destroy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_queue_inactivate(hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_inactivate(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_inactivate, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_inactivate(queue);
	GET_CB_ARGS_DATA_hsa_queue_inactivate(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_inactivate, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_load_read_index_acquire(const hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_load_read_index_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_load_read_index_acquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_load_read_index_acquire(queue);
	GET_CB_ARGS_DATA_hsa_queue_load_read_index_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_load_read_index_acquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_load_read_index_scacquire(const hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_load_read_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_load_read_index_scacquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_load_read_index_scacquire(queue);
	GET_CB_ARGS_DATA_hsa_queue_load_read_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_load_read_index_scacquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_load_read_index_relaxed(const hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_load_read_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_load_read_index_relaxed, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_load_read_index_relaxed(queue);
	GET_CB_ARGS_DATA_hsa_queue_load_read_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_load_read_index_relaxed, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_load_write_index_acquire(const hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_load_write_index_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_load_write_index_acquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_load_write_index_acquire(queue);
	GET_CB_ARGS_DATA_hsa_queue_load_write_index_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_load_write_index_acquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_load_write_index_scacquire(const hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_load_write_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_load_write_index_scacquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_load_write_index_scacquire(queue);
	GET_CB_ARGS_DATA_hsa_queue_load_write_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_load_write_index_scacquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_load_write_index_relaxed(const hsa_queue_t *queue) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_load_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_load_write_index_relaxed, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_load_write_index_relaxed(queue);
	GET_CB_ARGS_DATA_hsa_queue_load_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_load_write_index_relaxed, __hsa_data__);
	return __hsa_ret__;
}

void hsa_queue_store_write_index_relaxed(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_store_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_store_write_index_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_queue_store_write_index_relaxed(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_store_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_store_write_index_relaxed, __hsa_data__);
	return;
}

void hsa_queue_store_write_index_release(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_store_write_index_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_store_write_index_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_queue_store_write_index_release(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_store_write_index_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_store_write_index_release, __hsa_data__);
	return;
}

void hsa_queue_store_write_index_screlease(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_store_write_index_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_store_write_index_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_queue_store_write_index_screlease(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_store_write_index_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_store_write_index_screlease, __hsa_data__);
	return;
}

uint64_t hsa_queue_cas_write_index_acq_rel(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_acq_rel, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_acq_rel(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_acq_rel, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_cas_write_index_scacq_screl(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_scacq_screl, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_scacq_screl(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_scacq_screl, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_cas_write_index_acquire(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_acquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_acquire(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_acquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_cas_write_index_scacquire(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_scacquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_scacquire(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_scacquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_cas_write_index_relaxed(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_relaxed, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_relaxed(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_relaxed, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_cas_write_index_release(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_release, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_release(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_release, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_cas_write_index_screlease(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_cas_write_index_screlease, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_cas_write_index_screlease(queue, expected, value);
	GET_CB_ARGS_DATA_hsa_queue_cas_write_index_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_cas_write_index_screlease, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_acq_rel(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_acq_rel(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_acq_rel, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_acq_rel(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_acq_rel(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_acq_rel, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_scacq_screl(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_scacq_screl, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_scacq_screl(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_scacq_screl(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_scacq_screl, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_acquire(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_acquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_acquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_acquire(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_acquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_acquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_scacquire(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_scacquire, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_scacquire(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_scacquire(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_scacquire, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_relaxed(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_relaxed, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_relaxed(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_relaxed, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_release(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_release, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_release(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_release, __hsa_data__);
	return __hsa_ret__;
}

uint64_t hsa_queue_add_write_index_screlease(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_add_write_index_screlease, __hsa_data__);
	uint64_t __hsa_ret__ = hsa_itcp_table.fn_hsa_queue_add_write_index_screlease(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_add_write_index_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_add_write_index_screlease, __hsa_data__);
	return __hsa_ret__;
}

void hsa_queue_store_read_index_relaxed(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_store_read_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_store_read_index_relaxed, __hsa_data__);
	hsa_itcp_table.fn_hsa_queue_store_read_index_relaxed(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_store_read_index_relaxed(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_store_read_index_relaxed, __hsa_data__);
	return;
}

void hsa_queue_store_read_index_release(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_store_read_index_release(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_store_read_index_release, __hsa_data__);
	hsa_itcp_table.fn_hsa_queue_store_read_index_release(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_store_read_index_release(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_store_read_index_release, __hsa_data__);
	return;
}

void hsa_queue_store_read_index_screlease(const hsa_queue_t *queue, uint64_t value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_queue_store_read_index_screlease(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_queue_store_read_index_screlease, __hsa_data__);
	hsa_itcp_table.fn_hsa_queue_store_read_index_screlease(queue, value);
	GET_CB_ARGS_DATA_hsa_queue_store_read_index_screlease(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_queue_store_read_index_screlease, __hsa_data__);
	return;
}

hsa_status_t hsa_region_get_info(hsa_region_t region, hsa_region_info_t attribute, void* value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_region_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_region_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_region_get_info(region, attribute, value);
	GET_CB_ARGS_DATA_hsa_region_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_region_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_iterate_regions(hsa_agent_t agent, hsa_status_t (*callback)(hsa_region_t region, void* data), void* data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_iterate_regions(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_iterate_regions, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_iterate_regions(agent, callback, data);
	GET_CB_ARGS_DATA_hsa_agent_iterate_regions(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_iterate_regions, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_memory_allocate(hsa_region_t region, size_t size, void** ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_memory_allocate(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_memory_allocate, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_memory_allocate(region, size, ptr);
	GET_CB_ARGS_DATA_hsa_memory_allocate(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_memory_allocate, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_memory_free(void* ptr) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_memory_free(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_memory_free, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_memory_free(ptr);
	GET_CB_ARGS_DATA_hsa_memory_free(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_memory_free, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_memory_copy(void *dst, const void *src, size_t size) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_memory_copy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_memory_copy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_memory_copy(dst, src, size);
	GET_CB_ARGS_DATA_hsa_memory_copy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_memory_copy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_memory_assign_agent(void *ptr, hsa_agent_t agent, hsa_access_permission_t access) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_memory_assign_agent(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_memory_assign_agent, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_memory_assign_agent(ptr, agent, access);
	GET_CB_ARGS_DATA_hsa_memory_assign_agent(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_memory_assign_agent, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_memory_register(void *ptr, size_t size) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_memory_register(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_memory_register, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_memory_register(ptr, size);
	GET_CB_ARGS_DATA_hsa_memory_register(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_memory_register, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_memory_deregister(void *ptr, size_t size) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_memory_deregister(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_memory_deregister, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_memory_deregister(ptr, size);
	GET_CB_ARGS_DATA_hsa_memory_deregister(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_memory_deregister, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_from_name(const char *name, hsa_isa_t *isa) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_from_name(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_from_name, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_from_name(name, isa);
	GET_CB_ARGS_DATA_hsa_isa_from_name(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_from_name, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_agent_iterate_isas(hsa_agent_t agent, hsa_status_t (*callback)(hsa_isa_t isa, void *data), void *data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_agent_iterate_isas(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_agent_iterate_isas, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_agent_iterate_isas(agent, callback, data);
	GET_CB_ARGS_DATA_hsa_agent_iterate_isas(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_agent_iterate_isas, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_get_info(hsa_isa_t isa, hsa_isa_info_t attribute, uint32_t index, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_get_info(isa, attribute, index, value);
	GET_CB_ARGS_DATA_hsa_isa_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_get_info_alt(hsa_isa_t isa, hsa_isa_info_t attribute, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_get_info_alt(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_get_info_alt, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_get_info_alt(isa, attribute, value);
	GET_CB_ARGS_DATA_hsa_isa_get_info_alt(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_get_info_alt, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_get_exception_policies(hsa_isa_t isa, hsa_profile_t profile, uint16_t *mask) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_get_exception_policies(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_get_exception_policies, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_get_exception_policies(isa, profile, mask);
	GET_CB_ARGS_DATA_hsa_isa_get_exception_policies(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_get_exception_policies, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_get_round_method(hsa_isa_t isa, hsa_fp_type_t fp_type, hsa_flush_mode_t flush_mode, hsa_round_method_t *round_method) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_get_round_method(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_get_round_method, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_get_round_method(isa, fp_type, flush_mode, round_method);
	GET_CB_ARGS_DATA_hsa_isa_get_round_method(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_get_round_method, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_wavefront_get_info(hsa_wavefront_t wavefront, hsa_wavefront_info_t attribute, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_wavefront_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_wavefront_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_wavefront_get_info(wavefront, attribute, value);
	GET_CB_ARGS_DATA_hsa_wavefront_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_wavefront_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_iterate_wavefronts(hsa_isa_t isa, hsa_status_t (*callback)(hsa_wavefront_t wavefront, void *data), void *data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_iterate_wavefronts(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_iterate_wavefronts, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_iterate_wavefronts(isa, callback, data);
	GET_CB_ARGS_DATA_hsa_isa_iterate_wavefronts(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_iterate_wavefronts, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_isa_compatible(hsa_isa_t code_object_isa, hsa_isa_t agent_isa, bool *result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_isa_compatible(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_isa_compatible, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_isa_compatible(code_object_isa, agent_isa, result);
	GET_CB_ARGS_DATA_hsa_isa_compatible(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_isa_compatible, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_reader_create_from_file(hsa_file_t file, hsa_code_object_reader_t *code_object_reader) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_reader_create_from_file(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_reader_create_from_file, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_reader_create_from_file(file, code_object_reader);
	GET_CB_ARGS_DATA_hsa_code_object_reader_create_from_file(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_reader_create_from_file, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_reader_create_from_memory(const void *code_object, size_t size, hsa_code_object_reader_t *code_object_reader) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_reader_create_from_memory(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_reader_create_from_memory, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_reader_create_from_memory(code_object, size, code_object_reader);
	GET_CB_ARGS_DATA_hsa_code_object_reader_create_from_memory(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_reader_create_from_memory, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_reader_destroy(hsa_code_object_reader_t code_object_reader) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_reader_destroy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_reader_destroy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_reader_destroy(code_object_reader);
	GET_CB_ARGS_DATA_hsa_code_object_reader_destroy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_reader_destroy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_create(hsa_profile_t profile, hsa_executable_state_t executable_state, const char *options, hsa_executable_t *executable) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_create(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_create, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_create(profile, executable_state, options, executable);
	GET_CB_ARGS_DATA_hsa_executable_create(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_create, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_create_alt(hsa_profile_t profile, hsa_default_float_rounding_mode_t default_float_rounding_mode, const char *options, hsa_executable_t *executable) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_create_alt(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_create_alt, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_create_alt(profile, default_float_rounding_mode, options, executable);
	GET_CB_ARGS_DATA_hsa_executable_create_alt(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_create_alt, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_destroy(hsa_executable_t executable) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_destroy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_destroy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_destroy(executable);
	GET_CB_ARGS_DATA_hsa_executable_destroy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_destroy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_load_program_code_object(hsa_executable_t executable, hsa_code_object_reader_t code_object_reader, const char *options, hsa_loaded_code_object_t *loaded_code_object) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_load_program_code_object(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_load_program_code_object, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_load_program_code_object(executable, code_object_reader, options, loaded_code_object);
	GET_CB_ARGS_DATA_hsa_executable_load_program_code_object(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_load_program_code_object, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_load_agent_code_object(hsa_executable_t executable, hsa_agent_t agent, hsa_code_object_reader_t code_object_reader, const char *options, hsa_loaded_code_object_t *loaded_code_object) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_load_agent_code_object(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_load_agent_code_object, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_load_agent_code_object(executable, agent, code_object_reader, options, loaded_code_object);
	GET_CB_ARGS_DATA_hsa_executable_load_agent_code_object(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_load_agent_code_object, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_freeze(hsa_executable_t executable, const char *options) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_freeze(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_freeze, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_freeze(executable, options);
	GET_CB_ARGS_DATA_hsa_executable_freeze(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_freeze, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_get_info(hsa_executable_t executable, hsa_executable_info_t attribute, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_get_info(executable, attribute, value);
	GET_CB_ARGS_DATA_hsa_executable_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_global_variable_define(hsa_executable_t executable, const char *variable_name, void *address) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_global_variable_define(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_global_variable_define, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_global_variable_define(executable, variable_name, address);
	GET_CB_ARGS_DATA_hsa_executable_global_variable_define(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_global_variable_define, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_agent_global_variable_define(hsa_executable_t executable, hsa_agent_t agent, const char *variable_name, void *address) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_agent_global_variable_define(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_agent_global_variable_define, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_agent_global_variable_define(executable, agent, variable_name, address);
	GET_CB_ARGS_DATA_hsa_executable_agent_global_variable_define(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_agent_global_variable_define, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_readonly_variable_define(hsa_executable_t executable, hsa_agent_t agent, const char *variable_name, void *address) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_readonly_variable_define(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_readonly_variable_define, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_readonly_variable_define(executable, agent, variable_name, address);
	GET_CB_ARGS_DATA_hsa_executable_readonly_variable_define(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_readonly_variable_define, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_validate(hsa_executable_t executable, uint32_t *result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_validate(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_validate, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_validate(executable, result);
	GET_CB_ARGS_DATA_hsa_executable_validate(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_validate, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_validate_alt(hsa_executable_t executable, const char *options, uint32_t *result) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_validate_alt(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_validate_alt, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_validate_alt(executable, options, result);
	GET_CB_ARGS_DATA_hsa_executable_validate_alt(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_validate_alt, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_get_symbol(hsa_executable_t executable, const char *module_name, const char *symbol_name, hsa_agent_t agent, int32_t call_convention, hsa_executable_symbol_t *symbol) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_get_symbol(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_get_symbol, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_get_symbol(executable, module_name, symbol_name, agent, call_convention, symbol);
	GET_CB_ARGS_DATA_hsa_executable_get_symbol(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_get_symbol, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_get_symbol_by_name(hsa_executable_t executable, const char *symbol_name, const hsa_agent_t *agent, hsa_executable_symbol_t *symbol) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_get_symbol_by_name(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_get_symbol_by_name, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_get_symbol_by_name(executable, symbol_name, agent, symbol);
	GET_CB_ARGS_DATA_hsa_executable_get_symbol_by_name(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_get_symbol_by_name, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_symbol_get_info(hsa_executable_symbol_t executable_symbol, hsa_executable_symbol_info_t attribute, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_symbol_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_symbol_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_symbol_get_info(executable_symbol, attribute, value);
	GET_CB_ARGS_DATA_hsa_executable_symbol_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_symbol_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_iterate_symbols(hsa_executable_t executable, hsa_status_t (*callback)(hsa_executable_t exec,hsa_executable_symbol_t symbol,void *data), void *data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_iterate_symbols(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_iterate_symbols, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_iterate_symbols(executable, callback, data);
	GET_CB_ARGS_DATA_hsa_executable_iterate_symbols(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_iterate_symbols, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_iterate_agent_symbols(hsa_executable_t executable, hsa_agent_t agent, hsa_status_t (*callback)(hsa_executable_t exec,hsa_agent_t agent,hsa_executable_symbol_t symbol,void *data), void *data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_iterate_agent_symbols(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_iterate_agent_symbols, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_iterate_agent_symbols(executable, agent, callback, data);
	GET_CB_ARGS_DATA_hsa_executable_iterate_agent_symbols(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_iterate_agent_symbols, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_iterate_program_symbols(hsa_executable_t executable, hsa_status_t (*callback)(hsa_executable_t exec,hsa_executable_symbol_t symbol,void *data), void *data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_iterate_program_symbols(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_iterate_program_symbols, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_iterate_program_symbols(executable, callback, data);
	GET_CB_ARGS_DATA_hsa_executable_iterate_program_symbols(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_iterate_program_symbols, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_serialize(hsa_code_object_t code_object, hsa_status_t (*alloc_callback)(size_t size,hsa_callback_data_t data,void **address), hsa_callback_data_t callback_data, const char *options, void **serialized_code_object, size_t *serialized_code_object_size) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_serialize(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_serialize, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_serialize(code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size);
	GET_CB_ARGS_DATA_hsa_code_object_serialize(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_serialize, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_deserialize(void *serialized_code_object, size_t serialized_code_object_size, const char *options, hsa_code_object_t *code_object) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_deserialize(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_deserialize, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_deserialize(serialized_code_object, serialized_code_object_size, options, code_object);
	GET_CB_ARGS_DATA_hsa_code_object_deserialize(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_deserialize, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_destroy(hsa_code_object_t code_object) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_destroy(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_destroy, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_destroy(code_object);
	GET_CB_ARGS_DATA_hsa_code_object_destroy(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_destroy, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_get_info(hsa_code_object_t code_object, hsa_code_object_info_t attribute, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_get_info(code_object, attribute, value);
	GET_CB_ARGS_DATA_hsa_code_object_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_executable_load_code_object(hsa_executable_t executable, hsa_agent_t agent, hsa_code_object_t code_object, const char *options) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_executable_load_code_object(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_executable_load_code_object, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_executable_load_code_object(executable, agent, code_object, options);
	GET_CB_ARGS_DATA_hsa_executable_load_code_object(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_executable_load_code_object, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_get_symbol(hsa_code_object_t code_object, const char *symbol_name, hsa_code_symbol_t *symbol) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_get_symbol(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_get_symbol, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_get_symbol(code_object, symbol_name, symbol);
	GET_CB_ARGS_DATA_hsa_code_object_get_symbol(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_get_symbol, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_get_symbol_from_name(hsa_code_object_t code_object, const char *module_name, const char *symbol_name, hsa_code_symbol_t *symbol) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_get_symbol_from_name(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_get_symbol_from_name, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_get_symbol_from_name(code_object, module_name, symbol_name, symbol);
	GET_CB_ARGS_DATA_hsa_code_object_get_symbol_from_name(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_get_symbol_from_name, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_symbol_get_info(hsa_code_symbol_t code_symbol, hsa_code_symbol_info_t attribute, void *value) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_symbol_get_info(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_symbol_get_info, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_symbol_get_info(code_symbol, attribute, value);
	GET_CB_ARGS_DATA_hsa_code_symbol_get_info(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_symbol_get_info, __hsa_data__);
	return __hsa_ret__;
}

hsa_status_t hsa_code_object_iterate_symbols(hsa_code_object_t code_object, hsa_status_t (*callback)(hsa_code_object_t code_object,hsa_code_symbol_t symbol,void *data), void *data) {
	hsa_api_data_t __hsa_data__;
	GET_CB_ARGS_DATA_hsa_code_object_iterate_symbols(__hsa_data__);
	hsa_callback_function(IS_ENTER, HSA_API_ID_hsa_code_object_iterate_symbols, __hsa_data__);
	hsa_status_t __hsa_ret__ = hsa_itcp_table.fn_hsa_code_object_iterate_symbols(code_object, callback, data);
	GET_CB_ARGS_DATA_hsa_code_object_iterate_symbols(__hsa_data__);
	hsa_callback_function(IS_EXIT, HSA_API_ID_hsa_code_object_iterate_symbols, __hsa_data__);
	return __hsa_ret__;
}

