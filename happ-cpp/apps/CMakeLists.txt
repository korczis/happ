cmake_minimum_required(VERSION 3.20)

# -----

# set the project name and version
project(hello-world VERSION 0.1)

# add the executable - hello-world
set(SRC_PROJECT_HELLO_WORLD
   hello-world/src/main.cpp
)

set(PROJECT_HELLO_WORLD_NAME "hello-world")

add_executable(${PROJECT_NAME} ${SRC_PROJECT_HELLO_WORLD})

target_include_directories(${PROJECT_HELLO_WORLD_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/hello-world/include)
target_include_directories(${PROJECT_HELLO_WORLD_NAME} PUBLIC ${happ_INCLUDE_DIRS})

target_link_directories(${PROJECT_HELLO_WORLD_NAME} PUBLIC ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
target_link_libraries(${PROJECT_HELLO_WORLD_NAME} happ)

set_target_properties(${PROJECT_HELLO_WORLD_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_HELLO_WORLD_NAME}-cpp")
set_target_properties(${PROJECT_HELLO_WORLD_NAME} PROPERTIES
     RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../bin
)

# -----