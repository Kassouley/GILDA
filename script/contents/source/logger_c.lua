local logger_src = {}

function logger_src.content()
    return string.format([[
%s

#include "%s"

Logger logger = { NULL, {0}, 0 };  // Definition of the logger instance

// Function to get current time as a string
char* current_time() {
    time_t rawtime;
    struct tm *timeinfo;
    static char buffer[20];

    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(buffer, sizeof(buffer), "%s", timeinfo);
    return buffer;
}
]], 
        S._WARNING_MSG,
        S:_LOGGER_HEAD(), 
        "%Y-%m-%d %H:%M:%S"
    )
end

return logger_src

