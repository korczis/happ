# -----

cmake_minimum_required(VERSION 3.16)

# -----

# set the project name and version
project(fluid VERSION 0.1)

# add the executable - fluid
set(SRC_PROJECT_FLUID
   src/main.c
   src/solver.c
)

set(PROJECT_FLUID_NAME "fluid")

add_executable(${PROJECT_FLUID_NAME} ${SRC_PROJECT_FLUID})

target_link_libraries(${PROJECT_FLUID_NAME} glut GL GLU)
target_include_directories(${PROJECT_FLUID_NAME} PUBLIC /usr/local/include)
target_link_directories(${PROJECT_FLUID_NAME} PUBLIC /usr/local/lib)

set_target_properties(${PROJECT_FLUID_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_FLUID_NAME}-cpp")
set_target_properties(${PROJECT_FLUID_NAME} PROPERTIES
     RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../../bin/demos
)

# -----