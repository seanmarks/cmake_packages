### LIB_FOO ###

include(GenerateExportHeader)

# Builds main library: ${LIB_FOO}
# - TODO: Build both SHARED and OBJECT libraries

# Locate source files
file(GLOB_RECURSE LIB_FOO_SRC      "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.h")
file(GLOB_RECURSE LIB_FOO_INCLUDES "${CMAKE_CURRENT_LIST_DIR}/*.h")

# Declare library
add_library(${LIB_FOO} ${LIB_FOO_SRC})
#add_library(${LIB_FOO} OBJECT ${LIB_FOO_SRC})

# TODO
generate_export_header(${LIB_FOO})

# Where the libraries should be installed
install(TARGETS ${LIB_FOO} EXPORT ${LIB_FOO}Targets
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	RUNTIME DESTINATION bin
	INCLUDES DESTINATION include
)

# Install headers
# - FIXME: can this be done better above?
install(
	FILES ${LIB_FOO_INCLUDES}
	DESTINATION include
)

install(EXPORT ${LIB_FOO}Targets
	DESTINATION lib/cmake/${LIB_FOO}
	FILE ${LIB_FOO}Targets.cmake
)
	#DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${LIB_FOO}


#install(
#	TARGETS ${LIB_FOO}
#	LIBRARY DESTINATION lib
#)


# TODO Shared library
#set(LIB_FOO_SHARED "${LIB_FOO}.shared")
#add_library(${LIB_FOO_SHARED} SHARED ${LIB_FOO_SRC})
#install(TARGETS ${LIB_FOO_SHARED} DESTINATION lib)
