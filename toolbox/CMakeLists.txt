cmake_minimum_required (VERSION 3.16)
project (toolbox VERSION 0.0.1
                 DESCRIPTION "Basic routines for C++ development"
                 LANGUAGES CXX)

add_library (toolbox STATIC
    ${PROJECT_SOURCE_DIR}/src/date_time.cpp
    ${PROJECT_SOURCE_DIR}/src/filesystem.cpp
    ${PROJECT_SOURCE_DIR}/src/log.cpp
    ${PROJECT_SOURCE_DIR}/src/str.cpp
    )

target_include_directories (toolbox PUBLIC
    ${PROJECT_SOURCE_DIR}/include)

