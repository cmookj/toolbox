cmake_minimum_required (VERSION 3.16..3.24)
project (toolbox VERSION 0.0.1
                 DESCRIPTION "Basic routines for C++ development"
                 LANGUAGES CXX)

add_library (lib_toolbox STATIC
    ${PROJECT_SOURCE_DIR}/src/filesystem.cpp
    ${PROJECT_SOURCE_DIR}/src/str.cpp
    )

target_include_directories (lib_toolbox PUBLIC
    ${PROJECT_SOURCE_DIR}/include)

