cmake_minimum_required(VERSION 3.16)

include(ExternalProject)

# -----

project("happ-cpp")

include(CTest)

enable_testing()

# -----

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# -----

set(gtest_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/external/gtest/googletest/include"
    CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE
)

set(gmock_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/external/gtest/googlemock/include"
    CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE
)

# -----

add_subdirectory(external/gtest)
add_subdirectory(lib)
add_subdirectory(apps)
add_subdirectory(demos)

# -----

# macro(print_all_variables)
#     message(STATUS "print_all_variables------------------------------------------{")
#     get_cmake_property(_variableNames VARIABLES)
#     foreach (_variableName ${_variableNames})
#         message(STATUS "${_variableName}=${${_variableName}}")
#     endforeach()
#     message(STATUS "print_all_variables------------------------------------------}")
# endmacro()

# print_all_variables()

# -----