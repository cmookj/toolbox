#include <string>
#include <filesystem>

namespace gpw::fs {

std::string append_suffix (const std::string& file_name, const std::string& suffix);

std::filesystem::path prepend_dir (const std::string& dir, const std::string& file_name);

}
