#include <str.hpp>

std::string trim(const std::string& str,
                 const std::string& whitespace)
{
    const auto begin = str.find_first_not_of(whitespace);
    if (begin == std::string::npos)
        return ""; // no content

    const auto end = str.find_last_not_of(whitespace);
    const auto range = end - begin + 1;

    return str.substr(begin, range);
}

std::string reduce(const std::string& str,
                   const std::string& fill,
                   const std::string& whitespace)
{
    // trim first
    auto result = trim(str, whitespace);

    // replace sub ranges
    auto begin_space = result.find_first_of(whitespace);
    while (begin_space != std::string::npos)
    {
        const auto end_space = result.find_first_not_of(whitespace, begin_space);
        const auto range = end_space - begin_space;

        result.replace(begin_space, range, fill);

        const auto new_begin = begin_space + fill.length();
        begin_space = result.find_first_of(whitespace, new_begin);
    }

    return result;
}
