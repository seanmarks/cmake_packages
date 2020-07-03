# Adapted from:
# - Talk by Daniel Pfeifer at C++Now 2017
# - CMake tutorial (https://gitlab.kitware.com/cmake/community/-/wikis/doc/tutorials/How-To-Find-Libraries)
# - FindBoost.cmake (cmake 3.15)

# Optionally, prefer static library
if(PREFER_STATIC_LIBS OR xdrfile_PREFER_STATIC_LIBS)
	# Save CMake variable
	set(_xdrfile_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})

	# Modify suffix preferences
	if(WIN32)
		list(INSERT CMAKE_FIND_LIBRARY_SUFFIXES 0 .lib .a)
	else()
		set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
	endif()
endif()

# Look for xdrfile
find_path(xdrfile_INCLUDE_DIR xdrfile/xdrfile_xtc.h
	HINTS ${XDRFILE_DIR}
)
find_library(xdrfile_LIBRARY xdrfile
	HINTS ${XDRFILE_DIR}
	NAMES libxdrfile.a xdrfile.a
)
mark_as_advanced(xdrfile_INCLUDE_DIR xdrfile_LIBRARY)

# Make sure everything works
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args( xdrfile
	REQUIRED_VARS xdrfile_INCLUDE_DIR xdrfile_LIBRARY
	)

if(xdrfile_FOUND)
	# Important variables
	set(xdrfile_LIBRARIES    ${xdrfile_LIBRARY})
	set(xdrfile_INCLUDE_DIRS ${xdrfile_INCLUDE_DIR})
endif()

if(xdrfile_FOUND AND NOT TARGET xdrfile::xdrfile)
	# Create an imported target under the appropriate "namespace"
	add_library(xdrfile::xdrfile UNKNOWN IMPORTED)  # TODO: UNKNOWN or INTERFACE?
	set_target_properties(xdrfile::xdrfile PROPERTIES
		IMPORTED_LOCATION "${xdrfile_LIBRARY}"
		INTERFACE_INCLUDE_DIRECTORIES "${xdrfile_INCLUDE_DIR}"
	)
	#	IMPORTED_LINK_INTERFACE_LANGUAGES "C" # TODO
endif()

# Reset CMake variable
if(PREFER_STATIC_LIBS OR xdrfile_PREFER_STATIC_LIBS)
	set(CMAKE_FIND_LIBRARY_SUFFIXES ${_xdrfile_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES})
endif()
