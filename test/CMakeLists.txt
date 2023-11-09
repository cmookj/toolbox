# BUILD_TESTING variable is created by include(CTest)
# It is set to ON by default
if (BUILD_TESTING)
    add_executable (tbx_test test.cpp)
    target_link_libraries (tbx_test PRIVATE 
        lib_toolbox
        GTest::gtest_main)
    
    target_include_directories (tbx_test PRIVATE 
        ${PROJECT_SOURCE_DIR}/toolbox/include)
    
    include (GoogleTest)
    # Finds all the Google tests associated with the executable
    gtest_discover_tests (tbx_test)
endif()
