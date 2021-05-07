cmake_minimum_required(VERSION 3.20)

# -----

# set the project name and version
project(hello-world VERSION 0.1)

include(CTest)

enable_testing()

# -----

# add the executable - hello-world
set(SRC
   src/main.cpp
   src/main_test.cpp
)

add_executable(hello-world ${SRC})

target_include_directories(hello-world PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(hello-world PUBLIC ${happ_INCLUDE_DIRS})

target_link_directories(hello-world PUBLIC ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
target_link_libraries(
    hello-world
    happ
    gtest
    gtest_main
)

set_target_properties(hello-world PROPERTIES OUTPUT_NAME "hello-world-cpp")
set_target_properties(hello-world PROPERTIES
     RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../../bin
)

add_test(NAME hello-world-test COMMAND hello-world)

# -----