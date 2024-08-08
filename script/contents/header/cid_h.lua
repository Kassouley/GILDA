local corrid_hdr = {}

function corrid_hdr.content(subcontents)
    return S._WARNING_MSG..[[ 

#ifndef CORRELATION_ID_H
#define CORRELATION_ID_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * The function initializes a correlation ID for a thread and initializes a mutex for thread
 * correlation.
 */
void init_correlation_id();


/**
 * The function `get_next_correlation_id` generates a unique correlation ID and assigns it to the
 * current thread.
 * 
 * @return The function `get_next_correlation_id` returns a `uint64_t` value, which is the correlation
 * ID that is generated and incremented from the `global_correlation_id`.
 */
uint64_t get_next_correlation_id();


/**
 * The function `get_curr_correlation_id` retrieves the current correlation ID in a thread-safe manner.
 * 
 * @return The function `get_curr_correlation_id` returns the current correlation ID stored in the
 * variable `thread_correlation_id`.
 */
uint64_t get_curr_correlation_id();


/**
 * The function `cleanup_correlation_id` cleans up thread-local storage by destroying a mutex.
 */
void cleanup_correlation_id();


#ifdef __cplusplus
}
#endif

#endif // CORRELATION_ID_H
]]
end

return corrid_hdr