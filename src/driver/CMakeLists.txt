# Add the executable
add_executable(${FOO_DRIVER}-bin main.cpp)
target_link_libraries(${FOO_DRIVER}-bin PUBLIC ${LIB_FOO})
target_include_directories(${FOO_DRIVER}-bin PUBLIC ${CMAKE_SOURCE_DIR}/src)

# Allows the final name of the executable to be different than the target name
set_target_properties(${FOO_DRIVER}-bin PROPERTIES OUTPUT_NAME ${FOO_DRIVER})

# Install rules
install(TARGETS ${FOO_DRIVER}-bin DESTINATION bin)
