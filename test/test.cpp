#include <gtest/gtest.h>
#include "str.hpp"

TEST(StringTest, TrimReduce) {
  const std::string foo = "    too much\t   \tspace\t\t\t  ";
  const std::string bar = "one\ntwo";

  EXPECT_EQ(trim(foo), "too much\t   \tspace");
  EXPECT_EQ(reduce(foo), "too much space");
  EXPECT_EQ(reduce(foo, "-"), "too-much-space");
  EXPECT_EQ(trim(bar), "one\ntwo");
}
