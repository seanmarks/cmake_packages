### LIB_FOO ###

# Builds main library: ${LIB_FOO}
# - TODO: Build both SHARED and OBJECT libraries

# Locate source files
# - All source files
file(GLOB_RECURSE LIB_FOO_SRC      "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.h")
# - Headers to publish
file(GLOB_RECURSE LIB_FOO_INCLUDES "${CMAKE_CURRENT_LIST_DIR}/*.h")

# Declare library
add_library(${LIB_FOO} "")
target_sources(${LIB_FOO} PRIVATE ${LIB_FOO_SRC})
#add_library(${LIB_FOO} OBJECT ${LIB_FOO_SRC})

#include(GNUInstallDirs)

set(CMAKE_INCLUDE_CURRENT_DIR              ON)
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

# FIXME
set(${PROJECT_NAME}_VERSION 3.4.1)

# Export header
# - TODO: Not recommended in modern CMake?
include(GenerateExportHeader)
generate_export_header(${LIB_FOO})

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
  INCLUDES DESTINATION include
)

# Install headers
install(
  FILES
    ${LIB_FOO_INCLUDES}
  DESTINATION
    include
  COMPONENT
    Devel
)
#    "${CMAKE_CURRENT_BINARY_DIR}/climbingstats_export.h"


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
