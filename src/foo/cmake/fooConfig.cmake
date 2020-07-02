include("${CMAKE_CURRENT_LIST_DIR}/fooTargets.cmake")

get_filename_component(SELF_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
#include(${SELF_DIR}/mylib-targets.cmake)
get_filename_component(foo_INCLUDE_DIRS "${SELF_DIR}/../../../include" ABSOLUTE)
