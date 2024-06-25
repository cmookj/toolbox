#include "str.hpp"

#include <stdexcept>

namespace gpw::str {

#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)
const string illegal_chars = "\\/:?\"<>|";
#elif __APPLE__
const std::string illegal_chars = "\\/:?\"<>|";
#elif __linux__
const std::string illegal_chars = "\\/";
#else
#error "Unknown compiler"
#endif

std::string_view ltrim (std::string_view str) {
    const auto pos (str.find_first_not_of (" \t\n\r\f\v"));
    str.remove_prefix (std::min (pos, str.length()));
    return str;
}

std::string_view rtrim (std::string_view str) {
    const auto pos (str.find_last_not_of (" \t\n\r\f\v"));
    str.remove_suffix (std::min (str.length() - pos - 1, str.length()));
    return str;
}

std::string_view trim (std::string_view str) {
    str = ltrim (str);
    str = rtrim (str);
    return str;
}

std::string trim (const std::string& str, const std::string& whitespace) {
    const auto begin = str.find_first_not_of (whitespace);
    if (begin == std::string::npos)
        return ""; // no content

    const auto end = str.find_last_not_of (whitespace);
    const auto range = end - begin + 1;

    return str.substr (begin, range);
}

std::string reduce (
    const std::string& str,
    const std::string& fill,
    const std::string& whitespace
) {
    // trim first
    auto result = trim (str, whitespace);

    // replace sub ranges
    auto begin_space = result.find_first_of (whitespace);
    while (begin_space != std::string::npos) {
        const auto end_space =
            result.find_first_not_of (whitespace, begin_space);
        const auto range = end_space - begin_space;

        result.replace (begin_space, range, fill);

        const auto new_begin = begin_space + fill.length();
        begin_space = result.find_first_of (whitespace, new_begin);
    }

    return result;
}

std::string to_upper (std::string source_str) {
    std::transform (
        source_str.begin(), source_str.end(), source_str.begin(), ::toupper
    );
    return source_str;
}

std::string to_lower (std::string source_str) {
    std::transform (
        source_str.begin(), source_str.end(), source_str.begin(), ::tolower
    );
    return source_str;
}

std::string remove_illegal_char (std::string str) {
    for (std::string::iterator it = str.begin(); it < str.end(); ++it) {
        bool found = illegal_chars.find (*it) != std::string::npos;
        if (found) {
            *it = '-';
        }
    }
    return str;
}

int compare (std::string str1, std::string str2) {
    return to_lower (str1).compare (to_lower (str2));
}

std::string format (const char* s) {
    if (s == nullptr)
        return std::string {};

    std::stringstream ss;
    while (*s) {
        switch (*s) {
        case '{':
            if (*(s + 1) == '}')
                throw std::runtime_error {"invalid format: missing arguments"};
            else if (*(s + 1) == '{') {
                ss << '{';
                s += 2;
            } else
                throw std::runtime_error {
                    "invalid format: { should be followed by another { or }"
                };

            break;

        case '}':
            if (*(s + 1) == '}') {
                ss << '}';
                s += 2;
            } else
                throw std::runtime_error {
                    "invalid format: } should be followed by another }"
                };

            break;

        default:
            ss << *s++;
        }
    }
    return ss.str();
}

} // namespace gpw::str
