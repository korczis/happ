cmake_minimum_required(VERSION 3.10)

project("happ")

# -----

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# -----

add_subdirectory(lib)
add_subdirectory(apps)
add_subdirectory(demos)

# -----

execute_process(
    COMMAND "doxygen"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#   COMMAND "${CMAKE_COMMAND}" -E doxygen
#
# )

# -----