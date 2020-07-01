cmake_minimum_required(VERSION 3.15)

# Include directory with custom CMake modules
# - These contain useful helper functions
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(setIfUnset)

project(Foo)

# Require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Default to 'Release' build type
setIfUnset(CMAKE_BUILD_TYPE Release)

# Verbose output
# - TODO: restrict to 'debug'?
set(CMAKE_VERBOSE_MAKEFILE ON)

# Put all binaries and libraries into subdirectories, instead of the main 'build' directory
# - Adapted from CMake tutorial (v3.15)
setIfUnset(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
setIfUnset(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")
setIfUnset(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")


#######################################
### Important variables and options ###
#######################################

# Output names
set(LIB_FOO    "foo" CACHE STRING "Name of the library to be created")
set(FOO_DRIVER "${PROJECT_NAME}" CACHE STRING "Name of the executable")


#################
### Libraries ###
#################

# TODO: function for finding libraries specified via command line
# - Generalize to finding static and shared versions
# - Use 'target_link_libraries' and 'target_include_directories' instead
#   for finer-grained control?

### xdrfile ###


######################
### Compiler Flags ###
######################

# Basic flags
add_compile_options(-g -Wall)
#target_compile_options(${PROJECT_NAME} PUBLIC -g -Wall)

# Optimizations
set(FOO_OPT_DEBUG_FLAGS   -O0)
set(FOO_OPT_RELEASE_FLAGS -O3 -ffast-math -march=native)
#if(GNU)
	#list(APPEND FOO_OPT_RELEASE_FLAGS -ftree-vectorize)
#endif()
add_compile_options("$<$<CONFIG:DEBUG>:${FOO_OPT_DEBUG_FLAGS}>")
add_compile_options("$<$<CONFIG:RELEASE>:${FOO_OPT_RELEASE_FLAGS}>")
#target_compile_options(${PROJECT_NAME} PUBLIC "$<$<CONFIG:DEBUG>:${FOO_OPT_DEBUG_FLAGS}>")
#target_compile_options(${PROJECT_NAME} PUBLIC "$<$<CONFIG:RELEASE>:${FOO_OPT_RELEASE_FLAGS}>")


#############
### Build ###
#############

add_subdirectory(src)


############
### Test ###
############

### Configuration File ###

# Compiling standalone
#add_definitions(-DFOO_STANDALONE_MODE)
# configure_file(config.h.in config.h)

# Add the binary tree to the search path for include files
#include_directories("${PROJECT_BINARY_DIR}")
