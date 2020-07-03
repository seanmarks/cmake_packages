# TODO: test the identification of dependencies
include(CMakeFindDependencyMacro)

# FIXME DEBUG
message(STATUS "xdrfile_ENABLED = ${xdrfile_ENABLED}")

# FIXME
if(xdrfile_ENABLED)
	list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")
	find_dependency(xdrfile)
endif()

# Include file with export set
include("${CMAKE_CURRENT_LIST_DIR}/FooTargets.cmake")
