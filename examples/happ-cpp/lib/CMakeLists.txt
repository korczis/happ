cmake_minimum_required(VERSION 3.16)

# -----

# set the project name and version
project(happ VERSION 0.1)

# -----

# add the library
set(SRC_LIB
   src/happ.cpp
)

set(happ_INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/include
    CACHE INTERNAL "happ: Include Directories" FORCE
)

add_library(happ STATIC ${SRC_LIB})

target_include_directories(happ PUBLIC ${happ_INCLUDE_DIRS})
target_include_directories(happ PUBLIC ${gtest_INCLUDE_DIRS})
target_include_directories(happ PUBLIC ${gmock_INCLUDE_DIRS})

target_link_directories(happ PUBLIC ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
target_link_libraries(
    happ
)

# -----

# set the project name and version
project(happ-main VERSION 0.1)

include(CTest)

enable_testing()

# -----

# add the target
set(SRC_LIB_MAIN
   src/happ_main.cpp
   src/happ_main_test.cpp
)

add_executable(happ-main ${SRC_LIB_MAIN})

target_include_directories(happ-main PUBLIC ${happ_INCLUDE_DIRS})
target_include_directories(happ-main PUBLIC ${gtest_INCLUDE_DIRS})
target_include_directories(happ-main PUBLIC ${gmock_INCLUDE_DIRS})

target_link_directories(happ-main PUBLIC ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
target_link_libraries(
    happ-main
    gtest
    gtest_main
)

set_target_properties(happ-main PROPERTIES
     RUNTIME_OUTPUT_DIRECTORY ${happ-main_BINARY_DIR}/../bin
)

add_test(NAME happ-main-test COMMAND happ-main)

# -----