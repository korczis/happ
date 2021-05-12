# -----

cmake_minimum_required(VERSION 3.16)

include(ExternalProject)

# -----

project("happ-demos")

include(CTest)

enable_testing()

# -----

add_subdirectory(fluid)

# -----