#include "filesystem.hpp"

#include <filesystem>

namespace gpw::fs {

std::string
append_suffix (const std::string& file_name, const std::string& suffix) {
    const auto pos = file_name.find_last_of ('.');
    const auto extension = file_name.substr (pos);
    return file_name.substr (0, pos) + suffix + extension;
}

std::filesystem::path
prepend_dir (const std::string& dir, const std::string& file_name) {
    return (
        dir.length() > 0
            ? std::filesystem::path {dir} / std::filesystem::path {file_name}
            : std::filesystem::path {file_name}
    );
}

} // namespace gpw::fs
