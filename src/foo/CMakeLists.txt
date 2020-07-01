### LIB_FOO ###

# Builds main library: ${LIB_FOO}
# - TODO: Build both SHARED and OBJECT libraries

# Locate source files
file(GLOB_RECURSE LIB_FOO_SRC "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.h")

# Declare libraries
add_library(${LIB_FOO} ${LIB_FOO_SRC})
#add_library(${LIB_FOO} OBJECT ${LIB_FOO_SRC})

# Where the libraries should be installed
install(
	TARGETS ${LIB_FOO}
	DESTINATION lib
)

# TODO Shared library
#set(LIB_FOO_SHARED "${LIB_FOO}.shared")
#add_library(${LIB_FOO_SHARED} SHARED ${LIB_FOO_SRC})
#install(TARGETS ${LIB_FOO_SHARED} DESTINATION lib)
