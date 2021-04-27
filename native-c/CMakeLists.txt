cmake_minimum_required(VERSION 3.10)

# set the project name
project(happ LANGUAGES C)

include_directories("/usr/local/lib/erlang/erts-11.2/include/")

SET(CMAKE_C_FLAGS "-fPIC -undefined dynamic_lookup -o happ.so")
set(CMAKE_SHARED_LIBRARY_PREFIX "")
set(CMAKE_SHARED_LIBRARY_SUFFIX ".so")

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  set(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "${CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS} -undefined dynamic_lookup")
endif()

# add the library
add_library(happ SHARED src/lib.c)
