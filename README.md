# C++ Template for C++ Library Project with Tests

This `BUILD` file indicates to build a C++ library and binary using the `cc_library` and `cc_test` rule,
respectively, provided by Bazel.

In the `cc_library` rule
* `name` attribute: the name of the library
* `srcs` attribute: source files
* `hdrs` attribute: header files
* `visibility` attribute: makes `point` library visible to `main` package
* `deps` attribute: dependencies

In the `cc_test` rule
* `name` attribute: the name of the binary
* `size` attribute: test size
* `srcs` attribute: source files
* `deps` attribute: dependencies

In `core/BUILD`:
```
cc_library(
    name = "point",
    srcs = ["point.cc"],
    hdrs = ["point.h"],
    visibility = ["//test:__pkg__"],
)
```

In `test/BUILD`:
```
cc_test(
    name = "point_test",
    size = "small",
    srcs = ["point_test.cc"],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "//core:point",
    ],
)
```

To test (with `c++23`):
```
GTEST_COLOR=1 bazel test --cxxopt=-std=c++23 --test_output=all //test:point_test
```
