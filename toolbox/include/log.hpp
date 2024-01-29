#include <filesystem>
#include <string>
#include <string_view>
#include <vector>

namespace fs = std::filesystem;

namespace gpw::utils {

class logger_t {
public:
    logger_t() = default;
    virtual ~logger_t() = default;

    logger_t (const logger_t&) = default;
    logger_t (logger_t&&) = default;

    logger_t& operator= (const logger_t&) = default;
    logger_t& operator= (logger_t&&) = default;

    void enable_console_output (const bool&);

    void info (const std::string_view);
    void warn (const std::string_view);
    void error (const std::string_view);

    void write (const fs::path&, const bool flush = true);

private:
    void _log (const size_t, const std::string_view);

    bool _console_output_enabled;
    std::vector<std::string> _logs;
    std::vector<char> _prefixes = {' ', '*', '!'};
};

} // namespace gpw::utils
