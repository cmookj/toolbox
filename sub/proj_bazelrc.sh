# ------------------------------------------------------------------------------
#   Functions to create .bazelrc
# ------------------------------------------------------------------------------
function create_file_bazelrc {
    echo "-- Creating .bazelrc file"

    cat >.bazelrc <<EOF
common --enable_platform_specific_config

# Unnamed defaults
build --cxxopt=-Wall
build --cxxopt=-Wextra

# Default standard
build --config=cxx23

# Unix-like compilers
build:cxx17 --cxxopt=-std=c++17
build:cxx20 --cxxopt=-std=c++20
build:cxx23 --cxxopt=-std=c++23
build:cxx26 --cxxopt=-std=c++2c

# Windows
build:windows:cxx17 --cxxopt=/std:c++17
build:windows:cxx20 --cxxopt=/std:c++20
build:windows:cxx23 --cxxopt=/std:c++23
build:windows:cxx26 --cxxopt=/std:c++latest

# Named optimization configs
build:opt --cxxopt=-O3
build:dbg --cxxopt=-O0 --cxxopt=-g

# macOS deployment
build:macos --macos_minimum_os=13.3
EOF
}

