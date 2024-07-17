#ifndef CALLBACK_H
#define CALLBACK_H

void callback_function(int is_enter, const char* func);
void set_interceptor_callback(void (*callback)(int is_enter, const char* func));

#endif
