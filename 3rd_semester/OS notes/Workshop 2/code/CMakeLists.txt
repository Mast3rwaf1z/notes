cmake_minimum_required(VERSION 3.0)
project(bbfs)

set(CMAKE_C_STANDARD 99)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules/")

find_package(fuse 2.6 REQUIRED)
add_definitions(${FUSE_DEFINITIONS})
include_directories(${FUSE_INCLUDE_DIRS})

set(SOURCE_FILES bbfs.c log.c)
add_executable(bbfs ${SOURCE_FILES})
target_link_libraries(bbfs ${FUSE_LIBRARIES})