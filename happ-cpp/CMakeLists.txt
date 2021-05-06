cmake_minimum_required(VERSION 3.10)

project("happ-cpp")

include(ExternalProject)

# -----

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# -----

# ExternalProject_Add(googletest
#     GIT_REPOSITORY "https://github.com/google/googletest.git"
#     UPDATE_COMMAND git pull "https://github.com/google/googletest.git"
#     PREFIX ${CMAKE_CURRENT_BINARY_DIR}/external/googletest
#     SOURCE_DIR "${PROJECT_SOURCE_DIR}/external/googletest"
#     CONFIGURE_COMMAND ""
#     BUILD_COMMAND     ""
#     INSTALL_COMMAND   ""
#     TEST_COMMAND      ""
# )

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

macro(print_all_variables)
    message(STATUS "print_all_variables------------------------------------------{")
    get_cmake_property(_variableNames VARIABLES)
    foreach (_variableName ${_variableNames})
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
    message(STATUS "print_all_variables------------------------------------------}")
endmacro()

# print_all_variables()

# -----