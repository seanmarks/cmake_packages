### LIB_FOO ###

# Standard install locations
include(GNUInstallDirs)

# Declare library
add_library(Foo OBJECT "")
target_compile_options(Foo PUBLIC "$<$<CONFIG:DEBUG>:${FOO_OPT_DEBUG_FLAGS}>")
target_compile_options(Foo PUBLIC "$<$<CONFIG:RELEASE>:${FOO_OPT_RELEASE_FLAGS}>")

# Add source files
target_sources(Foo PRIVATE Foo.cpp)
target_sources(Foo PRIVATE Foo.h FooPrivateHeader.h)

# Headers to publish
set(LIB_FOO_INCLUDES "")
list(APPEND LIB_FOO_INCLUDES Foo.h)

# xdrfile
if(xdrfile_ENABLED)
	target_compile_definitions(Foo PUBLIC HAVE_XDRFILE=1)
	target_link_libraries(Foo PRIVATE xdrfile::xdrfile)
	#target_link_libraries(Foo PUBLIC xdrfile::xdrfile)

	# FIXME: Should break if appropriate definitions aren't exported (?),
	# namely HAVE_XDRFILE=1
	target_include_directories(Foo PUBLIC ${xdrfile_INCLUDE_DIRS})
endif()

# Headers for public interface
target_include_directories(Foo PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
 	$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
	)
# Also may be useful:
#$<BUILD_INTERFACE:${Foo_BINARY_DIR}>  # for processed config.h
#$<BUILD_INTERFACE:${Foo_SOURCE_DIR}>

# The following may be useful at some point
#set(CMAKE_INCLUDE_CURRENT_DIR              ON)
#set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

# TODO: Library version stuff
set(LIB_FOO_VERSION 0.0.0)
set_property(TARGET Foo PROPERTY VERSION ${LIB_FOO_VERSION})
set_property(TARGET Foo PROPERTY SOVERSION 0)
set_property(TARGET Foo PROPERTY INTERFACE_Foo_MAJOR_VERSION 0)
set_property(TARGET Foo
	APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Foo_MAJOR_VERSION
	)

# Install library
# - Add to standard export set using EXPORT
install(TARGETS Foo
	EXPORT FooTargets
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
		${CMAKE_INSTALL_INCLUDEDIR}/Foo
	COMPONENT
		Devel
	)


#########################
### Library Interface ###
#########################

set(ConfigPackageLocation ${CMAKE_INSTALL_LIBDIR}/cmake/Foo)
include(CMakePackageConfigHelpers)

# Install the export set
# - Targets
#   - Note: keyword is usually FILES, but install(EXPORT) is special and uses FILE (?)
install(EXPORT FooTargets
	FILE        FooTargets.cmake
	NAMESPACE   Foo::
	DESTINATION ${ConfigPackageLocation}
	)

# Main configuration file
configure_package_config_file(
	"${CMAKE_CURRENT_LIST_DIR}/cmake/FooConfig.cmake.in"
	"${CMAKE_CURRENT_BINARY_DIR}/Foo/FooConfig.cmake"
	PATH_VARS xdrfile_INCLUDE_DIRS
	INSTALL_DESTINATION ${ConfigPackageLocation}
	)

# Version configuration file
# - Helps with checking for compatible versions
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/Foo/FooConfigVersion.cmake"
	VERSION ${LIB_FOO_VERSION}
	COMPATIBILITY AnyNewerVersion
	)
	# alternative:  COMPATIBILITY SameMajorVersion

# Install configuration files
install(
	FILES
		"${CMAKE_CURRENT_BINARY_DIR}/Foo/FooConfig.cmake"
		"${CMAKE_CURRENT_BINARY_DIR}/Foo/FooConfigVersion.cmake"
	DESTINATION
		${ConfigPackageLocation}
	COMPONENT
		Devel
	)

# Modules required downstream
# - Append each find module required
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
