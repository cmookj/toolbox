# ------------------------------------------------------------------------------
#   Functions to create .gitignore
# ------------------------------------------------------------------------------
function create_file_gitignore_bazel {
    echo "-- Creating .gitignore file for Bazel project"

    cat >.gitignore <<EOF
.DS_Store
MODULE.bazel.lock
bazel-bin
bazel-out
bazel-testlogs
bazel-*
compile_commands.json
EOF
}

function create_file_gitignore_cmake {
    echo "-- Creating .gitignore file for CMake project"

    cat >.gitignore <<EOF
.DS_Store
.cache
build
compile_commands.json
EOF
}

