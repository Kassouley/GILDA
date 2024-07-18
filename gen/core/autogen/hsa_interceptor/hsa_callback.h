#ifndef HSA_CALLBACK_H
#define HSA_CALLBACK_H

#include "hsa_intercepted_functions.h"

#include "hsa.h"
#include "hsa_ext_amd.h"

#define IS_ENTER 1
#define IS_EXIT 0

void hsa_callback_function(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data);
void set_hsa_interceptor_callback(void (*hsa_callback)(bool is_enter, hsa_api_id_t func_id, hsa_api_data_t data));

#define GET_CB_ARGS_DATA_hsa_amd_coherency_get_type(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_coherency_get_type.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_coherency_get_type.type = (hsa_amd_coherency_type_t* )type; \
};

#define GET_CB_ARGS_DATA_hsa_amd_coherency_set_type(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_coherency_set_type.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_coherency_set_type.type = (hsa_amd_coherency_type_t )type; \
};

#define GET_CB_ARGS_DATA_hsa_amd_profiling_set_profiler_enabled(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_profiling_set_profiler_enabled.queue = (hsa_queue_t* )queue; \
	__hsa_data__.args.hsa_amd_profiling_set_profiler_enabled.enable = (int )enable; \
};

#define GET_CB_ARGS_DATA_hsa_amd_profiling_async_copy_enable(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_profiling_async_copy_enable.enable = (bool )enable; \
};

#define GET_CB_ARGS_DATA_hsa_amd_profiling_get_dispatch_time(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_profiling_get_dispatch_time.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_profiling_get_dispatch_time.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_amd_profiling_get_dispatch_time.time = (hsa_amd_profiling_dispatch_time_t* )time; \
};

#define GET_CB_ARGS_DATA_hsa_amd_profiling_get_async_copy_time(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_profiling_get_async_copy_time.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_amd_profiling_get_async_copy_time.time = (hsa_amd_profiling_async_copy_time_t* )time; \
};

#define GET_CB_ARGS_DATA_hsa_amd_profiling_convert_tick_to_system_domain(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_profiling_convert_tick_to_system_domain.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_profiling_convert_tick_to_system_domain.agent_tick = (uint64_t )agent_tick; \
	__hsa_data__.args.hsa_amd_profiling_convert_tick_to_system_domain.system_tick = (uint64_t* )system_tick; \
};

#define GET_CB_ARGS_DATA_hsa_amd_signal_create(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_signal_create.initial_value = (hsa_signal_value_t )initial_value; \
	__hsa_data__.args.hsa_amd_signal_create.num_consumers = (uint32_t )num_consumers; \
	__hsa_data__.args.hsa_amd_signal_create.consumers = (const hsa_agent_t* )consumers; \
	__hsa_data__.args.hsa_amd_signal_create.attributes = (uint64_t )attributes; \
	__hsa_data__.args.hsa_amd_signal_create.signal = (hsa_signal_t* )signal; \
};

#define GET_CB_ARGS_DATA_hsa_amd_signal_value_pointer(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_signal_value_pointer.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_amd_signal_value_pointer.value_ptr = (volatile hsa_signal_value_t** )value_ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_signal_async_handler(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_signal_async_handler.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_amd_signal_async_handler.cond = (hsa_signal_condition_t )cond; \
	__hsa_data__.args.hsa_amd_signal_async_handler.value = (hsa_signal_value_t )value; \
	__hsa_data__.args.hsa_amd_signal_async_handler.handler = (hsa_amd_signal_handler )handler; \
	__hsa_data__.args.hsa_amd_signal_async_handler.arg = (void* )arg; \
};

#define GET_CB_ARGS_DATA_hsa_amd_async_function(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_async_function.callback = (void )callback; \
	__hsa_data__.args.hsa_amd_async_function.arg = (void* )arg; \
};

#define GET_CB_ARGS_DATA_hsa_amd_signal_wait_any(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_signal_wait_any.signal_count = (uint32_t )signal_count; \
	__hsa_data__.args.hsa_amd_signal_wait_any.signals = (hsa_signal_t* )signals; \
	__hsa_data__.args.hsa_amd_signal_wait_any.conds = (hsa_signal_condition_t* )conds; \
	__hsa_data__.args.hsa_amd_signal_wait_any.values = (hsa_signal_value_t* )values; \
	__hsa_data__.args.hsa_amd_signal_wait_any.timeout_hint = (uint64_t )timeout_hint; \
	__hsa_data__.args.hsa_amd_signal_wait_any.wait_hint = (hsa_wait_state_t )wait_hint; \
	__hsa_data__.args.hsa_amd_signal_wait_any.satisfying_value = (hsa_signal_value_t* )satisfying_value; \
};

#define GET_CB_ARGS_DATA_hsa_amd_image_get_info_max_dim(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_image_get_info_max_dim.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_image_get_info_max_dim.attribute = (hsa_agent_info_t )attribute; \
	__hsa_data__.args.hsa_amd_image_get_info_max_dim.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_amd_queue_cu_set_mask(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_queue_cu_set_mask.queue = (const hsa_queue_t* )queue; \
	__hsa_data__.args.hsa_amd_queue_cu_set_mask.num_cu_mask_count = (uint32_t )num_cu_mask_count; \
	__hsa_data__.args.hsa_amd_queue_cu_set_mask.cu_mask = (const uint32_t* )cu_mask; \
};

#define GET_CB_ARGS_DATA_hsa_amd_queue_cu_get_mask(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_queue_cu_get_mask.queue = (const hsa_queue_t* )queue; \
	__hsa_data__.args.hsa_amd_queue_cu_get_mask.num_cu_mask_count = (uint32_t )num_cu_mask_count; \
	__hsa_data__.args.hsa_amd_queue_cu_get_mask.cu_mask = (uint32_t* )cu_mask; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_pool_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_pool_get_info.memory_pool = (hsa_amd_memory_pool_t )memory_pool; \
	__hsa_data__.args.hsa_amd_memory_pool_get_info.attribute = (hsa_amd_memory_pool_info_t )attribute; \
	__hsa_data__.args.hsa_amd_memory_pool_get_info.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_amd_agent_iterate_memory_pools(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_agent_iterate_memory_pools.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_agent_iterate_memory_pools.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_amd_agent_iterate_memory_pools.data = (void* )data; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_pool_allocate(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_pool_allocate.memory_pool = (hsa_amd_memory_pool_t )memory_pool; \
	__hsa_data__.args.hsa_amd_memory_pool_allocate.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_memory_pool_allocate.flags = (uint32_t )flags; \
	__hsa_data__.args.hsa_amd_memory_pool_allocate.ptr = (void** )ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_pool_free(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_pool_free.ptr = (void* )ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_async_copy(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_async_copy.dst = (void* )dst; \
	__hsa_data__.args.hsa_amd_memory_async_copy.dst_agent = (hsa_agent_t )dst_agent; \
	__hsa_data__.args.hsa_amd_memory_async_copy.src = (const void* )src; \
	__hsa_data__.args.hsa_amd_memory_async_copy.src_agent = (hsa_agent_t )src_agent; \
	__hsa_data__.args.hsa_amd_memory_async_copy.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_memory_async_copy.num_dep_signals = (uint32_t )num_dep_signals; \
	__hsa_data__.args.hsa_amd_memory_async_copy.dep_signals = (const hsa_signal_t* )dep_signals; \
	__hsa_data__.args.hsa_amd_memory_async_copy.completion_signal = (hsa_signal_t )completion_signal; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_async_copy_on_engine(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.dst = (void* )dst; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.dst_agent = (hsa_agent_t )dst_agent; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.src = (const void* )src; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.src_agent = (hsa_agent_t )src_agent; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.num_dep_signals = (uint32_t )num_dep_signals; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.dep_signals = (const hsa_signal_t* )dep_signals; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.completion_signal = (hsa_signal_t )completion_signal; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.engine_id = (hsa_amd_sdma_engine_id_t )engine_id; \
	__hsa_data__.args.hsa_amd_memory_async_copy_on_engine.force_copy_on_sdma = (bool )force_copy_on_sdma; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_copy_engine_status(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_copy_engine_status.dst_agent = (hsa_agent_t )dst_agent; \
	__hsa_data__.args.hsa_amd_memory_copy_engine_status.src_agent = (hsa_agent_t )src_agent; \
	__hsa_data__.args.hsa_amd_memory_copy_engine_status.engine_ids_mask = (uint32_t *)engine_ids_mask; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_async_copy_rect(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.dst = (const hsa_pitched_ptr_t* )dst; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.dst_offset = (const hsa_dim3_t* )dst_offset; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.src = (const hsa_pitched_ptr_t* )src; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.src_offset = (const hsa_dim3_t* )src_offset; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.range = (const hsa_dim3_t* )range; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.copy_agent = (hsa_agent_t )copy_agent; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.dir = (hsa_amd_copy_direction_t )dir; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.num_dep_signals = (uint32_t )num_dep_signals; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.dep_signals = (const hsa_signal_t* )dep_signals; \
	__hsa_data__.args.hsa_amd_memory_async_copy_rect.completion_signal = (hsa_signal_t )completion_signal; \
};

#define GET_CB_ARGS_DATA_hsa_amd_agent_memory_pool_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_agent_memory_pool_get_info.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_agent_memory_pool_get_info.memory_pool = (hsa_amd_memory_pool_t )memory_pool; \
	__hsa_data__.args.hsa_amd_agent_memory_pool_get_info.attribute = (hsa_amd_agent_memory_pool_info_t )attribute; \
	__hsa_data__.args.hsa_amd_agent_memory_pool_get_info.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_amd_agents_allow_access(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_agents_allow_access.num_agents = (uint32_t )num_agents; \
	__hsa_data__.args.hsa_amd_agents_allow_access.agents = (const hsa_agent_t* )agents; \
	__hsa_data__.args.hsa_amd_agents_allow_access.flags = (const uint32_t* )flags; \
	__hsa_data__.args.hsa_amd_agents_allow_access.ptr = (const void* )ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_pool_can_migrate(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_pool_can_migrate.src_memory_pool = (hsa_amd_memory_pool_t )src_memory_pool; \
	__hsa_data__.args.hsa_amd_memory_pool_can_migrate.dst_memory_pool = (hsa_amd_memory_pool_t )dst_memory_pool; \
	__hsa_data__.args.hsa_amd_memory_pool_can_migrate.result = (bool* )result; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_migrate(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_migrate.ptr = (const void* )ptr; \
	__hsa_data__.args.hsa_amd_memory_migrate.memory_pool = (hsa_amd_memory_pool_t )memory_pool; \
	__hsa_data__.args.hsa_amd_memory_migrate.flags = (uint32_t )flags; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_lock(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_lock.host_ptr = (void* )host_ptr; \
	__hsa_data__.args.hsa_amd_memory_lock.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_memory_lock.agents = (hsa_agent_t* )agents; \
	__hsa_data__.args.hsa_amd_memory_lock.num_agent = (int )num_agent; \
	__hsa_data__.args.hsa_amd_memory_lock.agent_ptr = (void** )agent_ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_lock_to_pool(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.host_ptr = (void* )host_ptr; \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.agents = (hsa_agent_t* )agents; \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.num_agent = (int )num_agent; \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.pool = (hsa_amd_memory_pool_t )pool; \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.flags = (uint32_t )flags; \
	__hsa_data__.args.hsa_amd_memory_lock_to_pool.agent_ptr = (void** )agent_ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_unlock(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_unlock.host_ptr = (void* )host_ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_memory_fill(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_memory_fill.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_memory_fill.value = (uint32_t )value; \
	__hsa_data__.args.hsa_amd_memory_fill.count = (size_t )count; \
};

#define GET_CB_ARGS_DATA_hsa_amd_interop_map_buffer(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_interop_map_buffer.num_agents = (uint32_t )num_agents; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.agents = (hsa_agent_t* )agents; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.interop_handle = (int )interop_handle; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.flags = (uint32_t )flags; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.size = (size_t* )size; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.ptr = (void** )ptr; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.metadata_size = (size_t* )metadata_size; \
	__hsa_data__.args.hsa_amd_interop_map_buffer.metadata = (const void** )metadata; \
};

#define GET_CB_ARGS_DATA_hsa_amd_interop_unmap_buffer(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_interop_unmap_buffer.ptr = (void* )ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_image_create(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_image_create.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_image_create.image_descriptor = (const hsa_ext_image_descriptor_t *)image_descriptor; \
	__hsa_data__.args.hsa_amd_image_create.image_layout = (const hsa_amd_image_descriptor_t *)image_layout; \
	__hsa_data__.args.hsa_amd_image_create.image_data = (const void *)image_data; \
	__hsa_data__.args.hsa_amd_image_create.access_permission = (hsa_access_permission_t )access_permission; \
	__hsa_data__.args.hsa_amd_image_create.image = (hsa_ext_image_t *)image; \
};

#define GET_CB_ARGS_DATA_hsa_amd_pointer_info(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_pointer_info.ptr = (const void* )ptr; \
	__hsa_data__.args.hsa_amd_pointer_info.info = (hsa_amd_pointer_info_t* )info; \
	__hsa_data__.args.hsa_amd_pointer_info.alloc = (void* )alloc; \
	__hsa_data__.args.hsa_amd_pointer_info.num_agents_accessible = (uint32_t* )num_agents_accessible; \
	__hsa_data__.args.hsa_amd_pointer_info.accessible = (hsa_agent_t** )accessible; \
};

#define GET_CB_ARGS_DATA_hsa_amd_pointer_info_set_userdata(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_pointer_info_set_userdata.ptr = (const void* )ptr; \
	__hsa_data__.args.hsa_amd_pointer_info_set_userdata.userdata = (void* )userdata; \
};

#define GET_CB_ARGS_DATA_hsa_amd_ipc_memory_create(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_ipc_memory_create.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_ipc_memory_create.len = (size_t )len; \
	__hsa_data__.args.hsa_amd_ipc_memory_create.handle = (hsa_amd_ipc_memory_t* )handle; \
};

#define GET_CB_ARGS_DATA_hsa_amd_ipc_memory_attach(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_ipc_memory_attach.handle = (const hsa_amd_ipc_memory_t* )handle; \
	__hsa_data__.args.hsa_amd_ipc_memory_attach.len = (size_t )len; \
	__hsa_data__.args.hsa_amd_ipc_memory_attach.num_agents = (uint32_t )num_agents; \
	__hsa_data__.args.hsa_amd_ipc_memory_attach.mapping_agents = (const hsa_agent_t* )mapping_agents; \
	__hsa_data__.args.hsa_amd_ipc_memory_attach.mapped_ptr = (void** )mapped_ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_ipc_memory_detach(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_ipc_memory_detach.mapped_ptr = (void* )mapped_ptr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_ipc_signal_create(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_ipc_signal_create.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_amd_ipc_signal_create.handle = (hsa_amd_ipc_signal_t* )handle; \
};

#define GET_CB_ARGS_DATA_hsa_amd_ipc_signal_attach(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_ipc_signal_attach.handle = (const hsa_amd_ipc_signal_t* )handle; \
	__hsa_data__.args.hsa_amd_ipc_signal_attach.signal = (hsa_signal_t* )signal; \
};

#define GET_CB_ARGS_DATA_hsa_amd_register_system_event_handler(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_register_system_event_handler.callback = (hsa_amd_system_event_callback_t )callback; \
	__hsa_data__.args.hsa_amd_register_system_event_handler.data = (void* )data; \
};

#define GET_CB_ARGS_DATA_hsa_amd_queue_set_priority(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_queue_set_priority.queue = (hsa_queue_t* )queue; \
	__hsa_data__.args.hsa_amd_queue_set_priority.priority = (hsa_amd_queue_priority_t )priority; \
};

#define GET_CB_ARGS_DATA_hsa_amd_register_deallocation_callback(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_register_deallocation_callback.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_register_deallocation_callback.callback = (hsa_amd_deallocation_callback_t )callback; \
	__hsa_data__.args.hsa_amd_register_deallocation_callback.user_data = (void* )user_data; \
};

#define GET_CB_ARGS_DATA_hsa_amd_deregister_deallocation_callback(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_deregister_deallocation_callback.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_deregister_deallocation_callback.callback = (hsa_amd_deallocation_callback_t )callback; \
};

#define GET_CB_ARGS_DATA_hsa_amd_svm_attributes_set(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_svm_attributes_set.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_svm_attributes_set.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_svm_attributes_set.attribute_list = (hsa_amd_svm_attribute_pair_t* )attribute_list; \
	__hsa_data__.args.hsa_amd_svm_attributes_set.attribute_count = (size_t )attribute_count; \
};

#define GET_CB_ARGS_DATA_hsa_amd_svm_attributes_get(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_svm_attributes_get.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_svm_attributes_get.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_svm_attributes_get.attribute_list = (hsa_amd_svm_attribute_pair_t* )attribute_list; \
	__hsa_data__.args.hsa_amd_svm_attributes_get.attribute_count = (size_t )attribute_count; \
};

#define GET_CB_ARGS_DATA_hsa_amd_svm_prefetch_async(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_svm_prefetch_async.ptr = (void* )ptr; \
	__hsa_data__.args.hsa_amd_svm_prefetch_async.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_svm_prefetch_async.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_svm_prefetch_async.num_dep_signals = (uint32_t )num_dep_signals; \
	__hsa_data__.args.hsa_amd_svm_prefetch_async.dep_signals = (const hsa_signal_t* )dep_signals; \
	__hsa_data__.args.hsa_amd_svm_prefetch_async.completion_signal = (hsa_signal_t )completion_signal; \
};

#define GET_CB_ARGS_DATA_hsa_amd_spm_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_spm_acquire.preferred_agent = (hsa_agent_t )preferred_agent; \
};

#define GET_CB_ARGS_DATA_hsa_amd_spm_release(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_spm_release.preferred_agent = (hsa_agent_t )preferred_agent; \
};

#define GET_CB_ARGS_DATA_hsa_amd_spm_set_dest_buffer(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_spm_set_dest_buffer.preferred_agent = (hsa_agent_t )preferred_agent; \
	__hsa_data__.args.hsa_amd_spm_set_dest_buffer.size_in_bytes = (size_t )size_in_bytes; \
	__hsa_data__.args.hsa_amd_spm_set_dest_buffer.timeout = (uint32_t* )timeout; \
	__hsa_data__.args.hsa_amd_spm_set_dest_buffer.size_copied = (uint32_t* )size_copied; \
	__hsa_data__.args.hsa_amd_spm_set_dest_buffer.dest = (void* )dest; \
	__hsa_data__.args.hsa_amd_spm_set_dest_buffer.is_data_loss = (bool* )is_data_loss; \
};

#define GET_CB_ARGS_DATA_hsa_amd_portable_export_dmabuf(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_portable_export_dmabuf.ptr = (const void* )ptr; \
	__hsa_data__.args.hsa_amd_portable_export_dmabuf.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_portable_export_dmabuf.dmabuf = (int* )dmabuf; \
	__hsa_data__.args.hsa_amd_portable_export_dmabuf.offset = (uint64_t* )offset; \
};

#define GET_CB_ARGS_DATA_hsa_amd_portable_close_dmabuf(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_portable_close_dmabuf.dmabuf = (int )dmabuf; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_address_reserve(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_address_reserve.va = (void** )va; \
	__hsa_data__.args.hsa_amd_vmem_address_reserve.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_vmem_address_reserve.address = (uint64_t )address; \
	__hsa_data__.args.hsa_amd_vmem_address_reserve.flags = (uint64_t )flags; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_address_free(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_address_free.va = (void* )va; \
	__hsa_data__.args.hsa_amd_vmem_address_free.size = (size_t )size; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_handle_create(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_handle_create.pool = (hsa_amd_memory_pool_t )pool; \
	__hsa_data__.args.hsa_amd_vmem_handle_create.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_vmem_handle_create.type = (hsa_amd_memory_type_t )type; \
	__hsa_data__.args.hsa_amd_vmem_handle_create.flags = (uint64_t )flags; \
	__hsa_data__.args.hsa_amd_vmem_handle_create.memory_handle = (hsa_amd_vmem_alloc_handle_t* )memory_handle; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_handle_release(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_handle_release.memory_handle = (hsa_amd_vmem_alloc_handle_t )memory_handle; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_map(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_map.va = (void* )va; \
	__hsa_data__.args.hsa_amd_vmem_map.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_vmem_map.in_offset = (size_t )in_offset; \
	__hsa_data__.args.hsa_amd_vmem_map.memory_handle = (hsa_amd_vmem_alloc_handle_t )memory_handle; \
	__hsa_data__.args.hsa_amd_vmem_map.flags = (uint64_t )flags; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_unmap(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_unmap.va = (void* )va; \
	__hsa_data__.args.hsa_amd_vmem_unmap.size = (size_t )size; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_set_access(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_set_access.va = (void* )va; \
	__hsa_data__.args.hsa_amd_vmem_set_access.size = (size_t )size; \
	__hsa_data__.args.hsa_amd_vmem_set_access.desc = (const hsa_amd_memory_access_desc_t* )desc; \
	__hsa_data__.args.hsa_amd_vmem_set_access.desc_cnt = (size_t )desc_cnt; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_get_access(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_get_access.va = (void* )va; \
	__hsa_data__.args.hsa_amd_vmem_get_access.perms = (hsa_access_permission_t* )perms; \
	__hsa_data__.args.hsa_amd_vmem_get_access.agent_handle = (hsa_agent_t )agent_handle; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_export_shareable_handle(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_export_shareable_handle.dmabuf_fd = (int* )dmabuf_fd; \
	__hsa_data__.args.hsa_amd_vmem_export_shareable_handle.handle = (hsa_amd_vmem_alloc_handle_t )handle; \
	__hsa_data__.args.hsa_amd_vmem_export_shareable_handle.flags = (uint64_t )flags; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_import_shareable_handle(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_import_shareable_handle.dmabuf_fd = (int )dmabuf_fd; \
	__hsa_data__.args.hsa_amd_vmem_import_shareable_handle.handle = (hsa_amd_vmem_alloc_handle_t* )handle; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_retain_alloc_handle(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_retain_alloc_handle.memory_handle = (hsa_amd_vmem_alloc_handle_t* )memory_handle; \
	__hsa_data__.args.hsa_amd_vmem_retain_alloc_handle.addr = (void* )addr; \
};

#define GET_CB_ARGS_DATA_hsa_amd_vmem_get_alloc_properties_from_handle(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_vmem_get_alloc_properties_from_handle.memory_handle = (hsa_amd_vmem_alloc_handle_t )memory_handle; \
	__hsa_data__.args.hsa_amd_vmem_get_alloc_properties_from_handle.pool = (hsa_amd_memory_pool_t* )pool; \
	__hsa_data__.args.hsa_amd_vmem_get_alloc_properties_from_handle.type = (hsa_amd_memory_type_t* )type; \
};

#define GET_CB_ARGS_DATA_hsa_amd_agent_set_async_scratch_limit(__hsa_data__) { \
	__hsa_data__.args.hsa_amd_agent_set_async_scratch_limit.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_amd_agent_set_async_scratch_limit.threshold = (size_t )threshold; \
};

#define GET_CB_ARGS_DATA_hsa_status_string(__hsa_data__) { \
	__hsa_data__.args.hsa_status_string.status = (hsa_status_t )status; \
	__hsa_data__.args.hsa_status_string.status_string = (const char ** )status_string; \
};

#define GET_CB_ARGS_DATA_hsa_init(__hsa_data__) { \
};

#define GET_CB_ARGS_DATA_hsa_shut_down(__hsa_data__) { \
};

#define GET_CB_ARGS_DATA_hsa_system_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_system_get_info.attribute = (hsa_system_info_t )attribute; \
	__hsa_data__.args.hsa_system_get_info.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_extension_get_name(__hsa_data__) { \
	__hsa_data__.args.hsa_extension_get_name.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_extension_get_name.name = (const char **)name; \
};

#define GET_CB_ARGS_DATA_hsa_system_extension_supported(__hsa_data__) { \
	__hsa_data__.args.hsa_system_extension_supported.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_system_extension_supported.version_major = (uint16_t )version_major; \
	__hsa_data__.args.hsa_system_extension_supported.version_minor = (uint16_t )version_minor; \
	__hsa_data__.args.hsa_system_extension_supported.result = (bool* )result; \
};

#define GET_CB_ARGS_DATA_hsa_system_major_extension_supported(__hsa_data__) { \
	__hsa_data__.args.hsa_system_major_extension_supported.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_system_major_extension_supported.version_major = (uint16_t )version_major; \
	__hsa_data__.args.hsa_system_major_extension_supported.version_minor = (uint16_t *)version_minor; \
	__hsa_data__.args.hsa_system_major_extension_supported.result = (bool* )result; \
};

#define GET_CB_ARGS_DATA_hsa_system_get_extension_table(__hsa_data__) { \
	__hsa_data__.args.hsa_system_get_extension_table.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_system_get_extension_table.version_major = (uint16_t )version_major; \
	__hsa_data__.args.hsa_system_get_extension_table.version_minor = (uint16_t )version_minor; \
	__hsa_data__.args.hsa_system_get_extension_table.table = (void *)table; \
};

#define GET_CB_ARGS_DATA_hsa_system_get_major_extension_table(__hsa_data__) { \
	__hsa_data__.args.hsa_system_get_major_extension_table.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_system_get_major_extension_table.version_major = (uint16_t )version_major; \
	__hsa_data__.args.hsa_system_get_major_extension_table.table_length = (size_t )table_length; \
	__hsa_data__.args.hsa_system_get_major_extension_table.table = (void *)table; \
};

#define GET_CB_ARGS_DATA_hsa_agent_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_get_info.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_get_info.attribute = (hsa_agent_info_t )attribute; \
	__hsa_data__.args.hsa_agent_get_info.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_iterate_agents(__hsa_data__) { \
	__hsa_data__.args.hsa_iterate_agents.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_iterate_agents.data = (void* )data; \
};

#define GET_CB_ARGS_DATA_hsa_agent_get_exception_policies(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_get_exception_policies.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_get_exception_policies.profile = (hsa_profile_t )profile; \
	__hsa_data__.args.hsa_agent_get_exception_policies.mask = (uint16_t *)mask; \
};

#define GET_CB_ARGS_DATA_hsa_cache_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_cache_get_info.cache = (hsa_cache_t )cache; \
	__hsa_data__.args.hsa_cache_get_info.attribute = (hsa_cache_info_t )attribute; \
	__hsa_data__.args.hsa_cache_get_info.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_agent_iterate_caches(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_iterate_caches.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_iterate_caches.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_agent_iterate_caches.data = (void* )data; \
};

#define GET_CB_ARGS_DATA_hsa_agent_extension_supported(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_extension_supported.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_agent_extension_supported.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_extension_supported.version_major = (uint16_t )version_major; \
	__hsa_data__.args.hsa_agent_extension_supported.version_minor = (uint16_t )version_minor; \
	__hsa_data__.args.hsa_agent_extension_supported.result = (bool* )result; \
};

#define GET_CB_ARGS_DATA_hsa_agent_major_extension_supported(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_major_extension_supported.extension = (uint16_t )extension; \
	__hsa_data__.args.hsa_agent_major_extension_supported.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_major_extension_supported.version_major = (uint16_t )version_major; \
	__hsa_data__.args.hsa_agent_major_extension_supported.version_minor = (uint16_t *)version_minor; \
	__hsa_data__.args.hsa_agent_major_extension_supported.result = (bool* )result; \
};

#define GET_CB_ARGS_DATA_hsa_signal_create(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_create.initial_value = (hsa_signal_value_t )initial_value; \
	__hsa_data__.args.hsa_signal_create.num_consumers = (uint32_t )num_consumers; \
	__hsa_data__.args.hsa_signal_create.consumers = (const hsa_agent_t *)consumers; \
	__hsa_data__.args.hsa_signal_create.signal = (hsa_signal_t *)signal; \
};

#define GET_CB_ARGS_DATA_hsa_signal_destroy(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_destroy.signal = (hsa_signal_t )signal; \
};

#define GET_CB_ARGS_DATA_hsa_signal_load_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_load_scacquire.signal = (hsa_signal_t )signal; \
};

#define GET_CB_ARGS_DATA_hsa_signal_load_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_load_relaxed.signal = (hsa_signal_t )signal; \
};

#define GET_CB_ARGS_DATA_hsa_signal_load_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_load_acquire.signal = (hsa_signal_t )signal; \
};

#define GET_CB_ARGS_DATA_hsa_signal_store_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_store_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_store_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_store_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_store_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_store_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_store_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_store_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_store_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_silent_store_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_silent_store_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_silent_store_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_silent_store_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_silent_store_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_silent_store_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_exchange_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_exchange_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_exchange_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_scacq_screl.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_acq_rel.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_scacquire.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_acquire.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_relaxed.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_screlease.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_cas_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_cas_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_cas_release.expected = (hsa_signal_value_t )expected; \
	__hsa_data__.args.hsa_signal_cas_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_add_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_add_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_add_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_subtract_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_subtract_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_subtract_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_and_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_and_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_and_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_or_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_or_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_or_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_scacq_screl.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_scacq_screl.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_acq_rel.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_acq_rel.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_scacquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_acquire.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_relaxed.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_screlease.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_screlease.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_xor_release(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_xor_release.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_xor_release.value = (hsa_signal_value_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_wait_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_wait_scacquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_wait_scacquire.condition = (hsa_signal_condition_t )condition; \
	__hsa_data__.args.hsa_signal_wait_scacquire.compare_value = (hsa_signal_value_t )compare_value; \
	__hsa_data__.args.hsa_signal_wait_scacquire.timeout_hint = (uint64_t )timeout_hint; \
	__hsa_data__.args.hsa_signal_wait_scacquire.wait_state_hint = (hsa_wait_state_t )wait_state_hint; \
};

#define GET_CB_ARGS_DATA_hsa_signal_wait_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_wait_relaxed.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_wait_relaxed.condition = (hsa_signal_condition_t )condition; \
	__hsa_data__.args.hsa_signal_wait_relaxed.compare_value = (hsa_signal_value_t )compare_value; \
	__hsa_data__.args.hsa_signal_wait_relaxed.timeout_hint = (uint64_t )timeout_hint; \
	__hsa_data__.args.hsa_signal_wait_relaxed.wait_state_hint = (hsa_wait_state_t )wait_state_hint; \
};

#define GET_CB_ARGS_DATA_hsa_signal_wait_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_wait_acquire.signal = (hsa_signal_t )signal; \
	__hsa_data__.args.hsa_signal_wait_acquire.condition = (hsa_signal_condition_t )condition; \
	__hsa_data__.args.hsa_signal_wait_acquire.compare_value = (hsa_signal_value_t )compare_value; \
	__hsa_data__.args.hsa_signal_wait_acquire.timeout_hint = (uint64_t )timeout_hint; \
	__hsa_data__.args.hsa_signal_wait_acquire.wait_state_hint = (hsa_wait_state_t )wait_state_hint; \
};

#define GET_CB_ARGS_DATA_hsa_signal_group_create(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_group_create.num_signals = (uint32_t )num_signals; \
	__hsa_data__.args.hsa_signal_group_create.signals = (const hsa_signal_t *)signals; \
	__hsa_data__.args.hsa_signal_group_create.num_consumers = (uint32_t )num_consumers; \
	__hsa_data__.args.hsa_signal_group_create.consumers = (const hsa_agent_t *)consumers; \
	__hsa_data__.args.hsa_signal_group_create.signal_group = (hsa_signal_group_t *)signal_group; \
};

#define GET_CB_ARGS_DATA_hsa_signal_group_destroy(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_group_destroy.signal_group = (hsa_signal_group_t )signal_group; \
};

#define GET_CB_ARGS_DATA_hsa_signal_group_wait_any_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_group_wait_any_scacquire.signal_group = (hsa_signal_group_t )signal_group; \
	__hsa_data__.args.hsa_signal_group_wait_any_scacquire.conditions = (const hsa_signal_condition_t *)conditions; \
	__hsa_data__.args.hsa_signal_group_wait_any_scacquire.compare_values = (const hsa_signal_value_t *)compare_values; \
	__hsa_data__.args.hsa_signal_group_wait_any_scacquire.wait_state_hint = (hsa_wait_state_t )wait_state_hint; \
	__hsa_data__.args.hsa_signal_group_wait_any_scacquire.signal = (hsa_signal_t *)signal; \
	__hsa_data__.args.hsa_signal_group_wait_any_scacquire.value = (hsa_signal_value_t *)value; \
};

#define GET_CB_ARGS_DATA_hsa_signal_group_wait_any_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_signal_group_wait_any_relaxed.signal_group = (hsa_signal_group_t )signal_group; \
	__hsa_data__.args.hsa_signal_group_wait_any_relaxed.conditions = (const hsa_signal_condition_t *)conditions; \
	__hsa_data__.args.hsa_signal_group_wait_any_relaxed.compare_values = (const hsa_signal_value_t *)compare_values; \
	__hsa_data__.args.hsa_signal_group_wait_any_relaxed.wait_state_hint = (hsa_wait_state_t )wait_state_hint; \
	__hsa_data__.args.hsa_signal_group_wait_any_relaxed.signal = (hsa_signal_t *)signal; \
	__hsa_data__.args.hsa_signal_group_wait_any_relaxed.value = (hsa_signal_value_t *)value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_create(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_create.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_queue_create.size = (uint32_t )size; \
	__hsa_data__.args.hsa_queue_create.type = (hsa_queue_type32_t )type; \
	__hsa_data__.args.hsa_queue_create.callback = (void )callback; \
	__hsa_data__.args.hsa_queue_create.data = (void *)data; \
	__hsa_data__.args.hsa_queue_create.private_segment_size = (uint32_t )private_segment_size; \
	__hsa_data__.args.hsa_queue_create.group_segment_size = (uint32_t )group_segment_size; \
	__hsa_data__.args.hsa_queue_create.queue = (hsa_queue_t **)queue; \
};

#define GET_CB_ARGS_DATA_hsa_soft_queue_create(__hsa_data__) { \
	__hsa_data__.args.hsa_soft_queue_create.region = (hsa_region_t )region; \
	__hsa_data__.args.hsa_soft_queue_create.size = (uint32_t )size; \
	__hsa_data__.args.hsa_soft_queue_create.type = (hsa_queue_type32_t )type; \
	__hsa_data__.args.hsa_soft_queue_create.features = (uint32_t )features; \
	__hsa_data__.args.hsa_soft_queue_create.doorbell_signal = (hsa_signal_t )doorbell_signal; \
	__hsa_data__.args.hsa_soft_queue_create.queue = (hsa_queue_t **)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_destroy(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_destroy.queue = (hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_inactivate(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_inactivate.queue = (hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_load_read_index_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_load_read_index_acquire.queue = (const hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_load_read_index_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_load_read_index_scacquire.queue = (const hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_load_read_index_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_load_read_index_relaxed.queue = (const hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_load_write_index_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_load_write_index_acquire.queue = (const hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_load_write_index_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_load_write_index_scacquire.queue = (const hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_load_write_index_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_load_write_index_relaxed.queue = (const hsa_queue_t *)queue; \
};

#define GET_CB_ARGS_DATA_hsa_queue_store_write_index_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_store_write_index_relaxed.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_store_write_index_relaxed.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_store_write_index_release(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_store_write_index_release.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_store_write_index_release.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_store_write_index_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_store_write_index_screlease.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_store_write_index_screlease.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_acq_rel.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_acq_rel.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_acq_rel.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_scacq_screl.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_scacq_screl.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_scacq_screl.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_acquire.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_acquire.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_acquire.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_scacquire.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_scacquire.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_scacquire.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_relaxed.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_relaxed.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_relaxed.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_release(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_release.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_release.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_release.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_cas_write_index_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_cas_write_index_screlease.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_cas_write_index_screlease.expected = (uint64_t )expected; \
	__hsa_data__.args.hsa_queue_cas_write_index_screlease.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_acq_rel(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_acq_rel.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_acq_rel.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_scacq_screl(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_scacq_screl.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_scacq_screl.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_acquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_acquire.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_acquire.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_scacquire(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_scacquire.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_scacquire.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_relaxed.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_relaxed.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_release(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_release.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_release.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_add_write_index_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_add_write_index_screlease.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_add_write_index_screlease.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_store_read_index_relaxed(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_store_read_index_relaxed.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_store_read_index_relaxed.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_store_read_index_release(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_store_read_index_release.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_store_read_index_release.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_queue_store_read_index_screlease(__hsa_data__) { \
	__hsa_data__.args.hsa_queue_store_read_index_screlease.queue = (const hsa_queue_t *)queue; \
	__hsa_data__.args.hsa_queue_store_read_index_screlease.value = (uint64_t )value; \
};

#define GET_CB_ARGS_DATA_hsa_region_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_region_get_info.region = (hsa_region_t )region; \
	__hsa_data__.args.hsa_region_get_info.attribute = (hsa_region_info_t )attribute; \
	__hsa_data__.args.hsa_region_get_info.value = (void* )value; \
};

#define GET_CB_ARGS_DATA_hsa_agent_iterate_regions(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_iterate_regions.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_iterate_regions.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_agent_iterate_regions.data = (void* )data; \
};

#define GET_CB_ARGS_DATA_hsa_memory_allocate(__hsa_data__) { \
	__hsa_data__.args.hsa_memory_allocate.region = (hsa_region_t )region; \
	__hsa_data__.args.hsa_memory_allocate.size = (size_t )size; \
	__hsa_data__.args.hsa_memory_allocate.ptr = (void** )ptr; \
};

#define GET_CB_ARGS_DATA_hsa_memory_free(__hsa_data__) { \
	__hsa_data__.args.hsa_memory_free.ptr = (void* )ptr; \
};

#define GET_CB_ARGS_DATA_hsa_memory_copy(__hsa_data__) { \
	__hsa_data__.args.hsa_memory_copy.dst = (void *)dst; \
	__hsa_data__.args.hsa_memory_copy.src = (const void *)src; \
	__hsa_data__.args.hsa_memory_copy.size = (size_t )size; \
};

#define GET_CB_ARGS_DATA_hsa_memory_assign_agent(__hsa_data__) { \
	__hsa_data__.args.hsa_memory_assign_agent.ptr = (void *)ptr; \
	__hsa_data__.args.hsa_memory_assign_agent.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_memory_assign_agent.access = (hsa_access_permission_t )access; \
};

#define GET_CB_ARGS_DATA_hsa_memory_register(__hsa_data__) { \
	__hsa_data__.args.hsa_memory_register.ptr = (void *)ptr; \
	__hsa_data__.args.hsa_memory_register.size = (size_t )size; \
};

#define GET_CB_ARGS_DATA_hsa_memory_deregister(__hsa_data__) { \
	__hsa_data__.args.hsa_memory_deregister.ptr = (void *)ptr; \
	__hsa_data__.args.hsa_memory_deregister.size = (size_t )size; \
};

#define GET_CB_ARGS_DATA_hsa_isa_from_name(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_from_name.name = (const char *)name; \
	__hsa_data__.args.hsa_isa_from_name.isa = (hsa_isa_t *)isa; \
};

#define GET_CB_ARGS_DATA_hsa_agent_iterate_isas(__hsa_data__) { \
	__hsa_data__.args.hsa_agent_iterate_isas.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_agent_iterate_isas.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_agent_iterate_isas.data = (void *)data; \
};

#define GET_CB_ARGS_DATA_hsa_isa_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_get_info.isa = (hsa_isa_t )isa; \
	__hsa_data__.args.hsa_isa_get_info.attribute = (hsa_isa_info_t )attribute; \
	__hsa_data__.args.hsa_isa_get_info.index = (uint32_t )index; \
	__hsa_data__.args.hsa_isa_get_info.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_isa_get_info_alt(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_get_info_alt.isa = (hsa_isa_t )isa; \
	__hsa_data__.args.hsa_isa_get_info_alt.attribute = (hsa_isa_info_t )attribute; \
	__hsa_data__.args.hsa_isa_get_info_alt.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_isa_get_exception_policies(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_get_exception_policies.isa = (hsa_isa_t )isa; \
	__hsa_data__.args.hsa_isa_get_exception_policies.profile = (hsa_profile_t )profile; \
	__hsa_data__.args.hsa_isa_get_exception_policies.mask = (uint16_t *)mask; \
};

#define GET_CB_ARGS_DATA_hsa_isa_get_round_method(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_get_round_method.isa = (hsa_isa_t )isa; \
	__hsa_data__.args.hsa_isa_get_round_method.fp_type = (hsa_fp_type_t )fp_type; \
	__hsa_data__.args.hsa_isa_get_round_method.flush_mode = (hsa_flush_mode_t )flush_mode; \
	__hsa_data__.args.hsa_isa_get_round_method.round_method = (hsa_round_method_t *)round_method; \
};

#define GET_CB_ARGS_DATA_hsa_wavefront_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_wavefront_get_info.wavefront = (hsa_wavefront_t )wavefront; \
	__hsa_data__.args.hsa_wavefront_get_info.attribute = (hsa_wavefront_info_t )attribute; \
	__hsa_data__.args.hsa_wavefront_get_info.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_isa_iterate_wavefronts(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_iterate_wavefronts.isa = (hsa_isa_t )isa; \
	__hsa_data__.args.hsa_isa_iterate_wavefronts.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_isa_iterate_wavefronts.data = (void *)data; \
};

#define GET_CB_ARGS_DATA_hsa_isa_compatible(__hsa_data__) { \
	__hsa_data__.args.hsa_isa_compatible.code_object_isa = (hsa_isa_t )code_object_isa; \
	__hsa_data__.args.hsa_isa_compatible.agent_isa = (hsa_isa_t )agent_isa; \
	__hsa_data__.args.hsa_isa_compatible.result = (bool *)result; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_reader_create_from_file(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_reader_create_from_file.file = (hsa_file_t )file; \
	__hsa_data__.args.hsa_code_object_reader_create_from_file.code_object_reader = (hsa_code_object_reader_t *)code_object_reader; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_reader_create_from_memory(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_reader_create_from_memory.code_object = (const void *)code_object; \
	__hsa_data__.args.hsa_code_object_reader_create_from_memory.size = (size_t )size; \
	__hsa_data__.args.hsa_code_object_reader_create_from_memory.code_object_reader = (hsa_code_object_reader_t *)code_object_reader; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_reader_destroy(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_reader_destroy.code_object_reader = (hsa_code_object_reader_t )code_object_reader; \
};

#define GET_CB_ARGS_DATA_hsa_executable_create(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_create.profile = (hsa_profile_t )profile; \
	__hsa_data__.args.hsa_executable_create.executable_state = (hsa_executable_state_t )executable_state; \
	__hsa_data__.args.hsa_executable_create.options = (const char *)options; \
	__hsa_data__.args.hsa_executable_create.executable = (hsa_executable_t *)executable; \
};

#define GET_CB_ARGS_DATA_hsa_executable_create_alt(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_create_alt.profile = (hsa_profile_t )profile; \
	__hsa_data__.args.hsa_executable_create_alt.default_float_rounding_mode = (hsa_default_float_rounding_mode_t )default_float_rounding_mode; \
	__hsa_data__.args.hsa_executable_create_alt.options = (const char *)options; \
	__hsa_data__.args.hsa_executable_create_alt.executable = (hsa_executable_t *)executable; \
};

#define GET_CB_ARGS_DATA_hsa_executable_destroy(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_destroy.executable = (hsa_executable_t )executable; \
};

#define GET_CB_ARGS_DATA_hsa_executable_load_program_code_object(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_load_program_code_object.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_load_program_code_object.code_object_reader = (hsa_code_object_reader_t )code_object_reader; \
	__hsa_data__.args.hsa_executable_load_program_code_object.options = (const char *)options; \
	__hsa_data__.args.hsa_executable_load_program_code_object.loaded_code_object = (hsa_loaded_code_object_t *)loaded_code_object; \
};

#define GET_CB_ARGS_DATA_hsa_executable_load_agent_code_object(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_load_agent_code_object.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_load_agent_code_object.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_executable_load_agent_code_object.code_object_reader = (hsa_code_object_reader_t )code_object_reader; \
	__hsa_data__.args.hsa_executable_load_agent_code_object.options = (const char *)options; \
	__hsa_data__.args.hsa_executable_load_agent_code_object.loaded_code_object = (hsa_loaded_code_object_t *)loaded_code_object; \
};

#define GET_CB_ARGS_DATA_hsa_executable_freeze(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_freeze.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_freeze.options = (const char *)options; \
};

#define GET_CB_ARGS_DATA_hsa_executable_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_get_info.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_get_info.attribute = (hsa_executable_info_t )attribute; \
	__hsa_data__.args.hsa_executable_get_info.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_executable_global_variable_define(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_global_variable_define.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_global_variable_define.variable_name = (const char *)variable_name; \
	__hsa_data__.args.hsa_executable_global_variable_define.address = (void *)address; \
};

#define GET_CB_ARGS_DATA_hsa_executable_agent_global_variable_define(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_agent_global_variable_define.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_agent_global_variable_define.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_executable_agent_global_variable_define.variable_name = (const char *)variable_name; \
	__hsa_data__.args.hsa_executable_agent_global_variable_define.address = (void *)address; \
};

#define GET_CB_ARGS_DATA_hsa_executable_readonly_variable_define(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_readonly_variable_define.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_readonly_variable_define.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_executable_readonly_variable_define.variable_name = (const char *)variable_name; \
	__hsa_data__.args.hsa_executable_readonly_variable_define.address = (void *)address; \
};

#define GET_CB_ARGS_DATA_hsa_executable_validate(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_validate.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_validate.result = (uint32_t *)result; \
};

#define GET_CB_ARGS_DATA_hsa_executable_validate_alt(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_validate_alt.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_validate_alt.options = (const char *)options; \
	__hsa_data__.args.hsa_executable_validate_alt.result = (uint32_t *)result; \
};

#define GET_CB_ARGS_DATA_hsa_executable_get_symbol(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_get_symbol.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_get_symbol.module_name = (const char *)module_name; \
	__hsa_data__.args.hsa_executable_get_symbol.symbol_name = (const char *)symbol_name; \
	__hsa_data__.args.hsa_executable_get_symbol.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_executable_get_symbol.call_convention = (int32_t )call_convention; \
	__hsa_data__.args.hsa_executable_get_symbol.symbol = (hsa_executable_symbol_t *)symbol; \
};

#define GET_CB_ARGS_DATA_hsa_executable_get_symbol_by_name(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_get_symbol_by_name.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_get_symbol_by_name.symbol_name = (const char *)symbol_name; \
	__hsa_data__.args.hsa_executable_get_symbol_by_name.agent = (const hsa_agent_t *)agent; \
	__hsa_data__.args.hsa_executable_get_symbol_by_name.symbol = (hsa_executable_symbol_t *)symbol; \
};

#define GET_CB_ARGS_DATA_hsa_executable_symbol_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_symbol_get_info.executable_symbol = (hsa_executable_symbol_t )executable_symbol; \
	__hsa_data__.args.hsa_executable_symbol_get_info.attribute = (hsa_executable_symbol_info_t )attribute; \
	__hsa_data__.args.hsa_executable_symbol_get_info.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_executable_iterate_symbols(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_iterate_symbols.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_iterate_symbols.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_executable_iterate_symbols.data = (void *)data; \
};

#define GET_CB_ARGS_DATA_hsa_executable_iterate_agent_symbols(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_iterate_agent_symbols.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_iterate_agent_symbols.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_executable_iterate_agent_symbols.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_executable_iterate_agent_symbols.data = (void *)data; \
};

#define GET_CB_ARGS_DATA_hsa_executable_iterate_program_symbols(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_iterate_program_symbols.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_iterate_program_symbols.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_executable_iterate_program_symbols.data = (void *)data; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_serialize(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_serialize.code_object = (hsa_code_object_t )code_object; \
	__hsa_data__.args.hsa_code_object_serialize.alloc_callback = (hsa_status_t )alloc_callback; \
	__hsa_data__.args.hsa_code_object_serialize.callback_data = (hsa_callback_data_t )callback_data; \
	__hsa_data__.args.hsa_code_object_serialize.options = (const char *)options; \
	__hsa_data__.args.hsa_code_object_serialize.serialized_code_object = (void **)serialized_code_object; \
	__hsa_data__.args.hsa_code_object_serialize.serialized_code_object_size = (size_t *)serialized_code_object_size; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_deserialize(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_deserialize.serialized_code_object = (void *)serialized_code_object; \
	__hsa_data__.args.hsa_code_object_deserialize.serialized_code_object_size = (size_t )serialized_code_object_size; \
	__hsa_data__.args.hsa_code_object_deserialize.options = (const char *)options; \
	__hsa_data__.args.hsa_code_object_deserialize.code_object = (hsa_code_object_t *)code_object; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_destroy(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_destroy.code_object = (hsa_code_object_t )code_object; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_get_info.code_object = (hsa_code_object_t )code_object; \
	__hsa_data__.args.hsa_code_object_get_info.attribute = (hsa_code_object_info_t )attribute; \
	__hsa_data__.args.hsa_code_object_get_info.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_executable_load_code_object(__hsa_data__) { \
	__hsa_data__.args.hsa_executable_load_code_object.executable = (hsa_executable_t )executable; \
	__hsa_data__.args.hsa_executable_load_code_object.agent = (hsa_agent_t )agent; \
	__hsa_data__.args.hsa_executable_load_code_object.code_object = (hsa_code_object_t )code_object; \
	__hsa_data__.args.hsa_executable_load_code_object.options = (const char *)options; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_get_symbol(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_get_symbol.code_object = (hsa_code_object_t )code_object; \
	__hsa_data__.args.hsa_code_object_get_symbol.symbol_name = (const char *)symbol_name; \
	__hsa_data__.args.hsa_code_object_get_symbol.symbol = (hsa_code_symbol_t *)symbol; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_get_symbol_from_name(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_get_symbol_from_name.code_object = (hsa_code_object_t )code_object; \
	__hsa_data__.args.hsa_code_object_get_symbol_from_name.module_name = (const char *)module_name; \
	__hsa_data__.args.hsa_code_object_get_symbol_from_name.symbol_name = (const char *)symbol_name; \
	__hsa_data__.args.hsa_code_object_get_symbol_from_name.symbol = (hsa_code_symbol_t *)symbol; \
};

#define GET_CB_ARGS_DATA_hsa_code_symbol_get_info(__hsa_data__) { \
	__hsa_data__.args.hsa_code_symbol_get_info.code_symbol = (hsa_code_symbol_t )code_symbol; \
	__hsa_data__.args.hsa_code_symbol_get_info.attribute = (hsa_code_symbol_info_t )attribute; \
	__hsa_data__.args.hsa_code_symbol_get_info.value = (void *)value; \
};

#define GET_CB_ARGS_DATA_hsa_code_object_iterate_symbols(__hsa_data__) { \
	__hsa_data__.args.hsa_code_object_iterate_symbols.code_object = (hsa_code_object_t )code_object; \
	__hsa_data__.args.hsa_code_object_iterate_symbols.callback = (hsa_status_t )callback; \
	__hsa_data__.args.hsa_code_object_iterate_symbols.data = (void *)data; \
};

#endif