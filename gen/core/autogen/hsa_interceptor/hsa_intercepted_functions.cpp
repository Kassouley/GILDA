#include "hsa_intercepted_functions.h"
#include "hsa_intercept_table_mgr.h"
#include "hsa_callback.h"
#include "hsa.h"
#include "hsa_ext_amd.h"

extern hsa_intercept_table_t hsa_itcp_table;

hsa_status_t hsa_amd_coherency_get_type(hsa_agent_t agent, hsa_amd_coherency_type_t* type) {
	hsa_callback_function(1, "hsa_amd_coherency_get_type");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_coherency_get_type(agent, type);
	hsa_callback_function(0, "hsa_amd_coherency_get_type");
	return ret;
}

hsa_status_t hsa_amd_coherency_set_type(hsa_agent_t agent, hsa_amd_coherency_type_t type) {
	hsa_callback_function(1, "hsa_amd_coherency_set_type");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_coherency_set_type(agent, type);
	hsa_callback_function(0, "hsa_amd_coherency_set_type");
	return ret;
}

hsa_status_t hsa_amd_profiling_set_profiler_enabled(hsa_queue_t* queue, int enable) {
	hsa_callback_function(1, "hsa_amd_profiling_set_profiler_enabled");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_profiling_set_profiler_enabled(queue, enable);
	hsa_callback_function(0, "hsa_amd_profiling_set_profiler_enabled");
	return ret;
}

hsa_status_t hsa_amd_profiling_async_copy_enable(bool enable) {
	hsa_callback_function(1, "hsa_amd_profiling_async_copy_enable");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_profiling_async_copy_enable(enable);
	hsa_callback_function(0, "hsa_amd_profiling_async_copy_enable");
	return ret;
}

hsa_status_t hsa_amd_profiling_get_dispatch_time(hsa_agent_t agent, hsa_signal_t signal, hsa_amd_profiling_dispatch_time_t* time) {
	hsa_callback_function(1, "hsa_amd_profiling_get_dispatch_time");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_profiling_get_dispatch_time(agent, signal, time);
	hsa_callback_function(0, "hsa_amd_profiling_get_dispatch_time");
	return ret;
}

hsa_status_t hsa_amd_profiling_get_async_copy_time(hsa_signal_t signal, hsa_amd_profiling_async_copy_time_t* time) {
	hsa_callback_function(1, "hsa_amd_profiling_get_async_copy_time");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_profiling_get_async_copy_time(signal, time);
	hsa_callback_function(0, "hsa_amd_profiling_get_async_copy_time");
	return ret;
}

hsa_status_t hsa_amd_profiling_convert_tick_to_system_domain(hsa_agent_t agent, uint64_t agent_tick, uint64_t* system_tick) {
	hsa_callback_function(1, "hsa_amd_profiling_convert_tick_to_system_domain");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_profiling_convert_tick_to_system_domain(agent, agent_tick, system_tick);
	hsa_callback_function(0, "hsa_amd_profiling_convert_tick_to_system_domain");
	return ret;
}

hsa_status_t hsa_amd_signal_create(hsa_signal_value_t initial_value, uint32_t num_consumers, const hsa_agent_t* consumers, uint64_t attributes, hsa_signal_t* signal) {
	hsa_callback_function(1, "hsa_amd_signal_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_signal_create(initial_value, num_consumers, consumers, attributes, signal);
	hsa_callback_function(0, "hsa_amd_signal_create");
	return ret;
}

hsa_status_t hsa_amd_signal_value_pointer(hsa_signal_t signal, volatile hsa_signal_value_t** value_ptr) {
	hsa_callback_function(1, "hsa_amd_signal_value_pointer");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_signal_value_pointer(signal, value_ptr);
	hsa_callback_function(0, "hsa_amd_signal_value_pointer");
	return ret;
}

hsa_status_t hsa_amd_signal_async_handler(hsa_signal_t signal, hsa_signal_condition_t cond, hsa_signal_value_t value, hsa_amd_signal_handler handler, void* arg) {
	hsa_callback_function(1, "hsa_amd_signal_async_handler");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_signal_async_handler(signal, cond, value, handler, arg);
	hsa_callback_function(0, "hsa_amd_signal_async_handler");
	return ret;
}

hsa_status_t hsa_amd_async_function(void (*callback)(void* arg), void* arg) {
	hsa_callback_function(1, "hsa_amd_async_function");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_async_function(callback, arg);
	hsa_callback_function(0, "hsa_amd_async_function");
	return ret;
}

uint32_t hsa_amd_signal_wait_any(uint32_t signal_count, hsa_signal_t* signals, hsa_signal_condition_t* conds, hsa_signal_value_t* values, uint64_t timeout_hint, hsa_wait_state_t wait_hint, hsa_signal_value_t* satisfying_value) {
	hsa_callback_function(1, "hsa_amd_signal_wait_any");
	uint32_t ret = hsa_itcp_table.fn_hsa_amd_signal_wait_any(signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value);
	hsa_callback_function(0, "hsa_amd_signal_wait_any");
	return ret;
}

hsa_status_t hsa_amd_image_get_info_max_dim(hsa_agent_t agent, hsa_agent_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_amd_image_get_info_max_dim");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_image_get_info_max_dim(agent, attribute, value);
	hsa_callback_function(0, "hsa_amd_image_get_info_max_dim");
	return ret;
}

hsa_status_t hsa_amd_queue_cu_set_mask(const hsa_queue_t* queue, uint32_t num_cu_mask_count, const uint32_t* cu_mask) {
	hsa_callback_function(1, "hsa_amd_queue_cu_set_mask");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_queue_cu_set_mask(queue, num_cu_mask_count, cu_mask);
	hsa_callback_function(0, "hsa_amd_queue_cu_set_mask");
	return ret;
}

hsa_status_t hsa_amd_queue_cu_get_mask(const hsa_queue_t* queue, uint32_t num_cu_mask_count, uint32_t* cu_mask) {
	hsa_callback_function(1, "hsa_amd_queue_cu_get_mask");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_queue_cu_get_mask(queue, num_cu_mask_count, cu_mask);
	hsa_callback_function(0, "hsa_amd_queue_cu_get_mask");
	return ret;
}

hsa_status_t hsa_amd_memory_pool_get_info(hsa_amd_memory_pool_t memory_pool, hsa_amd_memory_pool_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_amd_memory_pool_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_pool_get_info(memory_pool, attribute, value);
	hsa_callback_function(0, "hsa_amd_memory_pool_get_info");
	return ret;
}

hsa_status_t hsa_amd_agent_iterate_memory_pools(hsa_agent_t agent, hsa_status_t (*callback)(hsa_amd_memory_pool_t memory_pool, void* data), void* data) {
	hsa_callback_function(1, "hsa_amd_agent_iterate_memory_pools");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_agent_iterate_memory_pools(agent, callback, data);
	hsa_callback_function(0, "hsa_amd_agent_iterate_memory_pools");
	return ret;
}

hsa_status_t hsa_amd_memory_pool_allocate(hsa_amd_memory_pool_t memory_pool, size_t size, uint32_t flags, void** ptr) {
	hsa_callback_function(1, "hsa_amd_memory_pool_allocate");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_pool_allocate(memory_pool, size, flags, ptr);
	hsa_callback_function(0, "hsa_amd_memory_pool_allocate");
	return ret;
}

hsa_status_t hsa_amd_memory_pool_free(void* ptr) {
	hsa_callback_function(1, "hsa_amd_memory_pool_free");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_pool_free(ptr);
	hsa_callback_function(0, "hsa_amd_memory_pool_free");
	return ret;
}

hsa_status_t hsa_amd_memory_async_copy(void* dst, hsa_agent_t dst_agent, const void* src, hsa_agent_t src_agent, size_t size, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal) {
	hsa_callback_function(1, "hsa_amd_memory_async_copy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_async_copy(dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal);
	hsa_callback_function(0, "hsa_amd_memory_async_copy");
	return ret;
}

hsa_status_t hsa_amd_memory_async_copy_on_engine(void* dst, hsa_agent_t dst_agent, const void* src, hsa_agent_t src_agent, size_t size, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal, hsa_amd_sdma_engine_id_t engine_id, bool force_copy_on_sdma) {
	hsa_callback_function(1, "hsa_amd_memory_async_copy_on_engine");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_async_copy_on_engine(dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal, engine_id, force_copy_on_sdma);
	hsa_callback_function(0, "hsa_amd_memory_async_copy_on_engine");
	return ret;
}

hsa_status_t hsa_amd_memory_copy_engine_status(hsa_agent_t dst_agent, hsa_agent_t src_agent, uint32_t *engine_ids_mask) {
	hsa_callback_function(1, "hsa_amd_memory_copy_engine_status");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_copy_engine_status(dst_agent, src_agent, engine_ids_mask);
	hsa_callback_function(0, "hsa_amd_memory_copy_engine_status");
	return ret;
}

hsa_status_t hsa_amd_memory_async_copy_rect(const hsa_pitched_ptr_t* dst, const hsa_dim3_t* dst_offset, const hsa_pitched_ptr_t* src, const hsa_dim3_t* src_offset, const hsa_dim3_t* range, hsa_agent_t copy_agent, hsa_amd_copy_direction_t dir, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal) {
	hsa_callback_function(1, "hsa_amd_memory_async_copy_rect");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_async_copy_rect(dst, dst_offset, src, src_offset, range, copy_agent, dir, num_dep_signals, dep_signals, completion_signal);
	hsa_callback_function(0, "hsa_amd_memory_async_copy_rect");
	return ret;
}

hsa_status_t hsa_amd_agent_memory_pool_get_info(hsa_agent_t agent, hsa_amd_memory_pool_t memory_pool, hsa_amd_agent_memory_pool_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_amd_agent_memory_pool_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_agent_memory_pool_get_info(agent, memory_pool, attribute, value);
	hsa_callback_function(0, "hsa_amd_agent_memory_pool_get_info");
	return ret;
}

hsa_status_t hsa_amd_agents_allow_access(uint32_t num_agents, const hsa_agent_t* agents, const uint32_t* flags, const void* ptr) {
	hsa_callback_function(1, "hsa_amd_agents_allow_access");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_agents_allow_access(num_agents, agents, flags, ptr);
	hsa_callback_function(0, "hsa_amd_agents_allow_access");
	return ret;
}

hsa_status_t hsa_amd_memory_pool_can_migrate(hsa_amd_memory_pool_t src_memory_pool, hsa_amd_memory_pool_t dst_memory_pool, bool* result) {
	hsa_callback_function(1, "hsa_amd_memory_pool_can_migrate");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_pool_can_migrate(src_memory_pool, dst_memory_pool, result);
	hsa_callback_function(0, "hsa_amd_memory_pool_can_migrate");
	return ret;
}

hsa_status_t hsa_amd_memory_migrate(const void* ptr, hsa_amd_memory_pool_t memory_pool, uint32_t flags) {
	hsa_callback_function(1, "hsa_amd_memory_migrate");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_migrate(ptr, memory_pool, flags);
	hsa_callback_function(0, "hsa_amd_memory_migrate");
	return ret;
}

hsa_status_t hsa_amd_memory_lock(void* host_ptr, size_t size, hsa_agent_t* agents, int num_agent, void** agent_ptr) {
	hsa_callback_function(1, "hsa_amd_memory_lock");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_lock(host_ptr, size, agents, num_agent, agent_ptr);
	hsa_callback_function(0, "hsa_amd_memory_lock");
	return ret;
}

hsa_status_t hsa_amd_memory_lock_to_pool(void* host_ptr, size_t size, hsa_agent_t* agents, int num_agent, hsa_amd_memory_pool_t pool, uint32_t flags, void** agent_ptr) {
	hsa_callback_function(1, "hsa_amd_memory_lock_to_pool");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_lock_to_pool(host_ptr, size, agents, num_agent, pool, flags, agent_ptr);
	hsa_callback_function(0, "hsa_amd_memory_lock_to_pool");
	return ret;
}

hsa_status_t hsa_amd_memory_unlock(void* host_ptr) {
	hsa_callback_function(1, "hsa_amd_memory_unlock");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_unlock(host_ptr);
	hsa_callback_function(0, "hsa_amd_memory_unlock");
	return ret;
}

hsa_status_t hsa_amd_memory_fill(void* ptr, uint32_t value, size_t count) {
	hsa_callback_function(1, "hsa_amd_memory_fill");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_memory_fill(ptr, value, count);
	hsa_callback_function(0, "hsa_amd_memory_fill");
	return ret;
}

hsa_status_t hsa_amd_interop_map_buffer(uint32_t num_agents, hsa_agent_t* agents, int interop_handle, uint32_t flags, size_t* size, void** ptr, size_t* metadata_size, const void** metadata) {
	hsa_callback_function(1, "hsa_amd_interop_map_buffer");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_interop_map_buffer(num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata);
	hsa_callback_function(0, "hsa_amd_interop_map_buffer");
	return ret;
}

hsa_status_t hsa_amd_interop_unmap_buffer(void* ptr) {
	hsa_callback_function(1, "hsa_amd_interop_unmap_buffer");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_interop_unmap_buffer(ptr);
	hsa_callback_function(0, "hsa_amd_interop_unmap_buffer");
	return ret;
}

hsa_status_t hsa_amd_image_create(hsa_agent_t agent, const hsa_ext_image_descriptor_t *image_descriptor, const hsa_amd_image_descriptor_t *image_layout, const void *image_data, hsa_access_permission_t access_permission, hsa_ext_image_t *image) {
	hsa_callback_function(1, "hsa_amd_image_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_image_create(agent, image_descriptor, image_layout, image_data, access_permission, image);
	hsa_callback_function(0, "hsa_amd_image_create");
	return ret;
}

hsa_status_t hsa_amd_pointer_info(const void* ptr, hsa_amd_pointer_info_t* info, void* (*alloc)(size_t), uint32_t* num_agents_accessible, hsa_agent_t** accessible) {
	hsa_callback_function(1, "hsa_amd_pointer_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_pointer_info(ptr, info, alloc, num_agents_accessible, accessible);
	hsa_callback_function(0, "hsa_amd_pointer_info");
	return ret;
}

hsa_status_t hsa_amd_pointer_info_set_userdata(const void* ptr, void* userdata) {
	hsa_callback_function(1, "hsa_amd_pointer_info_set_userdata");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_pointer_info_set_userdata(ptr, userdata);
	hsa_callback_function(0, "hsa_amd_pointer_info_set_userdata");
	return ret;
}

hsa_status_t hsa_amd_ipc_memory_create(void* ptr, size_t len, hsa_amd_ipc_memory_t* handle) {
	hsa_callback_function(1, "hsa_amd_ipc_memory_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_ipc_memory_create(ptr, len, handle);
	hsa_callback_function(0, "hsa_amd_ipc_memory_create");
	return ret;
}

hsa_status_t hsa_amd_ipc_memory_attach(const hsa_amd_ipc_memory_t* handle, size_t len, uint32_t num_agents, const hsa_agent_t* mapping_agents, void** mapped_ptr) {
	hsa_callback_function(1, "hsa_amd_ipc_memory_attach");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_ipc_memory_attach(handle, len, num_agents, mapping_agents, mapped_ptr);
	hsa_callback_function(0, "hsa_amd_ipc_memory_attach");
	return ret;
}

hsa_status_t hsa_amd_ipc_memory_detach(void* mapped_ptr) {
	hsa_callback_function(1, "hsa_amd_ipc_memory_detach");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_ipc_memory_detach(mapped_ptr);
	hsa_callback_function(0, "hsa_amd_ipc_memory_detach");
	return ret;
}

hsa_status_t hsa_amd_ipc_signal_create(hsa_signal_t signal, hsa_amd_ipc_signal_t* handle) {
	hsa_callback_function(1, "hsa_amd_ipc_signal_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_ipc_signal_create(signal, handle);
	hsa_callback_function(0, "hsa_amd_ipc_signal_create");
	return ret;
}

hsa_status_t hsa_amd_ipc_signal_attach(const hsa_amd_ipc_signal_t* handle, hsa_signal_t* signal) {
	hsa_callback_function(1, "hsa_amd_ipc_signal_attach");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_ipc_signal_attach(handle, signal);
	hsa_callback_function(0, "hsa_amd_ipc_signal_attach");
	return ret;
}

hsa_status_t hsa_amd_register_system_event_handler(hsa_amd_system_event_callback_t callback, void* data) {
	hsa_callback_function(1, "hsa_amd_register_system_event_handler");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_register_system_event_handler(callback, data);
	hsa_callback_function(0, "hsa_amd_register_system_event_handler");
	return ret;
}

hsa_status_t hsa_amd_queue_set_priority(hsa_queue_t* queue, hsa_amd_queue_priority_t priority) {
	hsa_callback_function(1, "hsa_amd_queue_set_priority");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_queue_set_priority(queue, priority);
	hsa_callback_function(0, "hsa_amd_queue_set_priority");
	return ret;
}

hsa_status_t hsa_amd_register_deallocation_callback(void* ptr, hsa_amd_deallocation_callback_t callback, void* user_data) {
	hsa_callback_function(1, "hsa_amd_register_deallocation_callback");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_register_deallocation_callback(ptr, callback, user_data);
	hsa_callback_function(0, "hsa_amd_register_deallocation_callback");
	return ret;
}

hsa_status_t hsa_amd_deregister_deallocation_callback(void* ptr, hsa_amd_deallocation_callback_t callback) {
	hsa_callback_function(1, "hsa_amd_deregister_deallocation_callback");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_deregister_deallocation_callback(ptr, callback);
	hsa_callback_function(0, "hsa_amd_deregister_deallocation_callback");
	return ret;
}

hsa_status_t hsa_amd_svm_attributes_set(void* ptr, size_t size, hsa_amd_svm_attribute_pair_t* attribute_list, size_t attribute_count) {
	hsa_callback_function(1, "hsa_amd_svm_attributes_set");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_svm_attributes_set(ptr, size, attribute_list, attribute_count);
	hsa_callback_function(0, "hsa_amd_svm_attributes_set");
	return ret;
}

hsa_status_t hsa_amd_svm_attributes_get(void* ptr, size_t size, hsa_amd_svm_attribute_pair_t* attribute_list, size_t attribute_count) {
	hsa_callback_function(1, "hsa_amd_svm_attributes_get");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_svm_attributes_get(ptr, size, attribute_list, attribute_count);
	hsa_callback_function(0, "hsa_amd_svm_attributes_get");
	return ret;
}

hsa_status_t hsa_amd_svm_prefetch_async(void* ptr, size_t size, hsa_agent_t agent, uint32_t num_dep_signals, const hsa_signal_t* dep_signals, hsa_signal_t completion_signal) {
	hsa_callback_function(1, "hsa_amd_svm_prefetch_async");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_svm_prefetch_async(ptr, size, agent, num_dep_signals, dep_signals, completion_signal);
	hsa_callback_function(0, "hsa_amd_svm_prefetch_async");
	return ret;
}

hsa_status_t hsa_amd_spm_acquire(hsa_agent_t preferred_agent) {
	hsa_callback_function(1, "hsa_amd_spm_acquire");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_spm_acquire(preferred_agent);
	hsa_callback_function(0, "hsa_amd_spm_acquire");
	return ret;
}

hsa_status_t hsa_amd_spm_release(hsa_agent_t preferred_agent) {
	hsa_callback_function(1, "hsa_amd_spm_release");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_spm_release(preferred_agent);
	hsa_callback_function(0, "hsa_amd_spm_release");
	return ret;
}

hsa_status_t hsa_amd_spm_set_dest_buffer(hsa_agent_t preferred_agent, size_t size_in_bytes, uint32_t* timeout, uint32_t* size_copied, void* dest, bool* is_data_loss) {
	hsa_callback_function(1, "hsa_amd_spm_set_dest_buffer");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_spm_set_dest_buffer(preferred_agent, size_in_bytes, timeout, size_copied, dest, is_data_loss);
	hsa_callback_function(0, "hsa_amd_spm_set_dest_buffer");
	return ret;
}

hsa_status_t hsa_amd_portable_export_dmabuf(const void* ptr, size_t size, int* dmabuf, uint64_t* offset) {
	hsa_callback_function(1, "hsa_amd_portable_export_dmabuf");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_portable_export_dmabuf(ptr, size, dmabuf, offset);
	hsa_callback_function(0, "hsa_amd_portable_export_dmabuf");
	return ret;
}

hsa_status_t hsa_amd_portable_close_dmabuf(int dmabuf) {
	hsa_callback_function(1, "hsa_amd_portable_close_dmabuf");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_portable_close_dmabuf(dmabuf);
	hsa_callback_function(0, "hsa_amd_portable_close_dmabuf");
	return ret;
}

hsa_status_t hsa_amd_vmem_address_reserve(void** va, size_t size, uint64_t address, uint64_t flags) {
	hsa_callback_function(1, "hsa_amd_vmem_address_reserve");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_address_reserve(va, size, address, flags);
	hsa_callback_function(0, "hsa_amd_vmem_address_reserve");
	return ret;
}

hsa_status_t hsa_amd_vmem_address_free(void* va, size_t size) {
	hsa_callback_function(1, "hsa_amd_vmem_address_free");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_address_free(va, size);
	hsa_callback_function(0, "hsa_amd_vmem_address_free");
	return ret;
}

hsa_status_t hsa_amd_vmem_handle_create(hsa_amd_memory_pool_t pool, size_t size, hsa_amd_memory_type_t type, uint64_t flags, hsa_amd_vmem_alloc_handle_t* memory_handle) {
	hsa_callback_function(1, "hsa_amd_vmem_handle_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_handle_create(pool, size, type, flags, memory_handle);
	hsa_callback_function(0, "hsa_amd_vmem_handle_create");
	return ret;
}

hsa_status_t hsa_amd_vmem_handle_release(hsa_amd_vmem_alloc_handle_t memory_handle) {
	hsa_callback_function(1, "hsa_amd_vmem_handle_release");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_handle_release(memory_handle);
	hsa_callback_function(0, "hsa_amd_vmem_handle_release");
	return ret;
}

hsa_status_t hsa_amd_vmem_map(void* va, size_t size, size_t in_offset, hsa_amd_vmem_alloc_handle_t memory_handle, uint64_t flags) {
	hsa_callback_function(1, "hsa_amd_vmem_map");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_map(va, size, in_offset, memory_handle, flags);
	hsa_callback_function(0, "hsa_amd_vmem_map");
	return ret;
}

hsa_status_t hsa_amd_vmem_unmap(void* va, size_t size) {
	hsa_callback_function(1, "hsa_amd_vmem_unmap");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_unmap(va, size);
	hsa_callback_function(0, "hsa_amd_vmem_unmap");
	return ret;
}

hsa_status_t hsa_amd_vmem_set_access(void* va, size_t size, const hsa_amd_memory_access_desc_t* desc, size_t desc_cnt) {
	hsa_callback_function(1, "hsa_amd_vmem_set_access");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_set_access(va, size, desc, desc_cnt);
	hsa_callback_function(0, "hsa_amd_vmem_set_access");
	return ret;
}

hsa_status_t hsa_amd_vmem_get_access(void* va, hsa_access_permission_t* perms, hsa_agent_t agent_handle) {
	hsa_callback_function(1, "hsa_amd_vmem_get_access");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_get_access(va, perms, agent_handle);
	hsa_callback_function(0, "hsa_amd_vmem_get_access");
	return ret;
}

hsa_status_t hsa_amd_vmem_export_shareable_handle(int* dmabuf_fd, hsa_amd_vmem_alloc_handle_t handle, uint64_t flags) {
	hsa_callback_function(1, "hsa_amd_vmem_export_shareable_handle");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_export_shareable_handle(dmabuf_fd, handle, flags);
	hsa_callback_function(0, "hsa_amd_vmem_export_shareable_handle");
	return ret;
}

hsa_status_t hsa_amd_vmem_import_shareable_handle(int dmabuf_fd, hsa_amd_vmem_alloc_handle_t* handle) {
	hsa_callback_function(1, "hsa_amd_vmem_import_shareable_handle");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_import_shareable_handle(dmabuf_fd, handle);
	hsa_callback_function(0, "hsa_amd_vmem_import_shareable_handle");
	return ret;
}

hsa_status_t hsa_amd_vmem_retain_alloc_handle(hsa_amd_vmem_alloc_handle_t* memory_handle, void* addr) {
	hsa_callback_function(1, "hsa_amd_vmem_retain_alloc_handle");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_retain_alloc_handle(memory_handle, addr);
	hsa_callback_function(0, "hsa_amd_vmem_retain_alloc_handle");
	return ret;
}

hsa_status_t hsa_amd_vmem_get_alloc_properties_from_handle(hsa_amd_vmem_alloc_handle_t memory_handle, hsa_amd_memory_pool_t* pool, hsa_amd_memory_type_t* type) {
	hsa_callback_function(1, "hsa_amd_vmem_get_alloc_properties_from_handle");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_vmem_get_alloc_properties_from_handle(memory_handle, pool, type);
	hsa_callback_function(0, "hsa_amd_vmem_get_alloc_properties_from_handle");
	return ret;
}

hsa_status_t hsa_amd_agent_set_async_scratch_limit(hsa_agent_t agent, size_t threshold) {
	hsa_callback_function(1, "hsa_amd_agent_set_async_scratch_limit");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_amd_agent_set_async_scratch_limit(agent, threshold);
	hsa_callback_function(0, "hsa_amd_agent_set_async_scratch_limit");
	return ret;
}

hsa_status_t hsa_status_string(hsa_status_t status, const char ** status_string) {
	hsa_callback_function(1, "hsa_status_string");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_status_string(status, status_string);
	hsa_callback_function(0, "hsa_status_string");
	return ret;
}

hsa_status_t hsa_init() {
	hsa_callback_function(1, "hsa_init");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_init();
	hsa_callback_function(0, "hsa_init");
	return ret;
}

hsa_status_t hsa_shut_down() {
	hsa_callback_function(1, "hsa_shut_down");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_shut_down();
	hsa_callback_function(0, "hsa_shut_down");
	return ret;
}

hsa_status_t hsa_system_get_info(hsa_system_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_system_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_system_get_info(attribute, value);
	hsa_callback_function(0, "hsa_system_get_info");
	return ret;
}

hsa_status_t hsa_extension_get_name(uint16_t extension, const char **name) {
	hsa_callback_function(1, "hsa_extension_get_name");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_extension_get_name(extension, name);
	hsa_callback_function(0, "hsa_extension_get_name");
	return ret;
}

hsa_status_t hsa_system_extension_supported(uint16_t extension, uint16_t version_major, uint16_t version_minor, bool* result) {
	hsa_callback_function(1, "hsa_system_extension_supported");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_system_extension_supported(extension, version_major, version_minor, result);
	hsa_callback_function(0, "hsa_system_extension_supported");
	return ret;
}

hsa_status_t hsa_system_major_extension_supported(uint16_t extension, uint16_t version_major, uint16_t *version_minor, bool* result) {
	hsa_callback_function(1, "hsa_system_major_extension_supported");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_system_major_extension_supported(extension, version_major, version_minor, result);
	hsa_callback_function(0, "hsa_system_major_extension_supported");
	return ret;
}

hsa_status_t hsa_system_get_extension_table(uint16_t extension, uint16_t version_major, uint16_t version_minor, void *table) {
	hsa_callback_function(1, "hsa_system_get_extension_table");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_system_get_extension_table(extension, version_major, version_minor, table);
	hsa_callback_function(0, "hsa_system_get_extension_table");
	return ret;
}

hsa_status_t hsa_system_get_major_extension_table(uint16_t extension, uint16_t version_major, size_t table_length, void *table) {
	hsa_callback_function(1, "hsa_system_get_major_extension_table");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_system_get_major_extension_table(extension, version_major, table_length, table);
	hsa_callback_function(0, "hsa_system_get_major_extension_table");
	return ret;
}

hsa_status_t hsa_agent_get_info(hsa_agent_t agent, hsa_agent_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_agent_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_get_info(agent, attribute, value);
	hsa_callback_function(0, "hsa_agent_get_info");
	return ret;
}

hsa_status_t hsa_iterate_agents(hsa_status_t (*callback)(hsa_agent_t agent, void* data), void* data) {
	hsa_callback_function(1, "hsa_iterate_agents");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_iterate_agents(callback, data);
	hsa_callback_function(0, "hsa_iterate_agents");
	return ret;
}

hsa_status_t hsa_agent_get_exception_policies(hsa_agent_t agent, hsa_profile_t profile, uint16_t *mask) {
	hsa_callback_function(1, "hsa_agent_get_exception_policies");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_get_exception_policies(agent, profile, mask);
	hsa_callback_function(0, "hsa_agent_get_exception_policies");
	return ret;
}

hsa_status_t hsa_cache_get_info(hsa_cache_t cache, hsa_cache_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_cache_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_cache_get_info(cache, attribute, value);
	hsa_callback_function(0, "hsa_cache_get_info");
	return ret;
}

hsa_status_t hsa_agent_iterate_caches(hsa_agent_t agent, hsa_status_t (*callback)(hsa_cache_t cache, void* data), void* data) {
	hsa_callback_function(1, "hsa_agent_iterate_caches");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_iterate_caches(agent, callback, data);
	hsa_callback_function(0, "hsa_agent_iterate_caches");
	return ret;
}

hsa_status_t hsa_agent_extension_supported(uint16_t extension, hsa_agent_t agent, uint16_t version_major, uint16_t version_minor, bool* result) {
	hsa_callback_function(1, "hsa_agent_extension_supported");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_extension_supported(extension, agent, version_major, version_minor, result);
	hsa_callback_function(0, "hsa_agent_extension_supported");
	return ret;
}

hsa_status_t hsa_agent_major_extension_supported(uint16_t extension, hsa_agent_t agent, uint16_t version_major, uint16_t *version_minor, bool* result) {
	hsa_callback_function(1, "hsa_agent_major_extension_supported");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_major_extension_supported(extension, agent, version_major, version_minor, result);
	hsa_callback_function(0, "hsa_agent_major_extension_supported");
	return ret;
}

hsa_status_t hsa_signal_create(hsa_signal_value_t initial_value, uint32_t num_consumers, const hsa_agent_t *consumers, hsa_signal_t *signal) {
	hsa_callback_function(1, "hsa_signal_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_signal_create(initial_value, num_consumers, consumers, signal);
	hsa_callback_function(0, "hsa_signal_create");
	return ret;
}

hsa_status_t hsa_signal_destroy(hsa_signal_t signal) {
	hsa_callback_function(1, "hsa_signal_destroy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_signal_destroy(signal);
	hsa_callback_function(0, "hsa_signal_destroy");
	return ret;
}

hsa_signal_value_t hsa_signal_load_scacquire(hsa_signal_t signal) {
	hsa_callback_function(1, "hsa_signal_load_scacquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_load_scacquire(signal);
	hsa_callback_function(0, "hsa_signal_load_scacquire");
	return ret;
}

hsa_signal_value_t hsa_signal_load_relaxed(hsa_signal_t signal) {
	hsa_callback_function(1, "hsa_signal_load_relaxed");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_load_relaxed(signal);
	hsa_callback_function(0, "hsa_signal_load_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_load_acquire(hsa_signal_t signal) {
	hsa_callback_function(1, "hsa_signal_load_acquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_load_acquire(signal);
	hsa_callback_function(0, "hsa_signal_load_acquire");
	return ret;
}

void hsa_signal_store_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_store_relaxed");
	hsa_itcp_table.fn_hsa_signal_store_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_store_relaxed");
	return;
}

void hsa_signal_store_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_store_screlease");
	hsa_itcp_table.fn_hsa_signal_store_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_store_screlease");
	return;
}

void hsa_signal_store_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_store_release");
	hsa_itcp_table.fn_hsa_signal_store_release(signal, value);
	hsa_callback_function(0, "hsa_signal_store_release");
	return;
}

void hsa_signal_silent_store_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_silent_store_relaxed");
	hsa_itcp_table.fn_hsa_signal_silent_store_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_silent_store_relaxed");
	return;
}

void hsa_signal_silent_store_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_silent_store_screlease");
	hsa_itcp_table.fn_hsa_signal_silent_store_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_silent_store_screlease");
	return;
}

hsa_signal_value_t hsa_signal_exchange_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_scacq_screl");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_scacq_screl(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_scacq_screl");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_acq_rel");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_acq_rel(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_acq_rel");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_scacquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_scacquire(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_scacquire");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_acquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_acquire(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_acquire");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_relaxed");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_screlease");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_screlease");
	return ret;
}

hsa_signal_value_t hsa_signal_exchange_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_exchange_release");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_exchange_release(signal, value);
	hsa_callback_function(0, "hsa_signal_exchange_release");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_scacq_screl(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_scacq_screl");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_scacq_screl(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_scacq_screl");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_acq_rel(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_acq_rel");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_acq_rel(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_acq_rel");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_scacquire(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_scacquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_scacquire(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_scacquire");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_acquire(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_acquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_acquire(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_acquire");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_relaxed(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_relaxed");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_relaxed(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_screlease(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_screlease");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_screlease(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_screlease");
	return ret;
}

hsa_signal_value_t hsa_signal_cas_release(hsa_signal_t signal, hsa_signal_value_t expected, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_cas_release");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_cas_release(signal, expected, value);
	hsa_callback_function(0, "hsa_signal_cas_release");
	return ret;
}

void hsa_signal_add_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_scacq_screl");
	hsa_itcp_table.fn_hsa_signal_add_scacq_screl(signal, value);
	hsa_callback_function(0, "hsa_signal_add_scacq_screl");
	return;
}

void hsa_signal_add_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_acq_rel");
	hsa_itcp_table.fn_hsa_signal_add_acq_rel(signal, value);
	hsa_callback_function(0, "hsa_signal_add_acq_rel");
	return;
}

void hsa_signal_add_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_scacquire");
	hsa_itcp_table.fn_hsa_signal_add_scacquire(signal, value);
	hsa_callback_function(0, "hsa_signal_add_scacquire");
	return;
}

void hsa_signal_add_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_acquire");
	hsa_itcp_table.fn_hsa_signal_add_acquire(signal, value);
	hsa_callback_function(0, "hsa_signal_add_acquire");
	return;
}

void hsa_signal_add_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_relaxed");
	hsa_itcp_table.fn_hsa_signal_add_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_add_relaxed");
	return;
}

void hsa_signal_add_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_screlease");
	hsa_itcp_table.fn_hsa_signal_add_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_add_screlease");
	return;
}

void hsa_signal_add_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_add_release");
	hsa_itcp_table.fn_hsa_signal_add_release(signal, value);
	hsa_callback_function(0, "hsa_signal_add_release");
	return;
}

void hsa_signal_subtract_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_scacq_screl");
	hsa_itcp_table.fn_hsa_signal_subtract_scacq_screl(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_scacq_screl");
	return;
}

void hsa_signal_subtract_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_acq_rel");
	hsa_itcp_table.fn_hsa_signal_subtract_acq_rel(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_acq_rel");
	return;
}

void hsa_signal_subtract_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_scacquire");
	hsa_itcp_table.fn_hsa_signal_subtract_scacquire(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_scacquire");
	return;
}

void hsa_signal_subtract_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_acquire");
	hsa_itcp_table.fn_hsa_signal_subtract_acquire(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_acquire");
	return;
}

void hsa_signal_subtract_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_relaxed");
	hsa_itcp_table.fn_hsa_signal_subtract_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_relaxed");
	return;
}

void hsa_signal_subtract_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_screlease");
	hsa_itcp_table.fn_hsa_signal_subtract_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_screlease");
	return;
}

void hsa_signal_subtract_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_subtract_release");
	hsa_itcp_table.fn_hsa_signal_subtract_release(signal, value);
	hsa_callback_function(0, "hsa_signal_subtract_release");
	return;
}

void hsa_signal_and_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_scacq_screl");
	hsa_itcp_table.fn_hsa_signal_and_scacq_screl(signal, value);
	hsa_callback_function(0, "hsa_signal_and_scacq_screl");
	return;
}

void hsa_signal_and_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_acq_rel");
	hsa_itcp_table.fn_hsa_signal_and_acq_rel(signal, value);
	hsa_callback_function(0, "hsa_signal_and_acq_rel");
	return;
}

void hsa_signal_and_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_scacquire");
	hsa_itcp_table.fn_hsa_signal_and_scacquire(signal, value);
	hsa_callback_function(0, "hsa_signal_and_scacquire");
	return;
}

void hsa_signal_and_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_acquire");
	hsa_itcp_table.fn_hsa_signal_and_acquire(signal, value);
	hsa_callback_function(0, "hsa_signal_and_acquire");
	return;
}

void hsa_signal_and_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_relaxed");
	hsa_itcp_table.fn_hsa_signal_and_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_and_relaxed");
	return;
}

void hsa_signal_and_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_screlease");
	hsa_itcp_table.fn_hsa_signal_and_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_and_screlease");
	return;
}

void hsa_signal_and_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_and_release");
	hsa_itcp_table.fn_hsa_signal_and_release(signal, value);
	hsa_callback_function(0, "hsa_signal_and_release");
	return;
}

void hsa_signal_or_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_scacq_screl");
	hsa_itcp_table.fn_hsa_signal_or_scacq_screl(signal, value);
	hsa_callback_function(0, "hsa_signal_or_scacq_screl");
	return;
}

void hsa_signal_or_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_acq_rel");
	hsa_itcp_table.fn_hsa_signal_or_acq_rel(signal, value);
	hsa_callback_function(0, "hsa_signal_or_acq_rel");
	return;
}

void hsa_signal_or_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_scacquire");
	hsa_itcp_table.fn_hsa_signal_or_scacquire(signal, value);
	hsa_callback_function(0, "hsa_signal_or_scacquire");
	return;
}

void hsa_signal_or_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_acquire");
	hsa_itcp_table.fn_hsa_signal_or_acquire(signal, value);
	hsa_callback_function(0, "hsa_signal_or_acquire");
	return;
}

void hsa_signal_or_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_relaxed");
	hsa_itcp_table.fn_hsa_signal_or_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_or_relaxed");
	return;
}

void hsa_signal_or_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_screlease");
	hsa_itcp_table.fn_hsa_signal_or_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_or_screlease");
	return;
}

void hsa_signal_or_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_or_release");
	hsa_itcp_table.fn_hsa_signal_or_release(signal, value);
	hsa_callback_function(0, "hsa_signal_or_release");
	return;
}

void hsa_signal_xor_scacq_screl(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_scacq_screl");
	hsa_itcp_table.fn_hsa_signal_xor_scacq_screl(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_scacq_screl");
	return;
}

void hsa_signal_xor_acq_rel(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_acq_rel");
	hsa_itcp_table.fn_hsa_signal_xor_acq_rel(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_acq_rel");
	return;
}

void hsa_signal_xor_scacquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_scacquire");
	hsa_itcp_table.fn_hsa_signal_xor_scacquire(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_scacquire");
	return;
}

void hsa_signal_xor_acquire(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_acquire");
	hsa_itcp_table.fn_hsa_signal_xor_acquire(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_acquire");
	return;
}

void hsa_signal_xor_relaxed(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_relaxed");
	hsa_itcp_table.fn_hsa_signal_xor_relaxed(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_relaxed");
	return;
}

void hsa_signal_xor_screlease(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_screlease");
	hsa_itcp_table.fn_hsa_signal_xor_screlease(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_screlease");
	return;
}

void hsa_signal_xor_release(hsa_signal_t signal, hsa_signal_value_t value) {
	hsa_callback_function(1, "hsa_signal_xor_release");
	hsa_itcp_table.fn_hsa_signal_xor_release(signal, value);
	hsa_callback_function(0, "hsa_signal_xor_release");
	return;
}

hsa_signal_value_t hsa_signal_wait_scacquire(hsa_signal_t signal, hsa_signal_condition_t condition, hsa_signal_value_t compare_value, uint64_t timeout_hint, hsa_wait_state_t wait_state_hint) {
	hsa_callback_function(1, "hsa_signal_wait_scacquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_wait_scacquire(signal, condition, compare_value, timeout_hint, wait_state_hint);
	hsa_callback_function(0, "hsa_signal_wait_scacquire");
	return ret;
}

hsa_signal_value_t hsa_signal_wait_relaxed(hsa_signal_t signal, hsa_signal_condition_t condition, hsa_signal_value_t compare_value, uint64_t timeout_hint, hsa_wait_state_t wait_state_hint) {
	hsa_callback_function(1, "hsa_signal_wait_relaxed");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_wait_relaxed(signal, condition, compare_value, timeout_hint, wait_state_hint);
	hsa_callback_function(0, "hsa_signal_wait_relaxed");
	return ret;
}

hsa_signal_value_t hsa_signal_wait_acquire(hsa_signal_t signal, hsa_signal_condition_t condition, hsa_signal_value_t compare_value, uint64_t timeout_hint, hsa_wait_state_t wait_state_hint) {
	hsa_callback_function(1, "hsa_signal_wait_acquire");
	hsa_signal_value_t ret = hsa_itcp_table.fn_hsa_signal_wait_acquire(signal, condition, compare_value, timeout_hint, wait_state_hint);
	hsa_callback_function(0, "hsa_signal_wait_acquire");
	return ret;
}

hsa_status_t hsa_signal_group_create(uint32_t num_signals, const hsa_signal_t *signals, uint32_t num_consumers, const hsa_agent_t *consumers, hsa_signal_group_t *signal_group) {
	hsa_callback_function(1, "hsa_signal_group_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_signal_group_create(num_signals, signals, num_consumers, consumers, signal_group);
	hsa_callback_function(0, "hsa_signal_group_create");
	return ret;
}

hsa_status_t hsa_signal_group_destroy(hsa_signal_group_t signal_group) {
	hsa_callback_function(1, "hsa_signal_group_destroy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_signal_group_destroy(signal_group);
	hsa_callback_function(0, "hsa_signal_group_destroy");
	return ret;
}

hsa_status_t hsa_signal_group_wait_any_scacquire(hsa_signal_group_t signal_group, const hsa_signal_condition_t *conditions, const hsa_signal_value_t *compare_values, hsa_wait_state_t wait_state_hint, hsa_signal_t *signal, hsa_signal_value_t *value) {
	hsa_callback_function(1, "hsa_signal_group_wait_any_scacquire");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_signal_group_wait_any_scacquire(signal_group, conditions, compare_values, wait_state_hint, signal, value);
	hsa_callback_function(0, "hsa_signal_group_wait_any_scacquire");
	return ret;
}

hsa_status_t hsa_signal_group_wait_any_relaxed(hsa_signal_group_t signal_group, const hsa_signal_condition_t *conditions, const hsa_signal_value_t *compare_values, hsa_wait_state_t wait_state_hint, hsa_signal_t *signal, hsa_signal_value_t *value) {
	hsa_callback_function(1, "hsa_signal_group_wait_any_relaxed");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_signal_group_wait_any_relaxed(signal_group, conditions, compare_values, wait_state_hint, signal, value);
	hsa_callback_function(0, "hsa_signal_group_wait_any_relaxed");
	return ret;
}

hsa_status_t hsa_queue_create(hsa_agent_t agent, uint32_t size, hsa_queue_type32_t type, void (*callback)(hsa_status_t status, hsa_queue_t *source, void *data), void *data, uint32_t private_segment_size, uint32_t group_segment_size, hsa_queue_t **queue) {
	hsa_callback_function(1, "hsa_queue_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_queue_create(agent, size, type, callback, data, private_segment_size, group_segment_size, queue);
	hsa_callback_function(0, "hsa_queue_create");
	return ret;
}

hsa_status_t hsa_soft_queue_create(hsa_region_t region, uint32_t size, hsa_queue_type32_t type, uint32_t features, hsa_signal_t doorbell_signal, hsa_queue_t **queue) {
	hsa_callback_function(1, "hsa_soft_queue_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_soft_queue_create(region, size, type, features, doorbell_signal, queue);
	hsa_callback_function(0, "hsa_soft_queue_create");
	return ret;
}

hsa_status_t hsa_queue_destroy(hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_destroy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_queue_destroy(queue);
	hsa_callback_function(0, "hsa_queue_destroy");
	return ret;
}

hsa_status_t hsa_queue_inactivate(hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_inactivate");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_queue_inactivate(queue);
	hsa_callback_function(0, "hsa_queue_inactivate");
	return ret;
}

uint64_t hsa_queue_load_read_index_acquire(const hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_load_read_index_acquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_load_read_index_acquire(queue);
	hsa_callback_function(0, "hsa_queue_load_read_index_acquire");
	return ret;
}

uint64_t hsa_queue_load_read_index_scacquire(const hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_load_read_index_scacquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_load_read_index_scacquire(queue);
	hsa_callback_function(0, "hsa_queue_load_read_index_scacquire");
	return ret;
}

uint64_t hsa_queue_load_read_index_relaxed(const hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_load_read_index_relaxed");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_load_read_index_relaxed(queue);
	hsa_callback_function(0, "hsa_queue_load_read_index_relaxed");
	return ret;
}

uint64_t hsa_queue_load_write_index_acquire(const hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_load_write_index_acquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_load_write_index_acquire(queue);
	hsa_callback_function(0, "hsa_queue_load_write_index_acquire");
	return ret;
}

uint64_t hsa_queue_load_write_index_scacquire(const hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_load_write_index_scacquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_load_write_index_scacquire(queue);
	hsa_callback_function(0, "hsa_queue_load_write_index_scacquire");
	return ret;
}

uint64_t hsa_queue_load_write_index_relaxed(const hsa_queue_t *queue) {
	hsa_callback_function(1, "hsa_queue_load_write_index_relaxed");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_load_write_index_relaxed(queue);
	hsa_callback_function(0, "hsa_queue_load_write_index_relaxed");
	return ret;
}

void hsa_queue_store_write_index_relaxed(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_store_write_index_relaxed");
	hsa_itcp_table.fn_hsa_queue_store_write_index_relaxed(queue, value);
	hsa_callback_function(0, "hsa_queue_store_write_index_relaxed");
	return;
}

void hsa_queue_store_write_index_release(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_store_write_index_release");
	hsa_itcp_table.fn_hsa_queue_store_write_index_release(queue, value);
	hsa_callback_function(0, "hsa_queue_store_write_index_release");
	return;
}

void hsa_queue_store_write_index_screlease(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_store_write_index_screlease");
	hsa_itcp_table.fn_hsa_queue_store_write_index_screlease(queue, value);
	hsa_callback_function(0, "hsa_queue_store_write_index_screlease");
	return;
}

uint64_t hsa_queue_cas_write_index_acq_rel(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_acq_rel");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_acq_rel(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_acq_rel");
	return ret;
}

uint64_t hsa_queue_cas_write_index_scacq_screl(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_scacq_screl");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_scacq_screl(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_scacq_screl");
	return ret;
}

uint64_t hsa_queue_cas_write_index_acquire(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_acquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_acquire(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_acquire");
	return ret;
}

uint64_t hsa_queue_cas_write_index_scacquire(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_scacquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_scacquire(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_scacquire");
	return ret;
}

uint64_t hsa_queue_cas_write_index_relaxed(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_relaxed");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_relaxed(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_relaxed");
	return ret;
}

uint64_t hsa_queue_cas_write_index_release(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_release");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_release(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_release");
	return ret;
}

uint64_t hsa_queue_cas_write_index_screlease(const hsa_queue_t *queue, uint64_t expected, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_cas_write_index_screlease");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_cas_write_index_screlease(queue, expected, value);
	hsa_callback_function(0, "hsa_queue_cas_write_index_screlease");
	return ret;
}

uint64_t hsa_queue_add_write_index_acq_rel(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_acq_rel");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_acq_rel(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_acq_rel");
	return ret;
}

uint64_t hsa_queue_add_write_index_scacq_screl(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_scacq_screl");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_scacq_screl(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_scacq_screl");
	return ret;
}

uint64_t hsa_queue_add_write_index_acquire(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_acquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_acquire(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_acquire");
	return ret;
}

uint64_t hsa_queue_add_write_index_scacquire(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_scacquire");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_scacquire(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_scacquire");
	return ret;
}

uint64_t hsa_queue_add_write_index_relaxed(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_relaxed");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_relaxed(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_relaxed");
	return ret;
}

uint64_t hsa_queue_add_write_index_release(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_release");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_release(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_release");
	return ret;
}

uint64_t hsa_queue_add_write_index_screlease(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_add_write_index_screlease");
	uint64_t ret = hsa_itcp_table.fn_hsa_queue_add_write_index_screlease(queue, value);
	hsa_callback_function(0, "hsa_queue_add_write_index_screlease");
	return ret;
}

void hsa_queue_store_read_index_relaxed(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_store_read_index_relaxed");
	hsa_itcp_table.fn_hsa_queue_store_read_index_relaxed(queue, value);
	hsa_callback_function(0, "hsa_queue_store_read_index_relaxed");
	return;
}

void hsa_queue_store_read_index_release(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_store_read_index_release");
	hsa_itcp_table.fn_hsa_queue_store_read_index_release(queue, value);
	hsa_callback_function(0, "hsa_queue_store_read_index_release");
	return;
}

void hsa_queue_store_read_index_screlease(const hsa_queue_t *queue, uint64_t value) {
	hsa_callback_function(1, "hsa_queue_store_read_index_screlease");
	hsa_itcp_table.fn_hsa_queue_store_read_index_screlease(queue, value);
	hsa_callback_function(0, "hsa_queue_store_read_index_screlease");
	return;
}

hsa_status_t hsa_region_get_info(hsa_region_t region, hsa_region_info_t attribute, void* value) {
	hsa_callback_function(1, "hsa_region_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_region_get_info(region, attribute, value);
	hsa_callback_function(0, "hsa_region_get_info");
	return ret;
}

hsa_status_t hsa_agent_iterate_regions(hsa_agent_t agent, hsa_status_t (*callback)(hsa_region_t region, void* data), void* data) {
	hsa_callback_function(1, "hsa_agent_iterate_regions");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_iterate_regions(agent, callback, data);
	hsa_callback_function(0, "hsa_agent_iterate_regions");
	return ret;
}

hsa_status_t hsa_memory_allocate(hsa_region_t region, size_t size, void** ptr) {
	hsa_callback_function(1, "hsa_memory_allocate");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_memory_allocate(region, size, ptr);
	hsa_callback_function(0, "hsa_memory_allocate");
	return ret;
}

hsa_status_t hsa_memory_free(void* ptr) {
	hsa_callback_function(1, "hsa_memory_free");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_memory_free(ptr);
	hsa_callback_function(0, "hsa_memory_free");
	return ret;
}

hsa_status_t hsa_memory_copy(void *dst, const void *src, size_t size) {
	hsa_callback_function(1, "hsa_memory_copy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_memory_copy(dst, src, size);
	hsa_callback_function(0, "hsa_memory_copy");
	return ret;
}

hsa_status_t hsa_memory_assign_agent(void *ptr, hsa_agent_t agent, hsa_access_permission_t access) {
	hsa_callback_function(1, "hsa_memory_assign_agent");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_memory_assign_agent(ptr, agent, access);
	hsa_callback_function(0, "hsa_memory_assign_agent");
	return ret;
}

hsa_status_t hsa_memory_register(void *ptr, size_t size) {
	hsa_callback_function(1, "hsa_memory_register");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_memory_register(ptr, size);
	hsa_callback_function(0, "hsa_memory_register");
	return ret;
}

hsa_status_t hsa_memory_deregister(void *ptr, size_t size) {
	hsa_callback_function(1, "hsa_memory_deregister");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_memory_deregister(ptr, size);
	hsa_callback_function(0, "hsa_memory_deregister");
	return ret;
}

hsa_status_t hsa_isa_from_name(const char *name, hsa_isa_t *isa) {
	hsa_callback_function(1, "hsa_isa_from_name");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_from_name(name, isa);
	hsa_callback_function(0, "hsa_isa_from_name");
	return ret;
}

hsa_status_t hsa_agent_iterate_isas(hsa_agent_t agent, hsa_status_t (*callback)(hsa_isa_t isa, void *data), void *data) {
	hsa_callback_function(1, "hsa_agent_iterate_isas");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_agent_iterate_isas(agent, callback, data);
	hsa_callback_function(0, "hsa_agent_iterate_isas");
	return ret;
}

hsa_status_t hsa_isa_get_info(hsa_isa_t isa, hsa_isa_info_t attribute, uint32_t index, void *value) {
	hsa_callback_function(1, "hsa_isa_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_get_info(isa, attribute, index, value);
	hsa_callback_function(0, "hsa_isa_get_info");
	return ret;
}

hsa_status_t hsa_isa_get_info_alt(hsa_isa_t isa, hsa_isa_info_t attribute, void *value) {
	hsa_callback_function(1, "hsa_isa_get_info_alt");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_get_info_alt(isa, attribute, value);
	hsa_callback_function(0, "hsa_isa_get_info_alt");
	return ret;
}

hsa_status_t hsa_isa_get_exception_policies(hsa_isa_t isa, hsa_profile_t profile, uint16_t *mask) {
	hsa_callback_function(1, "hsa_isa_get_exception_policies");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_get_exception_policies(isa, profile, mask);
	hsa_callback_function(0, "hsa_isa_get_exception_policies");
	return ret;
}

hsa_status_t hsa_isa_get_round_method(hsa_isa_t isa, hsa_fp_type_t fp_type, hsa_flush_mode_t flush_mode, hsa_round_method_t *round_method) {
	hsa_callback_function(1, "hsa_isa_get_round_method");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_get_round_method(isa, fp_type, flush_mode, round_method);
	hsa_callback_function(0, "hsa_isa_get_round_method");
	return ret;
}

hsa_status_t hsa_wavefront_get_info(hsa_wavefront_t wavefront, hsa_wavefront_info_t attribute, void *value) {
	hsa_callback_function(1, "hsa_wavefront_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_wavefront_get_info(wavefront, attribute, value);
	hsa_callback_function(0, "hsa_wavefront_get_info");
	return ret;
}

hsa_status_t hsa_isa_iterate_wavefronts(hsa_isa_t isa, hsa_status_t (*callback)(hsa_wavefront_t wavefront, void *data), void *data) {
	hsa_callback_function(1, "hsa_isa_iterate_wavefronts");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_iterate_wavefronts(isa, callback, data);
	hsa_callback_function(0, "hsa_isa_iterate_wavefronts");
	return ret;
}

hsa_status_t hsa_isa_compatible(hsa_isa_t code_object_isa, hsa_isa_t agent_isa, bool *result) {
	hsa_callback_function(1, "hsa_isa_compatible");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_isa_compatible(code_object_isa, agent_isa, result);
	hsa_callback_function(0, "hsa_isa_compatible");
	return ret;
}

hsa_status_t hsa_code_object_reader_create_from_file(hsa_file_t file, hsa_code_object_reader_t *code_object_reader) {
	hsa_callback_function(1, "hsa_code_object_reader_create_from_file");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_reader_create_from_file(file, code_object_reader);
	hsa_callback_function(0, "hsa_code_object_reader_create_from_file");
	return ret;
}

hsa_status_t hsa_code_object_reader_create_from_memory(const void *code_object, size_t size, hsa_code_object_reader_t *code_object_reader) {
	hsa_callback_function(1, "hsa_code_object_reader_create_from_memory");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_reader_create_from_memory(code_object, size, code_object_reader);
	hsa_callback_function(0, "hsa_code_object_reader_create_from_memory");
	return ret;
}

hsa_status_t hsa_code_object_reader_destroy(hsa_code_object_reader_t code_object_reader) {
	hsa_callback_function(1, "hsa_code_object_reader_destroy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_reader_destroy(code_object_reader);
	hsa_callback_function(0, "hsa_code_object_reader_destroy");
	return ret;
}

hsa_status_t hsa_executable_create(hsa_profile_t profile, hsa_executable_state_t executable_state, const char *options, hsa_executable_t *executable) {
	hsa_callback_function(1, "hsa_executable_create");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_create(profile, executable_state, options, executable);
	hsa_callback_function(0, "hsa_executable_create");
	return ret;
}

hsa_status_t hsa_executable_create_alt(hsa_profile_t profile, hsa_default_float_rounding_mode_t default_float_rounding_mode, const char *options, hsa_executable_t *executable) {
	hsa_callback_function(1, "hsa_executable_create_alt");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_create_alt(profile, default_float_rounding_mode, options, executable);
	hsa_callback_function(0, "hsa_executable_create_alt");
	return ret;
}

hsa_status_t hsa_executable_destroy(hsa_executable_t executable) {
	hsa_callback_function(1, "hsa_executable_destroy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_destroy(executable);
	hsa_callback_function(0, "hsa_executable_destroy");
	return ret;
}

hsa_status_t hsa_executable_load_program_code_object(hsa_executable_t executable, hsa_code_object_reader_t code_object_reader, const char *options, hsa_loaded_code_object_t *loaded_code_object) {
	hsa_callback_function(1, "hsa_executable_load_program_code_object");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_load_program_code_object(executable, code_object_reader, options, loaded_code_object);
	hsa_callback_function(0, "hsa_executable_load_program_code_object");
	return ret;
}

hsa_status_t hsa_executable_load_agent_code_object(hsa_executable_t executable, hsa_agent_t agent, hsa_code_object_reader_t code_object_reader, const char *options, hsa_loaded_code_object_t *loaded_code_object) {
	hsa_callback_function(1, "hsa_executable_load_agent_code_object");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_load_agent_code_object(executable, agent, code_object_reader, options, loaded_code_object);
	hsa_callback_function(0, "hsa_executable_load_agent_code_object");
	return ret;
}

hsa_status_t hsa_executable_freeze(hsa_executable_t executable, const char *options) {
	hsa_callback_function(1, "hsa_executable_freeze");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_freeze(executable, options);
	hsa_callback_function(0, "hsa_executable_freeze");
	return ret;
}

hsa_status_t hsa_executable_get_info(hsa_executable_t executable, hsa_executable_info_t attribute, void *value) {
	hsa_callback_function(1, "hsa_executable_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_get_info(executable, attribute, value);
	hsa_callback_function(0, "hsa_executable_get_info");
	return ret;
}

hsa_status_t hsa_executable_global_variable_define(hsa_executable_t executable, const char *variable_name, void *address) {
	hsa_callback_function(1, "hsa_executable_global_variable_define");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_global_variable_define(executable, variable_name, address);
	hsa_callback_function(0, "hsa_executable_global_variable_define");
	return ret;
}

hsa_status_t hsa_executable_agent_global_variable_define(hsa_executable_t executable, hsa_agent_t agent, const char *variable_name, void *address) {
	hsa_callback_function(1, "hsa_executable_agent_global_variable_define");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_agent_global_variable_define(executable, agent, variable_name, address);
	hsa_callback_function(0, "hsa_executable_agent_global_variable_define");
	return ret;
}

hsa_status_t hsa_executable_readonly_variable_define(hsa_executable_t executable, hsa_agent_t agent, const char *variable_name, void *address) {
	hsa_callback_function(1, "hsa_executable_readonly_variable_define");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_readonly_variable_define(executable, agent, variable_name, address);
	hsa_callback_function(0, "hsa_executable_readonly_variable_define");
	return ret;
}

hsa_status_t hsa_executable_validate(hsa_executable_t executable, uint32_t *result) {
	hsa_callback_function(1, "hsa_executable_validate");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_validate(executable, result);
	hsa_callback_function(0, "hsa_executable_validate");
	return ret;
}

hsa_status_t hsa_executable_validate_alt(hsa_executable_t executable, const char *options, uint32_t *result) {
	hsa_callback_function(1, "hsa_executable_validate_alt");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_validate_alt(executable, options, result);
	hsa_callback_function(0, "hsa_executable_validate_alt");
	return ret;
}

hsa_status_t hsa_executable_get_symbol(hsa_executable_t executable, const char *module_name, const char *symbol_name, hsa_agent_t agent, int32_t call_convention, hsa_executable_symbol_t *symbol) {
	hsa_callback_function(1, "hsa_executable_get_symbol");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_get_symbol(executable, module_name, symbol_name, agent, call_convention, symbol);
	hsa_callback_function(0, "hsa_executable_get_symbol");
	return ret;
}

hsa_status_t hsa_executable_get_symbol_by_name(hsa_executable_t executable, const char *symbol_name, const hsa_agent_t *agent, hsa_executable_symbol_t *symbol) {
	hsa_callback_function(1, "hsa_executable_get_symbol_by_name");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_get_symbol_by_name(executable, symbol_name, agent, symbol);
	hsa_callback_function(0, "hsa_executable_get_symbol_by_name");
	return ret;
}

hsa_status_t hsa_executable_symbol_get_info(hsa_executable_symbol_t executable_symbol, hsa_executable_symbol_info_t attribute, void *value) {
	hsa_callback_function(1, "hsa_executable_symbol_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_symbol_get_info(executable_symbol, attribute, value);
	hsa_callback_function(0, "hsa_executable_symbol_get_info");
	return ret;
}

hsa_status_t hsa_executable_iterate_symbols(hsa_executable_t executable, hsa_status_t (*callback)(hsa_executable_t exec,hsa_executable_symbol_t symbol,void *data), void *data) {
	hsa_callback_function(1, "hsa_executable_iterate_symbols");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_iterate_symbols(executable, callback, data);
	hsa_callback_function(0, "hsa_executable_iterate_symbols");
	return ret;
}

hsa_status_t hsa_executable_iterate_agent_symbols(hsa_executable_t executable, hsa_agent_t agent, hsa_status_t (*callback)(hsa_executable_t exec,hsa_agent_t agent,hsa_executable_symbol_t symbol,void *data), void *data) {
	hsa_callback_function(1, "hsa_executable_iterate_agent_symbols");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_iterate_agent_symbols(executable, agent, callback, data);
	hsa_callback_function(0, "hsa_executable_iterate_agent_symbols");
	return ret;
}

hsa_status_t hsa_executable_iterate_program_symbols(hsa_executable_t executable, hsa_status_t (*callback)(hsa_executable_t exec,hsa_executable_symbol_t symbol,void *data), void *data) {
	hsa_callback_function(1, "hsa_executable_iterate_program_symbols");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_iterate_program_symbols(executable, callback, data);
	hsa_callback_function(0, "hsa_executable_iterate_program_symbols");
	return ret;
}

hsa_status_t hsa_code_object_serialize(hsa_code_object_t code_object, hsa_status_t (*alloc_callback)(size_t size,hsa_callback_data_t data,void **address), hsa_callback_data_t callback_data, const char *options, void **serialized_code_object, size_t *serialized_code_object_size) {
	hsa_callback_function(1, "hsa_code_object_serialize");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_serialize(code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size);
	hsa_callback_function(0, "hsa_code_object_serialize");
	return ret;
}

hsa_status_t hsa_code_object_deserialize(void *serialized_code_object, size_t serialized_code_object_size, const char *options, hsa_code_object_t *code_object) {
	hsa_callback_function(1, "hsa_code_object_deserialize");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_deserialize(serialized_code_object, serialized_code_object_size, options, code_object);
	hsa_callback_function(0, "hsa_code_object_deserialize");
	return ret;
}

hsa_status_t hsa_code_object_destroy(hsa_code_object_t code_object) {
	hsa_callback_function(1, "hsa_code_object_destroy");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_destroy(code_object);
	hsa_callback_function(0, "hsa_code_object_destroy");
	return ret;
}

hsa_status_t hsa_code_object_get_info(hsa_code_object_t code_object, hsa_code_object_info_t attribute, void *value) {
	hsa_callback_function(1, "hsa_code_object_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_get_info(code_object, attribute, value);
	hsa_callback_function(0, "hsa_code_object_get_info");
	return ret;
}

hsa_status_t hsa_executable_load_code_object(hsa_executable_t executable, hsa_agent_t agent, hsa_code_object_t code_object, const char *options) {
	hsa_callback_function(1, "hsa_executable_load_code_object");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_executable_load_code_object(executable, agent, code_object, options);
	hsa_callback_function(0, "hsa_executable_load_code_object");
	return ret;
}

hsa_status_t hsa_code_object_get_symbol(hsa_code_object_t code_object, const char *symbol_name, hsa_code_symbol_t *symbol) {
	hsa_callback_function(1, "hsa_code_object_get_symbol");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_get_symbol(code_object, symbol_name, symbol);
	hsa_callback_function(0, "hsa_code_object_get_symbol");
	return ret;
}

hsa_status_t hsa_code_object_get_symbol_from_name(hsa_code_object_t code_object, const char *module_name, const char *symbol_name, hsa_code_symbol_t *symbol) {
	hsa_callback_function(1, "hsa_code_object_get_symbol_from_name");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_get_symbol_from_name(code_object, module_name, symbol_name, symbol);
	hsa_callback_function(0, "hsa_code_object_get_symbol_from_name");
	return ret;
}

hsa_status_t hsa_code_symbol_get_info(hsa_code_symbol_t code_symbol, hsa_code_symbol_info_t attribute, void *value) {
	hsa_callback_function(1, "hsa_code_symbol_get_info");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_symbol_get_info(code_symbol, attribute, value);
	hsa_callback_function(0, "hsa_code_symbol_get_info");
	return ret;
}

hsa_status_t hsa_code_object_iterate_symbols(hsa_code_object_t code_object, hsa_status_t (*callback)(hsa_code_object_t code_object,hsa_code_symbol_t symbol,void *data), void *data) {
	hsa_callback_function(1, "hsa_code_object_iterate_symbols");
	hsa_status_t ret = hsa_itcp_table.fn_hsa_code_object_iterate_symbols(code_object, callback, data);
	hsa_callback_function(0, "hsa_code_object_iterate_symbols");
	return ret;
}

