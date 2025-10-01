cmake_minimum_required (VERSION 3.16)

set (CMAKE_CXX_STANDARD 23)

project (toolbox VERSION 0.0.1
                 DESCRIPTION "Basic routines for C++ development"
                 LANGUAGES CXX)

# GoogleTest requires at least C++17
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Dependencies
include(Dependencies.cmake)

enable_testing()

add_executable(toolbox_test
  test.cpp
)

target_link_libraries(toolbox_test PRIVATE
  toolbox
  GTest::gtest_main
)

target_include_directories(toolbox_test PRIVATE
  ${PROJECT_SOURCE_DIR}/toolbox/include
)

include(GoogleTest)
gtest_discover_tests(toolbox_test)

add_subdirectory(toolbox)


