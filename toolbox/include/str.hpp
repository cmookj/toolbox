#include <string_view>
#include <string>

std::string_view ltrim(std::string_view str);
std::string_view rtrim(std::string_view str);
std::string_view trim(std::string_view str);

std::string trim(const std::string& str,
                 const std::string& whitespace = " \t");

std::string reduce(const std::string& str,
                   const std::string& fill = " ",
                   const std::string& whitespace = " \t");
