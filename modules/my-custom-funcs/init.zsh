#=============================================================================
# MY CUSTOM FUNCTIONS AND ALIASES
# Description: Personal zsh customizations for development workflow
# Author: MyriadColors
# Last Updated: 15/06/2025
#=============================================================================

# Help function to show available custom commands
function show_help() {
    echo "=== Custom Commands Help ==="
    echo ""
    echo "Navigation Aliases:"
    echo "  gocode          - Go to main coding directory"
    echo "  go<lang>        - Go to specific language directory (cpp, java, python, etc.)"
    echo "  dl/dt           - Go to Downloads/Desktop"
    echo "  home            - Go to home directory"
    echo ""
    echo "C/C++ Development:"
    echo "  create_cmake_project <name> [type] - Create CMake project (raylib, sdl2, boost, etc.)"
    echo "  cpp_init <name> [type]  - Alias for create_cmake_project"
    echo "  cpp_templates           - Show available project templates"
    echo "  cpp_deps               - Show common C++ dependencies"
    echo "  cbuild/cbuildr/cbuildd - Build project (release/debug)"
    echo "  cclean                 - Clean build directory"
    echo "  cbld/crun              - Compile and run C programs"
    echo "  cppb/cppr              - Compile and run C++ programs"
    echo "  conan_init/vcpkg_init  - Initialize package managers"
    echo ""
    echo "Development:"
    echo "  create_project  - Create new project with git init"
    echo "  init_c_project  - Create C project structure"
    echo ""
    echo "System:"
    echo "  yi/yr/yu        - Yay install/remove/update"
    echo "  c/cl/cls        - Clear terminal"
    echo "  refresh         - Reload zsh config"
    echo ""
    echo "For more details, see: ~/.zprezto/modules/my-custom-funcs/init.zsh"
}

#=============================================================================
# NAVIGATION ALIASES - Go to coding directories
#=============================================================================
alias gocode='cd $HOME/Desktop/Coding/ && ls'
alias gocpp='cd $HOME/Desktop/Coding/CPP/ && ls'
alias gojava='cd $HOME/Desktop/Coding/Java/ && ls'
alias gopython='cd $HOME/Desktop/Coding/Python/ && ls'
alias gotic80='cd $HOME/Desktop/Coding/tic80code/ && ls'
alias gocsharp='cd $HOME/Desktop/Coding/csharp/ && ls'
alias goclang='cd $HOME/Desktop/Coding/C/ && ls'
alias gorust='cd $HOME/Desktop/Coding/rust/ && ls'
alias gogolang='cd $HOME/Desktop/Coding/golang/ && ls'
alias gojavascript='cd $HOME/Desktop/Coding/javascript/ && ls'
alias gomojo='cd $HOME/Desktop/Coding/mojo/ && ls'
alias goodin='cd $HOME/Desktop/Coding/Odin/ && ls'
alias gozig='cd $HOME/Desktop/Coding/zig/ && ls'
alias gogolang='cd $HOME/Desktop/Coding/golang/ && ls'

#==============================================================================
# NAVIGATION ALIASES - Miscellaneous
#==============================================================================
alias fap='cd $HOME/Downloads/pron && ls'  # Go to porn directory

#=============================================================================
# TERMINAL & SYSTEM ALIASES
#=============================================================================
alias c='clear'                # Clear terminal
alias cl='clear'               # Clear terminal (alternative)
alias cls='clear'              # Clear terminal (Windows style)
alias clr='clear'              # Clear terminal (alternative)
alias q='exit'                 # Quick exit
alias qq='exit'                # Double-q for safety
alias ccat='pygmentize -g'     # Syntax highlighted cat
alias home='cd $HOME && ls'    # Go home and list
alias homedir='echo $HOME'     # Print home directory path
alias ..='cd ..'               # Go up one directory
alias ...='cd ../..'           # Go up two directories
alias ....='cd ../../..'       # Go up three directories
alias ll='ls -la'              # Long listing with hidden files
alias la='ls -la'              # Same as ll
alias lt='ls -ltr'             # List by time (newest last)
alias lh='ls -lah'             # Human readable sizes

# SillyTavern Commands
alias start-st="cd /home/pedrot/Downloads/pron/games/SillyTavern-Launcher/SillyTavern/ && git pull && sudo ./start.sh"
alias update-st="cd /home/pedrot/Downloads/pron/games/SillyTavern-Launcher/SillyTavern/ && git pull"
alias open-st="cd /home/pedrot/Downloads/pron/games/SillyTavern-Launcher/SillyTavern/"

#=============================================================================
# APPLICATION SHORTCUTS
#=============================================================================
# Game Shortcuts (safer approach - check if files exist)
function launch_game() {
    local game_file="$1"
    if [[ -f "$game_file" ]]; then
        "$game_file"
    else
        echo "Game file not found: $game_file"
        echo "Available games in Desktop:"
        ls ~/Desktop/*.{desktop,appimage} 2>/dev/null | head -10
    fi
}

alias bar='launch_game ~/Desktop/BAR.appimage'
alias bnet='launch_game ~/Desktop/BNET.desktop'
alias lastepoch='launch_game ~/Desktop/Last\ Epoch.desktop'
alias lethalcompany='launch_game ~/Desktop/LethalCompany.desktop'
alias citra='launch_game ~/Desktop/Citra.desktop'
alias millenia='launch_game ~/Desktop/Millenia.desktop'
alias fivenations='launch_game ~/Desktop/FiveNations.desktop'
alias lastepoch="cd ~/Desktop/Last Epoch.desktop"
alias lethalcompany="cd ~/Desktop/LethalCompany.desktop"
alias citra="cd ~/Desktop/Citra.desktop"
alias millenia="cd ~/Desktop/Millenia.desktop"
alias fivenations="cd ~/Desktop/FiveNations.desktop"

#=============================================================================
# PACKAGE MANAGEMENT (YAY/PACMAN)
#=============================================================================
alias yi='yay -S'                    # Install package
alias yr='yay -Rns'                  # Remove package (with dependencies)
alias yu='yay -Syyu'                 # Update system
alias sysu='eos-update --aur'        # EndeavourOS system upgrade
alias ycc='yay -Scc'                 # Clear package cache
alias ys='yay -Ss'                   # Search for package
alias yps='yay -Ps'                  # List installed packages
alias ysgames='ys game'              # Search for games
alias yspy='ys python'               # Search for Python packages

# Enhanced package management functions
function yinfo() {
    # Get detailed package information
    if [[ -z "$1" ]]; then
        echo "Usage: yinfo <package_name>"
        return 1
    fi
    yay -Si "$1" 2>/dev/null || yay -Qi "$1" 2>/dev/null || echo "Package '$1' not found"
}

function yco() {
    # Clean orphan packages with confirmation
    local orphans=$(pacman -Qdt -q)
    if [[ -n "$orphans" ]]; then
        echo "Orphan packages found:"
        echo "$orphans"
        read -q "?Remove these orphan packages? [y/N] " && echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo pacman --noconfirm -R $orphans
        fi
    else
        echo "No orphan packages found."
    fi
}

#=============================================================================
# ZSH CONFIGURATION
#=============================================================================
alias refresh="source ~/.zprezto/runcoms/zshrc && echo 'Zsh configuration reloaded!'"
alias my_configs="$DEFAULTEDITOR /home/pedrot/.zprezto/modules/my-custom-funcs/init.zsh"
alias edit_zsh="$DEFAULTEDITOR ~/.zprezto/runcoms/zshrc"
alias edit_aliases="$DEFAULTEDITOR /home/pedrot/.zprezto/modules/my-custom-funcs/init.zsh"

# Quick config editing function
function edit_configs() {
    # Edit all zsh config files in one go
    echo "Opening zsh configuration files..."
    $DEFAULTEDITOR ~/.zprezto/runcoms/zshrc \
    ~/.zprezto/runcoms/zpreztorc \
    ~/.zprezto/modules/my-custom-funcs/init.zsh
}

#=============================================================================
# ENVIRONMENT VARIABLES
#=============================================================================
# Media directories
export YTDIR="$HOME/Youtube"
export YTVDIR="$YTDIR/Video"
export YTADIR="$YTDIR/Audio"

# Development directories
export WEBSITEDIR="$HOME/Websites"
export PYSCRIPTDIR="$HOME/pybashscript"
export BASHSCRIPTS="$HOME/bash_scripts"
export PYBASHSCRIPTS="$HOME/pybashscript/"

# Coding directories
export CODING="$HOME/Desktop/Coding"
export CPP="$CODING/CPP"
export PHP="$CODING/php"           # Fixed typo
export JAVA="$CODING/Java"
export PYTHON="$CODING/Python"
export TIC80="$CODING/tic80code"
export CSHARP="$CODING/csharp"     # Fixed typo
export CLANG="$CODING/C"
export RUST="$CODING/rust"
export GOLANG="$CODING/golang"
export JAVASCRIPT="$CODING/javascript"
export MOJO="$CODING/mojo"
export ODIN="$CODING/Odin"
export ZIG="$CODING/zig"

# System directories
export DESKTOP="$HOME/Desktop/"
export DEFAULTEDITOR="codium"

# Legacy config files (for compatibility)
export ZSHCONFIG="~/.zshrc"
export ZSHALIASES="~/.aliases"
export ZSHFUNCS="~/.zshfuncs"

# Development toolchain paths
export PATH=$PATH:/home/pedrot/CEdev/bin/       # CE Toolchain
export PATH=$PATH:/home/pedrot/AgDev/bin/       # Agon Light Dev

# SillyTavern environment (if ST directory exists)
[[ -d "/home/pedrot/Downloads/pron/games/SillyTavern-Launcher/SillyTavern" ]] && \
export ST="/home/pedrot/Downloads/pron/games/SillyTavern-Launcher/SillyTavern"

#=============================================================================
# DEVELOPMENT ALIASES - C/C++ Compilation
#=============================================================================
# C compilation commands
alias cbld="clang main.c -o main -Wextra -Wall"                              # Build main.c
alias crun="clang main.c -o main -Wextra -Wall && ./main"                    # Build and run main.c
alias cdbg="clang main.c -DMEMORY_SAFETY_MODE=1 -o main -Wextra -Wall -g"    # Build with debug info
alias cdbgno="clang main.c -DMEMORY_SAFETY_MODE=0 -o main -Wextra -Wall"     # Build without debug
alias cdbgrun="clang main.c -DMEMORY_SAFETY_MODE=1 -o main -Wextra -Wall -g && ./main"
alias cdbgnorun="clang main.c -DMEMORY_SAFETY_MODE=0 -o main -Wextra -Wall && ./main"

# C++ compilation commands
alias cppb='clang++ *.cpp -o main -std=c++17 -Wall -Wextra'                  # Build all .cpp files
alias cppr='clang++ *.cpp -o main -std=c++17 -Wall -Wextra && ./main'        # Build and run all .cpp files
alias cppro='clang++ main.cpp -o main -std=c++17 -Wall -Wextra && ./main'    # Build and run main.cpp only

# Raylib compilation (for game development)
alias craylibflags='echo "-lraylib -lm"'  # Show raylib flags
alias craylib='clang main.c -o game -lraylib -lm -Wextra -Wall && ./game'    # C with raylib
alias cppraylib='clang++ *.cpp -o game -lraylib -lm -std=c++17 -Wall -Wextra && ./game'  # C++ with raylib

# Enhanced compilation function
function compile() {
    local lang="$1"
    local file="$2"
    local output="${3:-main}"

    case "$lang" in
        c)
            clang "$file" -o "$output" -Wextra -Wall && ./"$output"
        ;;
        cpp|c++)
            clang++ "$file" -o "$output" -std=c++17 -Wall -Wextra && ./"$output"
        ;;
        *)
            echo "Usage: compile <c|cpp> <source_file> [output_name]"
            return 1
        ;;
    esac
}

#=============================================================================
# VCPKG PACKAGE MANAGER (C++ Libraries)
#=============================================================================
alias vcpki='vcpkg install'                # Install C++ package
alias vcpks='vcpkg search'                 # Search C++ packages
alias vcpkg_upd='cd /home/pedrot/vcpkg && git pull'  # Update vcpkg repository
alias vcpkg_update='vcpkg update'          # Update installed packages

# Function to check if vcpkg is installed
function vcpkg_check() {
    if ! command -v vcpkg &> /dev/null; then
        echo "VCPKG is not installed or not in PATH"
        echo "Visit: https://github.com/Microsoft/vcpkg"
        return 1
    fi
    vcpkg version
}

#=============================================================================
# CUSTOM DEVELOPMENT FUNCTIONS
#=============================================================================

function init_c_project() {
    # Description: Initialize a C project with basic files and git
    local project_name="$1"

    if [[ -z "$project_name" ]]; then
        echo "Usage: init_c_project <project_name>"
        return 1
    fi

    local project_path="$CODING/C/$project_name"
    mkcd "$project_path"

    # Create basic C project structure
    cat > main.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("Hello, World!\n");
    return 0;
}
EOF

    cat > README.md << EOF
# $project_name

A C project created with init_c_project.

## Build

\`\`\`bash
clang main.c -o main -Wextra -Wall
\`\`\`

## Run

\`\`\`bash
./main
\`\`\`
EOF

    cat > .gitignore << 'EOF'
# Compiled binaries
main
*.o
*.exe
*.out

# Debug files
*.dSYM/
*.su
EOF

    # Initialize git repository
    git init
    git add .
    git commit -m "Initial commit: C project setup"

    echo "C project '$project_name' created at: $project_path"
    $DEFAULTEDITOR .
}

#=============================================================================
# PYTHON PACKAGE MANAGEMENT via YAY
#=============================================================================
function pipi() {
    # Description: Install Python packages via yay (system packages)
    if [[ $# -eq 0 ]]; then
        echo "Usage: pipi <package1> [package2] [...]"
        echo "Example: pipi requests numpy"
        return 1
    fi

    local pkgs=""
    for pkg_name in "$@"; do
        pkgs="$pkgs python-$pkg_name"
    done

    echo "Installing Python packages: $pkgs"
    yi $pkgs
}

function pips() {
    # Description: Search for Python packages via yay
    if [[ $# -eq 0 ]]; then
        echo "Usage: pips <search_term>"
        echo "Example: pips numpy"
        return 1
    fi

    local search_terms="$*"
    echo "Searching for Python packages matching: $search_terms"
    ys "python.*$search_terms"
}

function pipr() {
    # Description: Remove Python packages via yay
    if [[ $# -eq 0 ]]; then
        echo "Usage: pipr <package1> [package2] [...]"
        echo "Example: pipr requests numpy"
        return 1
    fi

    local pkgs=""
    for pkg_name in "$@"; do
        pkgs="$pkgs python-$pkg_name"
    done

    echo "Removing Python packages: $pkgs"
    yr $pkgs
}

# Alternative: use pip for user packages
function pipuser() {
    # Description: Install Python packages via pip (user-level)
    if [[ $# -eq 0 ]]; then
        echo "Usage: pipuser <package1> [package2] [...]"
        return 1
    fi

    python -m pip install --user "$@"
}

#=============================================================================
# MEDIA AND DOWNLOAD FUNCTIONS
#=============================================================================

function pydlyt() {
    # Description: Download YouTube video/audio using Python script
    local media_type="$1"
    local url="$2"
    local target_dir="$3"
    local index="$4"
    local action="$5"

    # Validate inputs
    if [[ -z "$media_type" || -z "$url" ]]; then
        echo "Usage: pydlyt <video|audio> <youtube_url> [target_dir] [index] [goto|play]"
        echo "Example: pydlyt video 'https://youtube.com/watch?v=...' myplaylist"
        return 1
    fi

    if [[ "$media_type" != "video" && "$media_type" != "audio" ]]; then
        echo "Error: media_type must be 'video' or 'audio'"
        return 1
    fi

    # Check if Python script exists
    if [[ ! -f "$PYSCRIPTDIR/pydlyt.py" ]]; then
        echo "Error: Python script not found at $PYSCRIPTDIR/pydlyt.py"
        return 1
    fi

    # Create target directories if they don't exist
    [[ "$media_type" == "video" ]] && mkdir -p "$YTVDIR/${target_dir:-default}"
    [[ "$media_type" == "audio" ]] && mkdir -p "$YTADIR/${target_dir:-default}"

    # Run the download
    echo "Downloading $media_type from: $url"
    python "$PYSCRIPTDIR/pydlyt.py" "$media_type" "$url" --target_dir "$target_dir" --index "$index"

    # Handle post-download actions
    if [[ -n "$action" ]]; then
        case "$action" in
            goto)
                if [[ "$media_type" == "video" ]]; then
                    cd "$YTVDIR/$target_dir" && ls
                    elif [[ "$media_type" == "audio" ]]; then
                    cd "$YTADIR/$target_dir" && ls
                fi
            ;;
            play)
                if [[ "$media_type" == "video" ]]; then
                    vlc "$YTVDIR/$target_dir"/* 2>/dev/null &
                    elif [[ "$media_type" == "audio" ]]; then
                    vlc "$YTADIR/$target_dir"/* 2>/dev/null &
                fi
            ;;
            *)
                echo "Unknown action: $action. Available actions: goto, play"
            ;;
        esac
    fi
}

function watch() {
    # Description: Watch streams using streamlink with enhanced options
    emulate -L zsh
    local quality="best"
    local player="vlc"

    # Show usage if no arguments
    if [[ $# -eq 0 ]]; then
        echo "Usage: watch [-q quality] [-p player] <stream_url>"
        echo "  -q quality: video quality (best, worst, 720p, 480p, etc.)"
        echo "  -p player:  media player (vlc, mpv, etc.)"
        echo "Example: watch -q 720p -p mpv https://twitch.tv/streamer"
        return 1
    fi

    # Parse arguments using getopts
    while getopts ":q:p:h" opt; do
        case $opt in
            q) quality="$OPTARG" ;;
            p) player="$OPTARG" ;;
            h)
                echo "Usage: watch [-q quality] [-p player] <stream_url>"
                return 0
            ;;
            \?) echo "Invalid option: -$OPTARG" >&2; return 1 ;;
        esac
    done

    # Shift arguments to skip processed options
    shift $((OPTIND-1))

    # Ensure a stream URL is provided
    if [[ -z "$1" ]]; then
        echo "Error: Please provide a stream URL." >&2
        return 1
    fi

    # Check if streamlink is installed
    if ! command -v streamlink &> /dev/null; then
        echo "Error: streamlink is not installed."
        echo "Install with: yay -S streamlink"
        return 1
    fi

    echo "Starting stream with quality: $quality, player: $player"
    streamlink --player="$player" "$1" "$quality"
}

function dlweb() {
    # Description: Download website recursively with safety checks
    local url="$1"
    local dest_dir="$2"

    # Validate inputs
    if [[ -z "$url" || -z "$dest_dir" ]]; then
        echo "Usage: dlweb <url> <destination_directory>"
        echo "Example: dlweb https://example.com example-site"
        echo "Files will be saved to: $WEBSITEDIR/<destination_directory>"
        return 1
    fi

    # Ensure WEBSITEDIR exists
    mkdir -p "$WEBSITEDIR"

    # Sanitize destination directory name
    dest_dir=$(echo "$dest_dir" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._-]/_/g')
    local full_path="$WEBSITEDIR/$dest_dir"

    echo "Website: $url"
    echo "Destination: $full_path"
    echo "This will download the entire website recursively."

    read -q "?Continue with download? [y/N] " && echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Download cancelled."
        return 1
    fi

    mkdir -p "$full_path"

    # Enhanced wget command with better options
    wget --recursive \
    --level=inf \
    --convert-links \
    --page-requisites \
    --html-extension \
    --domains=$(echo "$url" | sed 's|https\?://||' | cut -d'/' -f1) \
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" \
    --wait=1 \
    --random-wait \
    --limit-rate=200K \
    --directory-prefix="$full_path" \
    --no-clobber \
    "$url"

    echo "Download completed. Files saved to: $full_path"
    ls -la "$full_path"
}

#=============================================================================
# UTILITY FUNCTIONS
#=============================================================================
function openConfig() {
    # Open configuration files (deprecated - use edit_configs instead)
    echo "Note: This function is deprecated. Use 'edit_configs' instead."
    edit_configs
}

function srcConfig() {
    # Reload configuration files (deprecated - use 'refresh' instead)
    echo "Note: This function is deprecated. Use 'refresh' instead."
    refresh
}

# Enhanced confirmation function
function confirm() {
    local prompt="${1:-Are you sure?}"
    local default="${2:-N}"

    if [[ "$default" == "Y" || "$default" == "y" ]]; then
        read -r -p "$prompt [Y/n] " response
        case "$response" in
            [nN][oO]|[nN]) return 1 ;;
            *) return 0 ;;
        esac
    else
        read -r -p "$prompt [y/N] " response
        case "$response" in
            [yY][eE][sS]|[yY]) return 0 ;;
            *) return 1 ;;
        esac
    fi
}


function addAlias() {
    if [[ -z $1 || -z $2 || $# -gt 2 ]]; then
        echo usage:
        echo "\t\$$0 ll 'ls -l'"
    else
        echo "alias $1='$2'" >> ~/.aliases
        echo "alias ADDED to ~/.aliases"
    fi
}

function rng() {
    local min=$1
    local max=$2
    local howMany=$3

    for i in $(seq 1 $howMany); do
        sleep 1
        echo "Num $i: $(generate_rng $min $max)"
    done
}

function generate_rng() {
    local min=$1
    local max=$2
    local num=$(shuf -i $min-$max -n 1)
    echo $num
}

# Command not found handler is used to display a message when a command is not found in the repository
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=(
        ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
    )
    if (( ${#entries[@]} ))
    then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}"
        do
            # (repo package version file)
            local fields=(
                ${(0)entry}
            )
            if [[ "$pkg" != "${fields[2]}" ]]
            then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}


# This function will move all files in the current directory to another directory
mvfiles() {
    if [ "$1" = "." ]; then
        confirm && mv * "$2"
    else
        confirm && mv "$1" "$2" && cd "$2"
    fi
}

kp() {
    ps aux | grep $1 >/dev/null
    mypid=$(pidof $1)
    if [ "$mypid" != "" ]; then
        kill -9 $(pidof $1)
        if [[ "$?" == "0" ]]; then
            echo "PID $mypid ($1) killed."
        fi
    else
        echo "None killed."
    fi
    return
}

extract() {
    read -p "Enter the file to extract: " file
    read -p "Enter the destination directory (leave blank for current directory): " destDir
    confirm && eval 7za -x "$file" -C "$destDir"
}

compressDir() {
    confirm && eval 7z a -t7z -mhe=on -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on {$1}.7z /{$1}/
}

compressFile() {
    confirm && eval 7z a -t7z -mhe=on -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on {$1}.7z $1
}


dlWebsite() {
    if [ "$2" == "" ]; then
        confirm && eval wget --random-wait -r -p -e robots=off -U mozilla $1
    fi
    confirm && eval wget --random-wait -r --level="$2" -p -e robots=off -U mozilla $1
}

play_media() {
    local media_type="$1"
    local filepath="$2"

    if [ "$media_type" = "audio" ]; then
        vlc $filepath.mp3
    else
        vlc $filepath.*
    fi
}

dh() {
    du -ch --max-depth=1 "${@-.}"|sort -h
}

function backup_git() {
    # Description: Backs up all public repositories from a GitHub account with commit history.

    # Error handling: Ensure an account name is provided
    if [[ -z "$1" ]]; then
        echo "Error: Please provide a GitHub account name as an argument."
        echo "Usage: $0 <account_name>"
        return 1
    fi

    # Account name validation (optional): Consider adding checks for valid username patterns
    account_name="$1"

    # Clone repositories with submodules and full history
    while read -r url; do
        echo " "
        repo_name=${url##*/}  # Extract repository name from URL
        echo "Backing up repository: $repo_name (URL: $url)"
        git clone --recurse-submodules --progress "$url"
        echo " "
    done < <(curl "https://api.github.com/users/$account_name/repos?per_page=100" | jq -r '.[].clone_url')

    echo "Backup completed for repositories from user: $account_name"
}

function edit_configs() {
    # Description: all of the zsh config files

    $EDITOR ~/.zshrc
    $EDITOR ~/.zshvars
    $EDITOR ~/.zshfuncs
    $EDITOR ~/.aliases
}

function srczsh() {
    source $HOME/.zpreztorc && echo "Sourced .zpreztorc file"
}

function push_to_github() {
    # Loop through each directory in the current directory
    for dir in ./*; do
        # Check if it's a directory and has a .git folder (Git repository)
        if [ -d "$dir" ] && [ -d "$dir/.git" ]; then
            cd "$dir"  # Change directory to the repository

            # Get the remote name based on the directory name
            remote_name=$(basename "$dir")

            # Add remote using the directory name
            git remote add -f "$remote_name" origin  # Force update origin if it exists

            # Push to the remote with the same name (replace master with your branch name if needed)
            git push -u "$remote_name" "${2:-master}"  # Use second argument as branch name, or default to master

            cd ..  # Move back to the previous directory
        fi
    done
}

function create_project() {
    # Get arguments
    local project_name="$1"
    local language="$2"
    local extension="$3"

    # Validate arguments
    if [[ -z "$project_name" || -z "$language" || -z "$extension" ]]; then
        echo "Usage: create_project <project_name> <language> <extension>"
        return 1
    fi

    # Build directory path
    local project_dir="/home/pedrot/Desktop/Coding/$language/$project_name"

    # Create directory structure
    mkdir -p "$project_dir" || { echo "Error creating directory: $project_dir"; return 1; }

    # Create main file with extension
    touch "$project_dir/main.$extension"

    # Initialize git repository
    git init -b main "$project_dir" || { echo "Error initializing git repository"; return 1; }

    echo "Project '$project_name' created in $project_dir"
}

confirm_v2() {
    echo "$1? (y/n)"
    read overwrite
    [[ "$overwrite" != "y" && "$overwrite" != "Y" ]]
}

function merge() {
    # Description: Use Python script to merge files
    local script_path="/home/pedrot/.zprezto/modules/my-custom-funcs/merge.py"

    if [[ ! -f "$script_path" ]]; then
        echo "Error: Python script not found at '$script_path'. Please check the path."
        return 1
    fi

    python3 "$script_path" "$@"
}

function create_project() {
    # Description: Create a new project using Python script
    local script_path="/home/pedrot/.zprezto/modules/my-custom-funcs/create_project.py"

    if [[ $# -lt 2 ]]; then
        echo "Usage: create_project <project_name> <language>"
        echo "Example: create_project myapp python"
        return 1
    fi

    if [[ -f "$script_path" ]]; then
        python3 "$script_path" "$1" "$2"
    else
        echo "Python script not found. Using fallback..."
        # Fallback to built-in project creation
        local project_name="$1"
        local language="$2"

        case "$language" in
            c)
                init_c_project "$project_name"
            ;;
            python)
                mkcd "$PYTHON/$project_name"
                touch main.py README.md requirements.txt
                git init && git add . && git commit -m "Initial commit"
                $DEFAULTEDITOR .
            ;;
            *)
                echo "Unsupported language: $language"
                echo "Supported: c, python"
                return 1
            ;;
        esac
    fi
}

function list_pacman_packages() {
    # Description: List installed packages with sorting options
    local sort_by="${1:-name}"  # Default to sorting by name
    local order="${2:-asc}"     # Default to ascending order

    if [[ "$sort_by" != "name" && "$sort_by" != "size" ]]; then
        echo "Usage: list_pacman_packages [name|size] [asc|desc]"
        echo "Invalid sort option. Use 'name' or 'size'."
        return 1
    fi

    if [[ "$order" != "asc" && "$order" != "desc" ]]; then
        echo "Usage: list_pacman_packages [name|size] [asc|desc]"
        echo "Invalid order option. Use 'asc' or 'desc'."
        return 1
    fi

    echo "Listing packages sorted by $sort_by ($order)..."

    case "$sort_by" in
        name)
            if [[ "$order" == "desc" ]]; then
                pacman -Q | sort -r
            else
                pacman -Q | sort
            fi
        ;;
        size)
            if [[ "$order" == "desc" ]]; then
                pacman -Qi | awk '/^Name/{name=$3}/^Installed Size/{size=$4" "$5; print size, name}' | sort -hr
            else
                pacman -Qi | awk '/^Name/{name=$3}/^Installed Size/{size=$4" "$5; print size, name}' | sort -h
            fi
        ;;
    esac
}

function pdf2txt() {
    # Description: Convert PDF to text using Python script
    local script_path="/home/pedrot/.zprezto/modules/my-custom-funcs/pdf-to-txt.py"

    if [[ $# -eq 0 ]]; then
        echo "Usage: pdf2txt <input.pdf> [output.txt]"
        return 1
    fi

    if [[ ! -f "$script_path" ]]; then
        echo "Error: Python script not found at '$script_path'"
        return 1
    fi

    python3 "$script_path" "$@"
}

#=============================================================================
# ADVANCED C/C++ DEVELOPMENT FUNCTIONS
#=============================================================================

# CMake Project Generators
function create_cmake_project() {
    local project_name="$1"
    local project_type="${2:-basic}"

    if [[ -z "$project_name" ]]; then
        echo "Usage: create_cmake_project <project_name> [type]"
        echo "Types: basic, raylib, sdl2, boost, opengl, opencv, qt, header-only"
        return 1
    fi

    local project_path="$CPP/$project_name"
    mkcd "$project_path"

    # Create directory structure
    mkdir -p src include tests docs build

    case "$project_type" in
        "basic")
            _create_basic_cmake "$project_name"
        ;;
        "raylib")
            _create_raylib_cmake "$project_name"
        ;;
        "sdl2")
            _create_sdl2_cmake "$project_name"
        ;;
        "boost")
            _create_boost_cmake "$project_name"
        ;;
        "opengl")
            _create_opengl_cmake "$project_name"
        ;;
        "opencv")
            _create_opencv_cmake "$project_name"
        ;;
        "qt")
            _create_qt_cmake "$project_name"
        ;;
        "header-only")
            _create_header_only_cmake "$project_name"
        ;;
        *)
            echo "Unknown project type: $project_type"
            echo "Available types: basic, raylib, sdl2, boost, opengl, opencv, qt, header-only"
            return 1
        ;;
    esac

    # Create common files
    _create_common_files "$project_name"

    # Initialize git
    git init
    git add .
    git commit -m "Initial commit: CMake $project_type project setup"

    echo "CMake project '$project_name' ($project_type) created at: $project_path"
    $DEFAULTEDITOR .
}

# Basic CMake project
function _create_basic_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Compiler-specific options
if(MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Debug/Release configurations
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")
file(GLOB_RECURSE HEADERS "include/*.h" "include/*.hpp")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES} \${HEADERS})

# Link directories and libraries (if needed)
# target_link_directories(\${PROJECT_NAME} PRIVATE lib)
# target_link_libraries(\${PROJECT_NAME} PRIVATE somelib)
EOF

    cat > src/main.cpp << EOF
#include <iostream>

int main() {
    std::cout << "Hello from $project_name!" << std::endl;
    return 0;
}
EOF
}

# Raylib CMake project
function _create_raylib_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find raylib
find_package(raylib QUIET)
if (NOT raylib_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        raylib
        GIT_REPOSITORY https://github.com/raysan5/raylib.git
        GIT_TAG 5.0
    )
    FetchContent_MakeAvailable(raylib)
endif()

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES})

# Link raylib
target_link_libraries(\${PROJECT_NAME} raylib)

# Platform-specific settings
if(APPLE)
    target_link_libraries(\${PROJECT_NAME} "-framework IOKit" "-framework Cocoa" "-framework OpenGL")
endif()

# Copy assets to build directory
file(COPY assets DESTINATION \${CMAKE_BINARY_DIR})
EOF

    mkdir -p assets
    cat > src/main.cpp << EOF
#include <raylib.h>

int main() {
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "$project_name");
    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawText("Hello Raylib World!", 190, 200, 20, LIGHTGRAY);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}
EOF
}

# SDL2 CMake project
function _create_sdl2_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find SDL2
find_package(PkgConfig REQUIRED)
pkg_check_modules(SDL2 REQUIRED sdl2)
pkg_check_modules(SDL2_IMAGE REQUIRED SDL2_image)

# Include directories
include_directories(include \${SDL2_INCLUDE_DIRS} \${SDL2_IMAGE_INCLUDE_DIRS})

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES})

# Link SDL2
target_link_libraries(\${PROJECT_NAME} \${SDL2_LIBRARIES} \${SDL2_IMAGE_LIBRARIES})
target_compile_options(\${PROJECT_NAME} PRIVATE \${SDL2_CFLAGS_OTHER} \${SDL2_IMAGE_CFLAGS_OTHER})
EOF

    cat > src/main.cpp << EOF
#include <SDL2/SDL.h>
#include <iostream>

int main(int argc, char* argv[]) {
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        std::cerr << "SDL could not initialize! SDL_Error: " << SDL_GetError() << std::endl;
        return 1;
    }

    SDL_Window* window = SDL_CreateWindow("$project_name",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 800, 600, SDL_WINDOW_SHOWN);

    if (!window) {
        std::cerr << "Window could not be created! SDL_Error: " << SDL_GetError() << std::endl;
        SDL_Quit();
        return 1;
    }

    SDL_Surface* screenSurface = SDL_GetWindowSurface(window);
    SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0x00, 0xFF, 0x00));
    SDL_UpdateWindowSurface(window);

    SDL_Event e;
    bool quit = false;
    while (!quit) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                quit = true;
            }
        }
    }

    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
EOF
}

# Boost CMake project
function _create_boost_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Boost
find_package(Boost REQUIRED COMPONENTS system filesystem thread program_options)

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES})

# Link Boost
target_link_libraries(\${PROJECT_NAME}
    Boost::system
    Boost::filesystem
    Boost::thread
    Boost::program_options
)

# Include Boost headers
target_include_directories(\${PROJECT_NAME} PRIVATE \${Boost_INCLUDE_DIRS})
EOF

    cat > src/main.cpp << EOF
#include <boost/filesystem.hpp>
#include <boost/program_options.hpp>
#include <iostream>

namespace fs = boost::filesystem;
namespace po = boost::program_options;

int main(int argc, char* argv[]) {
    try {
        po::options_description desc("Allowed options");
        desc.add_options()
            ("help,h", "produce help message")
            ("version,v", "show version");

        po::variables_map vm;
        po::store(po::parse_command_line(argc, argv, desc), vm);
        po::notify(vm);

        if (vm.count("help")) {
            std::cout << desc << std::endl;
            return 0;
        }

        if (vm.count("version")) {
            std::cout << "$project_name version 1.0.0" << std::endl;
            return 0;
        }

        std::cout << "Current path: " << fs::current_path() << std::endl;

    } catch (std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
EOF
}

# OpenGL CMake project
function _create_opengl_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(OpenGL REQUIRED)
find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES})

# Link libraries
target_link_libraries(\${PROJECT_NAME}
    OpenGL::GL
    glfw
    GLEW::GLEW
)
EOF

    cat > src/main.cpp << EOF
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>

void error_callback(int error, const char* description) {
    std::cerr << "Error: " << description << std::endl;
}

int main() {
    glfwSetErrorCallback(error_callback);

    if (!glfwInit()) {
        return -1;
    }

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    GLFWwindow* window = glfwCreateWindow(800, 600, "$project_name", NULL, NULL);
    if (!window) {
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);

    if (glewInit() != GLEW_OK) {
        std::cerr << "Failed to initialize GLEW" << std::endl;
        return -1;
    }

    while (!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        // Render here

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}
EOF
}

# OpenCV CMake project
function _create_opencv_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find OpenCV
find_package(OpenCV REQUIRED)

# Include directories
include_directories(include \${OpenCV_INCLUDE_DIRS})

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES})

# Link OpenCV
target_link_libraries(\${PROJECT_NAME} \${OpenCV_LIBS})
EOF

    cat > src/main.cpp << EOF
#include <opencv2/opencv.hpp>
#include <iostream>

int main() {
    cv::Mat image = cv::Mat::zeros(300, 300, CV_8UC3);

    cv::putText(image, "$project_name", cv::Point(30, 150),
                cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 255, 0), 2);

    cv::imshow("$project_name", image);
    cv::waitKey(0);
    cv::destroyAllWindows();

    return 0;
}
EOF
}

# Qt CMake project
function _create_qt_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Qt
find_package(Qt6 REQUIRED COMPONENTS Core Widgets)

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")
file(GLOB_RECURSE HEADERS "include/*.h" "include/*.hpp")

# Create executable
add_executable(\${PROJECT_NAME} \${SOURCES} \${HEADERS})

# Link Qt
target_link_libraries(\${PROJECT_NAME} Qt6::Core Qt6::Widgets)

# Qt specific settings
set_target_properties(\${PROJECT_NAME} PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
EOF

    cat > src/main.cpp << EOF
#include <QApplication>
#include <QWidget>
#include <QVBoxLayout>
#include <QLabel>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    QWidget window;
    window.setWindowTitle("$project_name");
    window.resize(400, 300);

    QVBoxLayout *layout = new QVBoxLayout();
    QLabel *label = new QLabel("Hello from $project_name!");
    layout->addWidget(label);
    window.setLayout(layout);

    window.show();

    return app.exec();
}
EOF
}

# Header-only library CMake project
function _create_header_only_cmake() {
    local project_name="$1"

    cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($project_name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Header-only library
add_library(\${PROJECT_NAME} INTERFACE)

# Include directories
target_include_directories(\${PROJECT_NAME} INTERFACE
    \$<BUILD_INTERFACE:\${CMAKE_CURRENT_SOURCE_DIR}/include>
    \$<INSTALL_INTERFACE:include>
)

# Example executable
add_executable(example examples/example.cpp)
target_link_libraries(example \${PROJECT_NAME})

# Install rules
install(TARGETS \${PROJECT_NAME}
    EXPORT \${PROJECT_NAME}Targets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(DIRECTORY include/ DESTINATION include)

install(EXPORT \${PROJECT_NAME}Targets
    FILE \${PROJECT_NAME}Targets.cmake
    NAMESPACE \${PROJECT_NAME}::
    DESTINATION lib/cmake/\${PROJECT_NAME}
)
EOF

    mkdir -p examples
    cat > include/${project_name}.hpp << EOF
#pragma once

#include <iostream>

namespace ${project_name} {
    template<typename T>
    void print(const T& value) {
        std::cout << value << std::endl;
    }
}
EOF

    cat > examples/example.cpp << EOF
#include "${project_name}.hpp"

int main() {
    ${project_name}::print("Hello from $project_name header-only library!");
    return 0;
}
EOF
}

# Create common files for all project types
function _create_common_files() {
    local project_name="$1"

    cat > README.md << EOF
# $project_name

Brief description of your project.

## Build

\`\`\`bash
mkdir build && cd build
cmake ..
make
\`\`\`

## Run

\`\`\`bash
./\$project_name
\`\`\`

## Development

- C++ Standard: C++17
- Build System: CMake 3.16+
- Cross-platform compatible

## Dependencies

List your dependencies here.
EOF

    cat > .gitignore << 'EOF'
# Build directories
build/
cmake-build-*/

# Compiled Object files
*.o
*.obj

# Executables
*.exe
*.out
*.app

# Debug files
*.dSYM/

# IDE files
.vscode/
.idea/
*.user
*.vcxproj.user

# CMake
CMakeCache.txt
CMakeFiles/
cmake_install.cmake
Makefile

# System files
.DS_Store
Thumbs.db
EOF

    # Create basic build script
    cat > build.sh << 'EOF'
#!/bin/bash
set -e

BUILD_TYPE=${1:-Debug}
BUILD_DIR="build"

echo "Building in $BUILD_TYPE mode..."

if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi

cd "$BUILD_DIR"
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE ..
make -j$(nproc)

echo "Build complete!"
EOF

    chmod +x build.sh
}

# CMake build shortcuts
alias cbuild='mkdir -p build && cd build && cmake .. && make -j$(nproc)'
alias cbuildr='mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j$(nproc)'
alias cbuildd='mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug .. && make -j$(nproc)'
alias cclean='rm -rf build && echo "Build directory cleaned"'
alias crun_cmake='cbuild && ./$(basename $PWD)'

# C++ project utilities
function cpp_init() {
    local name="${1:-my_project}"
    local type="${2:-basic}"
    create_cmake_project "$name" "$type"
}

function cpp_deps() {
    echo "Common C++ development packages:"
    echo "Basic tools: build-essential cmake ninja-build"
    echo "Libraries:"
    echo "  - Graphics: libsdl2-dev libraylib-dev libglfw3-dev libglew-dev"
    echo "  - Boost: libboost-all-dev"
    echo "  - OpenCV: libopencv-dev"
    echo "  - Qt: qt6-base-dev qt6-tools-dev"
    echo "  - Audio: libopenal-dev libsndfile1-dev"
    echo ""
    echo "Install with: sudo apt install <package-names>"
    echo "Or with yay: yay -S <arch-package-names>"
}

function cpp_templates() {
    echo "Available CMake project templates:"
    echo "  basic       - Simple C++ executable"
    echo "  raylib      - Game development with Raylib"
    echo "  sdl2        - Graphics/games with SDL2"
    echo "  boost       - Using Boost libraries"
    echo "  opengl      - OpenGL graphics programming"
    echo "  opencv      - Computer vision with OpenCV"
    echo "  qt          - GUI applications with Qt"
    echo "  header-only - Header-only library template"
    echo ""
    echo "Usage: create_cmake_project <name> <template>"
}

# Cross-compilation helpers
function cross_compile_help() {
    echo "Cross-compilation toolchains:"
    echo ""
    echo "Windows (from Linux):"
    echo "  sudo apt install mingw-w64"
    echo "  cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/mingw.cmake .."
    echo ""
    echo "ARM (Raspberry Pi):"
    echo "  sudo apt install gcc-arm-linux-gnueabihf"
    echo "  cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/arm.cmake .."
    echo ""
    echo "Web (Emscripten):"
    echo "  emsdk install latest && emsdk activate latest"
    echo "  emcmake cmake .. && emmake make"
}

# Package manager integration
function conan_init() {
    local project_name="${1:-$(basename $PWD)}"

    cat > conanfile.txt << EOF
[requires]
# Add your dependencies here
# Example: boost/1.82.0

[generators]
CMakeDeps
CMakeToolchain

[layout]
cmake_layout
EOF

    echo "Conan configuration created. Add dependencies and run:"
    echo "conan install . --build=missing"
}

function vcpkg_init() {
    cat > vcpkg.json << EOF
{
    "name": "$(basename $PWD | tr '[:upper:]' '[:lower:]')",
    "version": "1.0.0",
    "dependencies": [
    ]
}
EOF
    echo "vcpkg.json created. Add dependencies and integrate with CMake."
}

# Update help function
function show_help() {
    echo "=== Custom Commands Help ==="
    echo ""
    echo "Navigation Aliases:"
    echo "  gocode          - Go to main coding directory"
    echo "  go<lang>        - Go to specific language directory (cpp, java, python, etc.)"
    echo "  dl/dt           - Go to Downloads/Desktop"
    echo "  home            - Go to home directory"
    echo ""
    echo "C/C++ Development:"
    echo "  create_cmake_project <name> [type] - Create CMake project (raylib, sdl2, boost, etc.)"
    echo "  cpp_init <name> [type]  - Alias for create_cmake_project"
    echo "  cpp_templates           - Show available project templates"
    echo "  cpp_deps               - Show common C++ dependencies"
    echo "  cbuild/cbuildr/cbuildd - Build project (release/debug)"
    echo "  cclean                 - Clean build directory"
    echo "  cbld/crun              - Compile and run C programs"
    echo "  cppb/cppr              - Compile and run C++ programs"
    echo "  conan_init/vcpkg_init  - Initialize package managers"
    echo ""
    echo "Development:"
    echo "  create_project  - Create new project with git init"
    echo "  init_c_project  - Create C project structure"
    echo ""
    echo "System:"
    echo "  yi/yr/yu        - Yay install/remove/update"
    echo "  c/cl/cls        - Clear terminal"
    echo "  refresh         - Reload zsh config"
    echo ""
    echo "For more details, see: ~/.zprezto/modules/my-custom-funcs/init.zsh"
}

