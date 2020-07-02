# Add the executable
# - Use a special name for the driver's CMake target, since the driver's final name
#   may be the same as the library
set(FOO_DRIVER_TARGET "${FOO_DRIVER}-bin")
add_executable(${FOO_DRIVER_TARGET} main.cpp)
target_link_libraries(${FOO_DRIVER_TARGET} PUBLIC ${LIB_FOO})
target_include_directories(${FOO_DRIVER_TARGET} PUBLIC ${CMAKE_SOURCE_DIR}/src)
set_target_properties(${FOO_DRIVER_TARGET} PROPERTIES OUTPUT_NAME ${FOO_DRIVER})

# Install
install(TARGETS ${FOO_DRIVER_TARGET} DESTINATION bin)
