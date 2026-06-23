# ------------------------------------------------------------------------------
#   For Zig
# ------------------------------------------------------------------------------
function print_zig_project_skeleton_usage {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to build & run the project"
    echo "--------------------------------------------------------------------------------"
    echo ""
    echo "To build & run the project"
    echo "    zig build run"
    echo "To run tests"
    echo "    zig build test"
    echo ""
}

# ------------------------------------------------------------------------------
#   Templates
# ------------------------------------------------------------------------------
function create_zig_project {
    echo "Creating Zig project"

    mkdir $PROJ_NAME && cd $PROJ_NAME && zig init && git init

    create_file_license_mit

    print_zig_project_skeleton_usage
}
