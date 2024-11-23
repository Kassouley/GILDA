# Minimum CMake version
cmake_minimum_required(VERSION 3.10)

# Project name and type (shared library)
project(${CORE_PROJECT_NAME} VERSION 1.0.0 LANGUAGES C CXX)

# Set the output library name
set(LIBRARY_NAME ${CORE_PROJECT_NAME})

# Find all source files in the current directory (both .c and .cpp)
file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
)

# Find all header files in the current directory
file(GLOB_RECURSE HEADERS CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp"
)

# Collect unique directories containing header files
set(HEADER_DIRS "")
foreach(header ${HEADERS})
    get_filename_component(header_dir ${header} DIRECTORY)
    list(APPEND HEADER_DIRS ${header_dir})
endforeach()

# Remove duplicates from the list of directories
list(REMOVE_DUPLICATES HEADER_DIRS)

# Add the shared library (create the target first)
add_library(${LIBRARY_NAME} SHARED ${SOURCES} ${HEADERS})

# Add include directories for ROCm and project headers
target_include_directories(${LIBRARY_NAME}
    PUBLIC
        ${ROCM_PATH}/include
        ${HEADER_DIRS}
)

target_include_directories(${LIBRARY_NAME} PUBLIC .)
