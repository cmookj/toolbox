#include <str.hpp>

namespace gpw::str {
std::string_view ltrim(std::string_view str) {
    const auto pos(str.find_first_not_of(" \t\n\r\f\v"));
    str.remove_prefix(std::min(pos, str.length()));
    return str;
}

std::string_view rtrim(std::string_view str) {
    const auto pos(str.find_last_not_of(" \t\n\r\f\v"));
    str.remove_suffix(std::min(str.length() - pos - 1, str.length()));
    return str;
}

std::string_view trim(std::string_view str) {
    str = ltrim(str);
    str = rtrim(str);
    return str;
}

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
}
