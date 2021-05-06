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

# -----