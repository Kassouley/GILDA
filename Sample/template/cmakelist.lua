local ContentManager = require("ContentManager")
local Content = require("Content")

cmakelist = setmetatable({}, ContentManager)
cmakelist.__index = cmakelist

function cmakelist:new(options, template_path, output_path)
    local attribute = {
        file_name = "CMakeLists.txt",
        is_sample = true,
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    if instance then setmetatable(instance, cmakelist) end
    return instance
end

function cmakelist:generate_content()
    return S:STRING("SAMPLE_MSG_2")..[[ 

# Minimum CMake version
cmake_minimum_required(VERSION 3.10)

# ]]..S:STRING("PROJECT_NAME")..[[ 
project(]]..S:STRING("PROJECT_NAME")..[[ VERSION 1.0.0)

# Set output directories for all binaries and libraries
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

set(CORE_PROJECT_NAME "]]..S:STRING("PROJECT_NAME|lower")..[[" CACHE STRING "]]..S:STRING("PROJECT_NAME")..[[ for the core part")

# Add subdirectory for the shared library
add_subdirectory(src/core)
add_subdirectory(src/plugins)
]]
end

return cmakelist, "COMMON"
