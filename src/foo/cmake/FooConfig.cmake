# Include created targets file
include("${CMAKE_CURRENT_LIST_DIR}/FooTargets.cmake")

# Public headers
get_filename_component(SELF_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(Foo_INCLUDE_DIRS "${SELF_DIR}/../../../include" ABSOLUTE)
#include(${SELF_DIR}/mylib-targets.cmake)
