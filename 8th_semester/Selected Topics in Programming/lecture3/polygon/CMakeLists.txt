cmake_minimum_required(VERSION 3.15)
project(Polygon)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)

option(UBSAN "Undefined Behavior Sanitizer" OFF)
option(ASAN "Address Sanitizer" OFF)

if (UBSAN)
  message(STATUS "Enabling Undefined Behavior Sanitizer")
  add_compile_options(-fsanitize=undefined -fno-omit-frame-pointer)
  add_link_options(-fsanitize=undefined)
endif(UBSAN)

if (ASAN)
  message(STATUS "Enabling Address Sanitizer")
  add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
  add_link_options(-fsanitize=address)
endif(ASAN)

add_executable(polygon_test polygon_test.cpp polygon.cpp)
