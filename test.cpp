#include "filesystem.hpp"
#include "str.hpp"

#include <gtest/gtest.h>

using namespace gpw::str;

TEST (StringTest, TrimReduce) {
    const std::string foo = "    too much\t   \tspace\t\t\t  ";
    const std::string bar = "one\ntwo";

    EXPECT_EQ (trim (foo), "too much\t   \tspace");
    EXPECT_EQ (reduce (foo), "too much space");
    EXPECT_EQ (reduce (foo, "-"), "too-much-space");
    EXPECT_EQ (trim (bar), "one\ntwo");
}

TEST (StringViewTest, Trim) {
    std::string str = "   hello world   ";
    EXPECT_EQ (ltrim (str), "hello world   ");
    EXPECT_EQ (rtrim (str), "   hello world");
    EXPECT_EQ (trim (str), "hello world");
}

TEST (String, KMP) {
    {
        std::string S = "ABC ABCDAB ABCDABCDABDE";
        std::string W = "ABCDABD";

        // std::vector<int> indices = positions_in_string (S, W);
        std::vector<int> indices = search (W, S);

        EXPECT_EQ (indices.size(), 1);
        EXPECT_EQ (indices[0], 15);
    }

    {
        std::string S = "aabaacaadaabaaba";
        std::string W = "aaba";

        // std::vector<int> indices = positions_in_string (S, W);
        std::vector<int> indices = search (W, S);

        EXPECT_EQ (indices.size(), 3);
        EXPECT_EQ (indices[0], 0);
        EXPECT_EQ (indices[1], 9);
        EXPECT_EQ (indices[2], 12);
    }

    {
        std::string S = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        std::string W = "aaaa";

        // std::vector<int> indices = positions_in_string (S, W);
        std::vector<int> indices = search (W, S);

        EXPECT_EQ (indices.size(), 40);
        for (int i = 0; i < 40; ++i) {
            EXPECT_EQ (indices[i], i);
        }
    }

    {
        std::string S = "aabaaabaaaabaaaaabaaaaaabaaac";
        std::string W = "aabaaac";

        // std::vector<int> indices = positions_in_string (S, W);
        std::vector<int> indices = search (W, S);

        EXPECT_EQ (indices.size(), 1);
        EXPECT_EQ (indices[0], 22);
    }
}
