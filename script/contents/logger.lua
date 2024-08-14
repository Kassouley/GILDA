local src = {}
local hdr = {}

src.kpath = "_LOGGER_SRC_PATH"
hdr.kpath = "_LOGGER_HDR_PATH"

-----------------------------
-- SOURCE CONTENT
-----------------------------
function src.content(subcontents)
    return S._WARNING_MSG..[[ 

#include "]]..S._LOGGER_HDR..[["

Logger logger = { NULL, {0}, 0 };  // Definition of the logger instance

// Function to get current time as a string
char* current_time() {
    time_t rawtime;
    struct tm *timeinfo;
    static char buffer[20];

    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(buffer, sizeof(buffer), "]].."%Y-%m-%d %H:%M:%S"..[[", timeinfo);
    return buffer;
}
]]
end


-----------------------------
-- HEADER CONTENT
-----------------------------
function hdr.content(subcontents)
    return S._WARNING_MSG..[[ 

#ifndef LOGGER_H
#define LOGGER_H

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdarg.h>

#define LOG_FILE "logfile.txt"
#define LOG_BUFFER_SIZE 1024
#define LOG_FLUSH_THRESHOLD (LOG_BUFFER_SIZE / 2)

// Logger structure
typedef struct {
    FILE *file;
    char buffer[LOG_BUFFER_SIZE];
    size_t buffer_len;
} Logger;

// Instance of the logger
extern Logger logger;

// Initialize the logger
#define ]]..S._LOG_INIT_MACRO..[[() do { \
    if (logger.file == NULL) { \
        logger.file = fopen(LOG_FILE, "a"); \
        if (logger.file == NULL) { \
            perror("Failed to open log file"); \
            exit(EXIT_FAILURE); \
        } \
    } \
} while (0)

// Flush the buffer to the file
#define ]]..S._LOG_FLUSH_MACRO..[[() do { \
    if (logger.file && logger.buffer_len > 0) { \
        fwrite(logger.buffer, 1, logger.buffer_len, logger.file); \
        fflush(logger.file); \
        logger.buffer_len = 0; \
    } \
} while (0)

// Log a message with format
#define ]]..S._LOG_MSG_MACRO..[[(format, ...) do { \
    if (logger.file != NULL) { \
        int len = snprintf(logger.buffer + logger.buffer_len, \
                           LOG_BUFFER_SIZE - logger.buffer_len, \
                           "[%s] " format "\n", current_time(), ##__VA_ARGS__); \
        if (len > 0) { \
            logger.buffer_len += len; \
            if (logger.buffer_len > LOG_FLUSH_THRESHOLD) { \
                ]]..S._LOG_FLUSH_MACRO..[[(); \
            } \
        } else { \
            fprintf(stderr, "Warning: Log message formatting failed\n"); \
        } \
    } else { \
        fprintf(stderr, "Error: Log file is not open\n"); \
    } \
} while (0)

// Close the logger
#define ]]..S._LOG_FINI_MACRO..[[() do { \
    ]]..S._LOG_FLUSH_MACRO..[[(); \
    if (logger.file) { \
        fclose(logger.file); \
        logger.file = NULL; \
    } \
} while (0)

// Function to get current time as a string
char* current_time();

#endif // LOGGER_H
]]
end

return {src=src, hdr=hdr}

