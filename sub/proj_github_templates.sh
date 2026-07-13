DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
SUB="$DIR"
. "$SUB/common.sh"
. "$SUB/proj_license.sh"
. "$SUB/proj_bazelrc.sh"
. "$SUB/proj_gitignore.sh"

REPOSITORY_CMAKE="$HOME/Documents/3-resources/templates/cmake"
REPOSITORY_BAZEL="$HOME/Documents/3-resources/templates/bazel"

function clone_templates_from_github {
    local repository="$1"

    if [ -d "$repository" ]; then
        echo "Templates repository exists at $repository"
        local previous_path=$(pwd)
        cd "$repository" && git pull
        cd $previous_path
    else
        echo "Cloning templates.git from GitHub"
        git clone git@github.com:cmookj/templates.git "$repository"
    fi
}

# ------------------------------------------------------------------------------
#  For Bazel Templates
# ------------------------------------------------------------------------------
function print_usage_bazel_cpp_binary {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to build & run the target"
    echo "--------------------------------------------------------------------------------"
    echo ""
    echo "To build"
    echo "    cd __PROJECT_DIR__"
    echo "    bazel build --config=cxx23 //main:hello"
    echo ""
    echo "To print output file path"
    echo "    bazel cquery --output=files //main:hello"
    echo ""
}

function print_usage_bazel_cpp_library {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to build & test the target"
    echo "--------------------------------------------------------------------------------"
    echo ""
    echo "To test (with c++23)"
    echo "    GTEST_COLOR=1 bazel test --config=cxx23 --test_output=all //test:point_test"
    echo ""
}

function create_project_cpp_bazel_single {
    echo "Creating C++ project for single target binary (Bazel)"

    local repository="$REPOSITORY_BAZEL"

    clone_templates_from_github $repository
    template_archive_name="template_bazel_cpp_single.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_bazel
    create_file_bazelrc

    print_usage_bazel_cpp_binary
}

function create_project_cpp_bazel_multi {
    echo "Creating C++ project for multiple target binary (Bazel)"

    local repository="$REPOSITORY_BAZEL"

    clone_templates_from_github $repository
    template_archive_name="template_bazel_cpp_multi.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_bazel
    create_file_bazelrc

    print_usage_bazel_cpp_binary
}

function create_project_cpp_bazel_generic {
    echo "Creating C++ project for multiple target, generic binary (Bazel)"

    local repository="$REPOSITORY_BAZEL"

    clone_templates_from_github $repository
    template_archive_name="template_bazel_cpp_generic.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_bazel
    create_file_bazelrc

    print_usage_bazel_cpp_binary
}

function create_project_cpp_bazel_lib {
    echo "Creating C++ project for library with unit tests (Bazel)"

    local repository="$REPOSITORY_BAZEL"

    clone_templates_from_github $repository
    template_archive_name="template_bazel_cpp_lib.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_bazel
    create_file_bazelrc

    print_usage_bazel_cpp_library
}

# ------------------------------------------------------------------------------
#  For CMake Templates
# ------------------------------------------------------------------------------
function print_usage_c {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to build & test the project"
    echo "--------------------------------------------------------------------------------"
    echo " - Specify the number of threads needed after -j option, e.g., 12"
    echo "   or, simple -j to use the maximum number of threads"
    echo ""
    echo "BUILD"
    echo "    cmake -S . -B build"
    echo "    cmake --build build -j"
    echo ""
    echo "compile_commands.json is generated automatically in the build directory."
    echo "Link it to the project root with:"
    echo "    ln -s ./build/compile_commands.json ./"
    echo ""
}

function print_usage_c_test {
    echo "RUN TESTS"
    echo "    GTEST_COLOR=1 ctest --test-dir build --output-on-failure -j"
    echo "or"
    echo "    ./build/test/$1_test"
    echo ""
}

function create_project_c_executable {
    echo "Creating C project using cmake"

    local repository="$REPOSITORY_CMAKE"

    clone_templates_from_github $repository
    template_archive_name="template_c_exe.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_cmake

    # Rename project
    local sed_formula="s/__PROJECT_NAME__/$PROJ_NAME/g"
    sed -i '' -e $sed_formula CMakeLists.txt

    print_usage_c
}

function create_project_c_library {
    echo "Creating C project for library (with unit testing)"

    local repository="$REPOSITORY_CMAKE"

    clone_templates_from_github $repository
    template_archive_name="template_c_lib.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_cmake

    # Rename project
    mv core $PROJ_NAME
    local sed_formula="s/__PROJECT_NAME__/$PROJ_NAME/g"
    sed -i '' -e $sed_formula CMakeLists.txt
    sed -i '' -e $sed_formula "$PROJ_NAME/CMakeLists.txt"
    sed -i '' -e $sed_formula "test/CMakeLists.txt"

    print_usage_c
    print_usage_c_test $PROJ_NAME
}

function print_usage_cpp {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to build & test the project"
    echo "--------------------------------------------------------------------------------"
    echo " - Specify the number of threads needed after -j option, e.g., 12"
    echo "   or, simple -j to use the maximum number of threads"
    echo ""
    echo "BUILD"
    echo "    cmake -S . -B build"
    echo "    cmake --build build -j"
    echo ""
    echo "compile_commands.json is generated automatically in the build directory."
    echo "Link it to the project root with:"
    echo "    ln -s ./build/compile_commands.json ./"
    echo ""
}

function print_usage_cpp_test {
    echo "RUN TESTS"
    echo "    GTEST_COLOR=1 ctest --test-dir build --output-on-failure -j"
    echo "or"
    echo "    ./build/$1_test"
    echo ""
}

function create_project_cpp_executable {
    echo "Creating C++ project using cmake"

    local USE_ABSEIL=false
    local USE_BOOST=false

    if ask_yes_no "Do you want to use Abseil library?"; then
        USE_ABSEIL=true
    fi

    if ask_yes_no "Do you want to use Boost library?"; then
        USE_BOOST=true
    fi

    local template_archive_name="template_cpp_exe.zip"

    if [ "$USE_ABSEIL" = "true" ] && [ "$USE_BOOST" = "false" ]; then
        template_archive_name="template_cpp_exe_abseil.zip"
    fi

    if [ "$USE_ABSEIL" = "false" ] && [ "$USE_BOOST" = "true" ]; then
        template_archive_name="template_cpp_exe_boost.zip"
    fi

    if [ "$USE_ABSEIL" = "true" ] && [ "$USE_BOOST" = "true" ]; then
        template_archive_name="template_cpp_exe_abseil_boost.zip"
    fi

    local repository="$REPOSITORY_CMAKE"

    clone_templates_from_github $repository

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_cmake

    # Rename project
    local sed_formula="s/__PROJECT_NAME__/$PROJ_NAME/g"
    sed -i '' -e $sed_formula CMakeLists.txt

    print_usage_cpp
}

function create_project_cpp_library {
    echo "Creating C++ project for library (with unit testing)"

    local repository="$REPOSITORY_CMAKE"

    clone_templates_from_github $repository
    template_archive_name="template_cpp_lib.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit
    create_file_gitignore_cmake

    # Rename project
    # mv core $PROJ_NAME
    local sed_formula="s/__PROJECT_NAME__/$PROJ_NAME/g"
    sed -i '' -e $sed_formula CMakeLists.txt
    sed -i '' -e $sed_formula "$PROJ_NAME/CMakeLists.txt"

    print_usage_cpp
    print_usage_cpp_test $PROJ_NAME
}

# ------------------------------------------------------------------------------
#   For Python
# ------------------------------------------------------------------------------
function print_python_project_skeleton_usage {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to test the project"
    echo "--------------------------------------------------------------------------------"
    echo " - The test should run in project root directory, e.g., ${PROJ_NAME}/${PROJ_NAME}"
    echo ""
    echo "To run tests"
    echo "    python3 -m tests.test_${PROJ_NAME}"
    echo ""
}

# ------------------------------------------------------------------------------
#   Templates
# ------------------------------------------------------------------------------
function create_python_project {
    echo "Creating Python project (Directory structure)"

    local repository="$HOME/Documents/3-resources/templates/misc"

    clone_templates_from_github $repository
    template_archive_name="template_python.zip"

    mkdir $PROJ_NAME && cd $PROJ_NAME && git init
    cp "$repository/$template_archive_name" ./
    unzip $template_archive_name
    rm $template_archive_name

    create_file_license_mit

    # Rename project & files
    mv core $PROJ_NAME
    mv "$PROJ_NAME/__PROJECT_NAME__.py" "$PROJ_NAME/$PROJ_NAME.py"
    mv "$PROJ_NAME/tests/test___PROJECT_NAME__.py" "$PROJ_NAME/tests/test_$PROJ_NAME.py"

    local sed_formula="s/__PROJECT_NAME__/$PROJ_NAME/g"
    sed -i '' -e $sed_formula setup.py
    sed -i '' -e $sed_formula "$PROJ_NAME/tests/test_$PROJ_NAME.py"

    print_python_project_skeleton_usage
}

function create_python_project_with_venv {
    echo "Creating Python project with a virtual environment"

    VENV_HOME="$HOME/.venv"

    VENV=$VENV_HOME/$PROJ_NAME/bin/activate
    if [ -f $VENV ]; then
        echo "[ERROR] Environment '$PROJ_NAME' already exists.  Switch to it with 'workon $PROJ_NAME'."
        exit 1
    else
        echo "Creating $PROJ_NAME at $VENV"
        python3 -m venv $VENV_HOME/$PROJ_NAME
        source $VENV
        [ -d $PROJ_NAME ] || mkdir $PROJ_NAME
        cd $PROJ_NAME
    fi
}
