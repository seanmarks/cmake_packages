### LIB_FOO ###

# This directory contains the core src files
add_subdirectory(foo)


### Driver ###

# Add the executable
add_executable(${FOO_DRIVER} driver/main.cpp)
target_link_libraries(${FOO_DRIVER} PUBLIC ${LIB_FOO})
target_include_directories(${FOO_DRIVER} PUBLIC ${CMAKE_SOURCE_DIR}/src)

# Install rules
install(TARGETS ${FOO_DRIVER} DESTINATION bin)
