cmake_minimum_required(VERSION 3.10)

# -----

# set the project name and version
project(happ VERSION 0.1)

# add the library
set(SRC_LIB
   src/lib.cpp
)

set(${PROJECT_NAME}_INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/include
    CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE
)

add_library(happ STATIC ${SRC_LIB})

target_include_directories(happ PUBLIC ${happ_INCLUDE_DIRS})
target_include_directories(happ PUBLIC ${gtest_INCLUDE_DIRS})
target_include_directories(happ PUBLIC ${gmock_INCLUDE_DIRS})

target_link_directories(happ PUBLIC ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
target_link_libraries(happ gmock)
target_link_libraries(happ gtest)

# -----