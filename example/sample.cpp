#include "../toolbox/include/log.hpp"

#include <string>

int
main (int argc, char* argv[]) {
  // gpw::utils::logger_t logger;

  // logger.enable_console_output (true);

  gpw::info ("Hi, there!");
  gpw::warn ("Be careful...");
  gpw::error ("You are in a big trouble");

  return 0;
}
