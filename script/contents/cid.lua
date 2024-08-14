local src = {}
local hdr = {}

src.kpath = "_CID_SRC_PATH"
hdr.kpath = "_CID_HDR_PATH"


-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include <pthread.h>
#include <stdint.h>
#include "]]..S._CID_HDR..[["

// Thread-local storage for correlation IDs
static uint64_t global_correlation_id = 1;
static pthread_mutex_t global_correlation_mutex = PTHREAD_MUTEX_INITIALIZER;
static __thread uint64_t thread_correlation_id = 1;
static __thread pthread_mutex_t thread_correlation_mutex = PTHREAD_MUTEX_INITIALIZER;

// Initialize the correlation ID system for the current thread
]]..S._CID_INIT_FUNC_DECL..[[ 
{
    thread_correlation_id = 1;
    pthread_mutex_init(&thread_correlation_mutex, NULL);
}

// Get the next correlation ID for the global thread
]]..S._CID_GET_NEXT_FUNC_DECL..[[ 
{
    uint64_t id;

    pthread_mutex_lock(&global_correlation_mutex);
    id = global_correlation_id++;
    pthread_mutex_unlock(&global_correlation_mutex);

    pthread_mutex_lock(&thread_correlation_mutex);
    thread_correlation_id = id;
    pthread_mutex_unlock(&thread_correlation_mutex);

    return id;
}

// Get the current correlation ID for the current thread
]]..S._CID_GET_CURR_FUNC_DECL..[[ 
{
    uint64_t id;

    pthread_mutex_lock(&thread_correlation_mutex);
    id = thread_correlation_id;
    pthread_mutex_unlock(&thread_correlation_mutex);

    return id;
}

// Clean up the correlation ID system for the current thread

]]..S._CID_FINI_FUNC_DECL..[[ 
{
    // Clean up thread-local storage
    pthread_mutex_destroy(&thread_correlation_mutex);
}

]]
end


-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr.content(subcontents)
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
]]..S._CID_INIT_FUNC_DECL..[[;


/**
 * This function generates a unique correlation ID and assigns it to the
 * current thread.
 * 
 * @return Returns a `uint64_t` value, which is the correlation
 * ID that is generated and incremented from the `global_correlation_id`.
 */
]]..S._CID_GET_NEXT_FUNC_DECL..[[;


/**
 * This function retrieves the current correlation ID in a thread-safe manner.
 * 
 * @return Returns the current correlation ID stored in the
 * variable `thread_correlation_id`.
 */
]]..S._CID_GET_CURR_FUNC_DECL..[[;


/**
 * This function cleans up thread-local storage by destroying a mutex.
 */
]]..S._CID_FINI_FUNC_DECL..[[;


#ifdef __cplusplus
}
#endif

#endif // CORRELATION_ID_H
]]
end

return {src=src, hdr=hdr}
