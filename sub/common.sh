# ------------------------------------------------------------------------------
#  Utility Functions
# ------------------------------------------------------------------------------

# Is macOS?
function is_macos {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    fi
    return 1
}

# Is linux?
function is_linux {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        return 0
    fi
    return 1
}

# Is CMD available?
function is_cmd_available {
    if [[ $(which $1 | wc -l) -eq 0 ]]; then
        return 1
    fi
    return 0
}

# Create a symbolic link
function create_link {
    if [ -e $2 ]; then
        echo "Removing previous symbolic link $2"
        rm $2
    fi
    echo "Creating a new symbolic link $2"
    ln -s -f $1 $2
}

# Execute another script
function execute_script {
    if [ -e $1 ]; then
        $1
    else
        echo "[ERROR] script missing: $1"
    fi
}

# Print all elements of an array.
# General form:
#       print_array array1
# Example usage:
#       print_array "${array1[@]}"
function print_array {
    for element in "$@"; do
        printf "    %s\n" "$element"
    done
}

# Print all elements of an array.
# General form:
#       print_array_with_counter array1
# Example usage:
#       print_array_with_counter "${array1[@]}"
function print_array_with_counter {
    local i=0
    for element in "$@"; do
        printf "  $((i + 1)): %s\n" "$element"
        ((i++))
    done
}

# Print one prompt, an array of options, and one additional closing option,
# and get user input.
#
# General form (notice length MUST come before the array in order
# to be able to parse the args!):
#       choose_one_option_with_prompt array_len array final_option prompt
#
# Usage:
#       choose_one_option_with_prompt "${#array[@]}" "${array[@]}" "Choose one:" "Exit"
#
# Example:
# Commands=(
# 	"Setup a new debian/ubuntu"
# 	"Setup ubuntu desktop (minimal)"
# 	"Setup C++ Development Environment (GCC)"
# 	"Setup LLVM"
# 	"Setup RUST"
# 	"Setup node.js"
# 	"Install docker"
# )
#
# choose_one_option_with_prompt "${#Commands[@]}" "${Commands[@]}" "Choose one:" "Exit"
# choice=$?
# echo "$choice"
function choose_one_option_with_prompt {
    local i=1

    # Read array_len into a variable
    local array_len="${@:$i:1}"
    ((i++))
    # Read array into a new array
    local options=("${@:$i:$array_len}")
    ((i += $array_len))

    # Now read the extra arguments
    local prompt=("${@:$i:1}")
    ((i++))
    local final_option=("${@:$i:1}")

    # Print prompt
    printf "================================================================================\n"
    printf "$prompt\n"
    printf "================================================================================\n"

    # Print options with counter
    print_array_with_counter "${options[@]}"

    # Print one additional option
    printf "\n  0: $final_option\n"
    printf "================================================================================\n"

    # Get user input
    local user_choice
    read -rp '>>> ' user_choice
    return "$user_choice"
}

# Determine whether a package is installed or not (for Ubuntu)
function is_pkg_installed {
    if [ $(apt search $1 | grep -c '^$1.*\[installed\]') -eq 0 ]; then
        echo 'Package $1 installed'
        return false
    else
        return true
    fi
}

# Ask Y/N question with prompt
function ask_yes_no {
    local question="$1"
    local answer
    local valid_answer=false

    local bold=$(tput bold)
    local normal=$(tput sgr0)

    while ! "$valid_answer"; do
        read -p "$question (yes/no) [${bold}NO${normal}]: " answer
        case "$answer" in
        [yY][eE][sS] | [yY])
            return 0 # Return 0 for yes (success)
            valid_answer=true
            ;;
        [nN][oO] | [nN] | "")
            return 1 # Return 1 for no (failure)
            valid_answer=true
            ;;
        *)
            echo "Please answer 'yes' or 'no'."
            ;;
        esac
    done
}
