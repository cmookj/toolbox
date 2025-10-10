load("@rules_cc//cc:cc_binary.bzl", "cc_binary")
load("@rules_cc//cc:cc_library.bzl", "cc_library")

cc_test(
    name = "toolbox_test",
    size = "small",
    srcs = ["toolbox_test.cc"],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "//core:toolbox",
    ],
)
