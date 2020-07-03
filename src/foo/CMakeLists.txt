### LIB_FOO ###

# Standard install locations
include(GNUInstallDirs)

# Declare library
add_library(${LIB_FOO} OBJECT "")
target_compile_options(${LIB_FOO} PUBLIC "$<$<CONFIG:DEBUG>:${FOO_OPT_DEBUG_FLAGS}>")
target_compile_options(${LIB_FOO} PUBLIC "$<$<CONFIG:RELEASE>:${FOO_OPT_RELEASE_FLAGS}>")

# Add source files
target_sources(${LIB_FOO} PRIVATE Foo.cpp)
target_sources(${LIB_FOO} PRIVATE Foo.h FooPrivateHeader.h)

# Headers to publish
set(LIB_FOO_INCLUDES "")
list(APPEND LIB_FOO_INCLUDES Foo.h)

# xdrfile
if(xdrfile_ENABLED)
	target_compile_definitions(${LIB_FOO} PUBLIC  HAVE_XDRFILE=1)
	target_link_libraries(${LIB_FOO} PUBLIC xdrfile::xdrfile)

	# FIXME: Should break if appropriate definitions aren't exported (?),
	# namely HAVE_XDRFILE=1
	target_include_directories(${LIB_FOO} PUBLIC ${xdrfile_INCLUDE_DIRS})
endif()

# Headers for public interface
target_include_directories(${LIB_FOO} PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
 	$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
	)
# Also may be useful:
#$<BUILD_INTERFACE:${${LIB_FOO}_BINARY_DIR}>  # for processed config.h
#$<BUILD_INTERFACE:${${LIB_FOO}_SOURCE_DIR}>

# The following may be useful at some point
#set(CMAKE_INCLUDE_CURRENT_DIR              ON)
#set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

# TODO: Library version stuff
set(LIB_FOO_VERSION 0.0.0)
set_property(TARGET ${LIB_FOO} PROPERTY VERSION ${LIB_FOO_VERSION})
set_property(TARGET ${LIB_FOO} PROPERTY SOVERSION 0)
set_property(TARGET ${LIB_FOO} PROPERTY INTERFACE_${LIB_FOO}_MAJOR_VERSION 0)
set_property(TARGET ${LIB_FOO}
	APPEND PROPERTY COMPATIBLE_INTERFACE_STRING ${LIB_FOO}_MAJOR_VERSION
	)

# Install library
# - Add to standard export set using EXPORT
install(TARGETS ${LIB_FOO}
	EXPORT ${LIB_FOO}Targets
	RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR}
	INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
	OBJECTS  DESTINATION ${CMAKE_INSTALL_LIBDIR}
	)

# Install public headers
install(
	FILES
		${LIB_FOO_INCLUDES}
	DESTINATION
		${CMAKE_INSTALL_INCLUDEDIR}/${LIB_FOO}
	COMPONENT
		Devel
	)


#########################
### Library Interface ###
#########################

set(ConfigPackageLocation ${CMAKE_INSTALL_LIBDIR}/cmake/${LIB_FOO})

# Install the export set
# - Targets
#   - Note: keyword is usually FILES, but install(EXPORT) is special and uses FILE (?)
install(EXPORT ${LIB_FOO}Targets
	FILE        ${LIB_FOO}Targets.cmake
	NAMESPACE   ${LIB_FOO}::
	DESTINATION ${ConfigPackageLocation}
	)

# Main configuration file
configure_file(cmake/${LIB_FOO}Config.cmake
	"${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}Config.cmake"
	COPYONLY
	)

# Version configuration file
# - Helps with checking for compatible versions
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}ConfigVersion.cmake"
	VERSION ${LIB_FOO_VERSION}
	COMPATIBILITY AnyNewerVersion
	)
	# alternative:  COMPATIBILITY SameMajorVersion

# Install configuration files
install(
	FILES
		cmake/${LIB_FOO}Config.cmake
		"${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}ConfigVersion.cmake"
	DESTINATION
		${ConfigPackageLocation}
	COMPONENT
		Devel
	)

# Modules required downstream
set(LIB_FOO_FIND_MODULES_INSTALL_LIST "")
if(xdrfile_ENABLED)
	list(APPEND LIB_FOO_FIND_MODULES_INSTALL_LIST "${CMAKE_SOURCE_DIR}/cmake/Findxdrfile.cmake")
endif()
if(LIB_FOO_FIND_MODULES_INSTALL_LIST)
	install(
		FILES
			${LIB_FOO_FIND_MODULES_INSTALL_LIST}
		DESTINATION
			${ConfigPackageLocation}/Modules
		COMPONENT
			Devel
	)
endif()
