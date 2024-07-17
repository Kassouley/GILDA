#include <stdio.h>
#include <stdlib.h>
#include "callback.h"

void (*stored_callback)(int is_enter, const char* func);

void set_interceptor_callback(void (*callback)(int is_enter, const char* func)) 
{
    stored_callback = callback;
}

void callback_function(int is_enter, const char* func) 
{
    if (stored_callback) {
        stored_callback(is_enter, func);
    } else {
        fprintf(stderr, "No callback function has been set.\n");
    }
}
