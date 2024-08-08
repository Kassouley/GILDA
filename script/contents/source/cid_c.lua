local corrid_src = {}

function corrid_src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include <pthread.h>
#include <stdint.h>
#include "]]..S._CID_HEAD..[["

// Thread-local storage for correlation IDs
static uint64_t global_correlation_id = 1;
static pthread_mutex_t global_correlation_mutex = PTHREAD_MUTEX_INITIALIZER;
static __thread uint64_t thread_correlation_id = 1;
static __thread pthread_mutex_t thread_correlation_mutex = PTHREAD_MUTEX_INITIALIZER;

// Initialize the correlation ID system for the current thread
void init_correlation_id()
{
    thread_correlation_id = 1;
    pthread_mutex_init(&thread_correlation_mutex, NULL);
}

// Get the next correlation ID for the global thread
uint64_t get_next_correlation_id()
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
uint64_t get_curr_correlation_id()
{
    uint64_t id;

    pthread_mutex_lock(&thread_correlation_mutex);
    id = thread_correlation_id;
    pthread_mutex_unlock(&thread_correlation_mutex);

    return id;
}

// Clean up the correlation ID system for the current thread

void cleanup_correlation_id()
{
    // Clean up thread-local storage
    pthread_mutex_destroy(&thread_correlation_mutex);
}

]]
end

return corrid_src
