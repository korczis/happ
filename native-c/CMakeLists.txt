cmake_minimum_required(VERSION 3.10)

# set the project name
project(happ LANGUAGES C)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/;${CMAKE_MODULE_PATH}")

find_package(Erlang REQUIRED)

include_directories(${Erlang_ERTS_INCLUDE_DIRS})

SET(CMAKE_C_FLAGS "-fPIC -undefined dynamic_lookup -o happ.so")
set(CMAKE_SHARED_LIBRARY_PREFIX "")
set(CMAKE_SHARED_LIBRARY_SUFFIX ".so")

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  set(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "${CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS} -undefined dynamic_lookup")
endif()

# add the library
add_library(happ SHARED src/lib.c)
