cmake_minimum_required(VERSION 3.10)

# -----

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/../bin)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# -----

# set(CMAKE_AUTOMOC ON)
# set(CMAKE_AUTORCC ON)
# set(CMAKE_AUTOUIC ON)

# FIND_PACKAGE(OpenGL REQUIRED)
# FIND_PACKAGE(GLUT REQUIRED)

# find_package(Qt5 COMPONENTS Core REQUIRED)

# ----

# set the project name and version
project(haap VERSION 0.1)

# add the library
set(SRCS_LIB
   lib/lib.cpp
)
add_library(happ STATIC ${SRCS_LIB})

# -----

# set the project name and version
project(fluid VERSION 0.1)

# add the executable - fluid
set(SRCS_APP_FLUID
   app/fluid/main.c
   app/fluid/solver.c
)
add_executable(fluid ${SRCS_APP_FLUID})
target_link_libraries(fluid glut GL GLU)
target_include_directories(fluid PUBLIC /usr/local/include)
target_link_directories(fluid PUBLIC /usr/local/lib)
set_target_properties(fluid PROPERTIES OUTPUT_NAME "fluid-cpp")

# -----

# set the project name and version
project(hello-world VERSION 0.1)

# add the executable - hello-world
set(SRCS_APP_HELLO_WORLD
   app/hello-world/main.cpp
)
add_executable(hello-world ${SRCS_APP_HELLO_WORLD})
target_include_directories(hello-world PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>/lib)
target_link_directories(hello-world PUBLIC $<BUILD_INTERFACE:${CMAKE_LIBRARY_OUTPUT_DIRECTORY}>)
target_link_libraries(hello-world happ)
set_target_properties(hello-world PROPERTIES OUTPUT_NAME "hello-world-cpp")

# -----