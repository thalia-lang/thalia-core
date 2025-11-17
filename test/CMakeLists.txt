cmake_minimum_required(VERSION 3.17)
project(Test LANGUAGES C)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  set(CMAKE_C_STANDARD 11 CACHE STRING "The C standard to use")
  set(CMAKE_C_STANDARD_REQUIRED ON)
  set(CMAKE_C_EXTENSIONS ON)

  file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
  if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel free to remove CMakeCache.txt and CMakeFiles.")
  endif()

  add_compile_options(-m32 -Wall -Wextra -pedantic -Werror)
  add_link_options(-m32)
endif()

set(TEST_LIBRARY_PUBLIC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../public/cxx")
set(TEST_LIBRARY_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../build")
file(GLOB TEST_LIBRARY_SOURCES "${TEST_LIBRARY_SOURCE_DIR}/*.o")

set(TEST_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
file(GLOB TEST_SOURCES "${TEST_SOURCE_DIR}/*.c")

add_executable(test "${TEST_SOURCES}" "${TEST_LIBRARY_SOURCES}")
target_include_directories(test PRIVATE "${TEST_LIBRARY_SOURCES}" "${TEST_LIBRARY_PUBLIC_DIR}")

