// -----------------------------------------------------------------------------
// Date & Time
// -----------------------------------------------------------------------------

#include <chrono>
#include <string>

namespace gpw::util::dt {

// Get string of time
const std::string current_time (const bool& readable = false);
const std::string current_time_milli (const bool& readable = false);

// Get string of date
const std::string current_date (const bool& readable = false);

// String representation of the seconds from the epoch of time (Thu. Jan. 1,
// 00:00:00 1970)
std::string seconds_from_epoch_as_string ();

long estimate_remain (int, int, long);
std::chrono::duration<double>
estimate_remain (int, int, const std::chrono::duration<double>&);

std::string to_string (const size_t, const size_t);
std::string to_string (long);
std::string to_string (const std::chrono::duration<double>& seconds);
std::string time_stamp (bool show_msec = false);
std::string time_stamp_utc (bool show_msec = false);
std::string time_stamp (long long msec, bool show_msec, bool utc);

} // namespace gpw::util::dt
