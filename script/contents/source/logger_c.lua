local logger_src = {}

function logger_src.content()
    return S._WARNING_MSG..[[ 

#include "]]..S._LOGGER_HEAD..[["

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

return logger_src

