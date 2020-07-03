# TODO: test the identification of dependencies
include(CMakeFindDependencyMacro)
if(xdrfile_ENABLED)
	list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")
	find_dependency(xdrfile REQUIRED)
endif()

# Include file with export set
include("${CMAKE_CURRENT_LIST_DIR}/FooTargets.cmake")
