### LIB_FOO ###

# Builds main library: ${LIB_FOO}
# - TODO: Build both SHARED and OBJECT libraries

# Locate source files
# - All source files

# - Headers to publish
set(LIB_FOO_INCLUDES "")
list(APPEND LIB_FOO_INCLUDES "Foo.h")
#file(GLOB_RECURSE LIB_FOO_INCLUDES "${CMAKE_CURRENT_LIST_DIR}/*.h")

# Declare library
add_library(${LIB_FOO} OBJECT "")
target_sources(${LIB_FOO} PRIVATE "Foo.cpp")

# TODO
#include(GNUInstallDirs)

# FIXME
# Testing headers for public interface
target_include_directories(${LIB_FOO} PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
 	$<INSTALL_INTERFACE:include>
)

# FIXME
get_target_property(interface_dirs ${LIB_FOO} INCLUDE_DIRECTORIES)
message(STATUS "DEBUG: ${LIB_FOO}.INCLUDE_DIRECTORIES           = ${interface_dirs}")
get_target_property(interface_dirs ${LIB_FOO} INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "DEBUG: ${LIB_FOO}.INTERFACE_INCLUDE_DIRECTORIES = ${interface_dirs}")


set(CMAKE_INCLUDE_CURRENT_DIR              ON)
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

# FIXME
set(${PROJECT_NAME}_VERSION 3.4.1)

# Export header
# - TODO: Not recommended in modern CMake?
#include(GenerateExportHeader)
#generate_export_header(${LIB_FOO})

set_property(TARGET ${LIB_FOO} PROPERTY VERSION ${${PROJECT_NAME}_VERSION})
set_property(TARGET ${LIB_FOO} PROPERTY SOVERSION 3)
set_property(TARGET ${LIB_FOO} PROPERTY
  INTERFACE_${LIB_FOO}_MAJOR_VERSION 3)
set_property(TARGET ${LIB_FOO} APPEND PROPERTY
  COMPATIBLE_INTERFACE_STRING ${LIB_FOO}_MAJOR_VERSION
)

# Install library
install(TARGETS ${LIB_FOO}
	EXPORT ${LIB_FOO}Targets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
	OBJECTS DESTINATION lib
  INCLUDES DESTINATION include
)

# Install headers
install(
  FILES
    ${LIB_FOO_INCLUDES}
  DESTINATION
    include/${PROJECT_NAME}
  COMPONENT
    Devel
)
#    "${CMAKE_CURRENT_BINARY_DIR}/climbingstats_export.h"

# FIXME
#target_include_directories(${LIB_FOO} INTERFACE
#  # Ok, relocatable:
#  $<INSTALL_INTERFACE:include/${PROJECT_NAME}>
#)


######################
### Package Config ###
######################

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}ConfigVersion.cmake"
  VERSION ${${PROJECT_NAME}_VERSION}
  COMPATIBILITY AnyNewerVersion
)

export(EXPORT ${LIB_FOO}Targets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}Targets.cmake"
  NAMESPACE ${PROJECT_NAME}::
)
configure_file(cmake/${LIB_FOO}Config.cmake
  "${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}Config.cmake"
  COPYONLY
)

# Install package files
set(ConfigPackageLocation lib/cmake/${LIB_FOO})
# - Targets
#   - Note: keyword is usually FILES, but install(EXPORT) is special (?)
install(EXPORT ${LIB_FOO}Targets
  FILE
    ${LIB_FOO}Targets.cmake
  NAMESPACE
    ${PROJECT_NAME}::
  DESTINATION
    ${ConfigPackageLocation}
)
# - Version config file
install(
  FILES
    cmake/${LIB_FOO}Config.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/${LIB_FOO}/${LIB_FOO}ConfigVersion.cmake"
  DESTINATION
    ${ConfigPackageLocation}
  COMPONENT
    Devel
)
