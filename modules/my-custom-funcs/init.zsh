# Aliases
# Goto Coding Directories
alias gocode='cd $HOME/Desktop/Coding/'
alias gocpp='cd $HOME/Desktop/Coding/CPP/'
alias gojava='cd $HOME/Desktop/Coding/Java/'
alias gopython='cd $HOME/Desktop/Coding/Python/'
alias gotic80='cd $HOME/Desktop/Coding/tic80code/'
alias gocsharp='cd $HOME/Desktop/Coding/csharp/'
alias goclang='cd $HOME/Desktop/Coding/C/'
alias gorust='cd $HOME/Desktop/Coding/rust/'
alias gogolang='cd $HOME/Desktop/Coding/golang/'
alias gojavascript='cd $HOME/Desktop/Coding/javascript/'
alias gomojo='cd $HOME/Desktop/Coding/mojo/'
alias goodin='cd $HOME/Desktop/Coding/Odin/'
alias gozig='cd $HOME/Desktop/Coding/zig/'

# Terminal Aliases
alias c='clear'         # Clears the terminal
alias cl='clear'        # clears the terminal
alias cls='clear'       # "lears the terminal" (typo, keeps clear)
alias clr='clear'       # clears the terminal
alias q='exit'           # Leaves the terminal
alias :q='exit'         # Leaves the terminal
alias ccat='pygmentize -g' # Cats files in human mode
alias home='cd $HOME'    # Goes to home directory
alias homedir='echo $HOME' # "Goes to home directory" (red

# SillyTavern Commands
alias start-st="cd /home/pedrot/SillyTavern-Launcher/SillyTavern/ && sudo ./start.sh"
alias update-st="cd /home/pedrot/SillyTavern-Launcher/ && sudo ./launcher.sh"
alias install-st="cd /home/pedrot/SillyTavern-Launcher/ && sudo ./install.sh"
alias open-st="cd /home/pedrot/SillyTavern-Launcher/"

# Default folders
alias dl="cd ~/Downloads"  # Download folder
alias dt="cd ~/Desktop"   # Desktop folder
alias fap="cd ~/Downloads/pron/" # Pron folder (warning: suggestive name)

# Games Commands
alias bar="cd ~/Desktop/BAR.appimage"
alias bnet="cd ~/Desktop/BNET.desktop"
alias lastepoch="cd ~/Desktop/Last Epoch.desktop"
alias lethalcompany="cd ~/Desktop/LethalCompany.desktop"
alias citra="cd ~/Desktop/Citra.desktop"
alias millenia="cd ~/Desktop/Millenia.desktop"
alias fivenations="cd ~/Desktop/FiveNations.desktop"

# Yay Commands (assuming you have Yay installed)
alias yi='yay -S'            # Install yay package
alias yr='yay -Rns'          # Remove yay package
alias yu='yay -Syyu'          # Update Yay
alias sysu='eos-update --aur' # System upgrade
alias ycc='yay -Scc'          # Complete cache cleaning
alias ys='yay -Ss'            # Search for package
alias yco='su && pacman -Qdt -q | xargs pacman --noconfirm -R' # Yay clear orphan packages
alias yspy='ys -python'       # Search for python packages
alias yps='yay -Ps'           # List all installed yay packages
alias ysgames='ys game'       # Search for game packages

# 

# Zprestoc Command
alias refresh="source ~/.zprezto/runcoms/zshrc"
alias my_configs="codium /home/pedrot/.zprezto/modules/my-custom-funcs/init.zsh"

# Environment Variables
export YTDIR="$HOME/Youtube"
export YTVDIR="$YTDIR/Video"
export YTADIR="$YTDIR/Audio"
export PYSCRIPTDIR="$HOME/pybashscript"
export WEBSITEDIR="$HOME/Websites"
export HOME="$HOME"
export DESKTOP="$HOME/Desktop/"
export CODING="$HOME/Desktop/Coding"
export CPP="$CODING/CPP"
export JAVA="$CODING/Java"
export PYTHON="$CODING/Python"
export TIC80="$CODING/tic80code"
export CSHARP="$CODING/charp"
export CLANG="$CODING/C"
export RUST="$CODING/rust"
export GOLANG="$CODING/golang"
export JAVASCRIPT="$CODING/javascript"
export MOJO="$CODING/mojo"
export ODIN="$CODING/Odin"
export ZIG="$CODING/zig"
export ZSHCONFIG="~/.zshrc"
export ZSHALIASES="~/.aliases"
export ZSHFUNCS="~/.zshfuncs"
export BASHSCRIPTS="$HOME/bash_scripts"
export PYBASHSCRIPTS="$HOME/pybashscript/"
export DEFAULTEDITOR="codium"

# CPP Commands
alias cppb='g++ *.cpp -o main'        # Builds ALL .cpp files within a directory
alias cppr='g++ *.cpp -o main && ./main' # Builds and runs ALL .cpp files within a directory
alias cpprray='g++ *.cpp -o game -lraylib -lm && ./main' # Builds and runs ALL .cpp files with raylib
alias cppbray='g++ *.cpp -o game -lraylib -lm' # Builds All .cpp files with raylib
alias cppro='g++ main.cpp main && ./main' # Builds and Runs main.cpp
alias cppra='g++ main.cpp main -lraylib -lm && ./main' # Builds and Runs main.cpp with raylib

# VCPK Commands (assuming you have VCPKG installed)
alias vcpki='vppkg install'  # Installs cpp package via vcpkg
alias vcpks='vcpkg search'    # Searches cpp package via vcpkg
alias vcpkg_upd='cd /home/pedrot/vcpkg && gp' # Updates vcpkg repository
alias vcpkg='sudo vcpkg update' # Updates vcpkg packages

function pipi() {
  # Description: Installs python packages via yay
  local pkgs=""
  for pkg_name in "$@"
  do
    pkgs="$pkgs python-$pkg_name "
  done
  yi "$pkgs"
}

function pips() {
  # Description: Searches python packages via yay
  local pkgs=""
  for pkg_name in "$@"
  do
    pkgs="$pkgs $pkg_name "
  done
  ys python "$pkgs"
}

function pipr() {
  # Description: Removes python packages via yay
  local pkgs=""
  for pkg_name in "$@"
  do
    pkgs="$pkgs python-$pkg_name "
  done
  yr "$pkgs"
}

function pydlyt() {
  # Description: Downloads a youtube video as audio and video with a python script
  local media_type=$1
  local url=$2
  local target_dir=$3
  local index=$4
  local action=$5

  python $PYSCRIPTDIR/pydlyt.py $media_type $url --target_dir "$target_dir" --index $index

  if [[ -n "$action" ]]; then
    case "$action" in
      goto)
        if [[ $media_type == video ]]; then
          cd $YTVDIR/$target_dir
        elif [[ $media_type == audio ]]; then
          cd $YTADIR/$target_dir
        fi
      ;;
      play)
        if [[ $media_type == video ]]; then
          vlc $YTVDIR/$target_dir
        elif [[ $media_type == audio ]]; then
          vlc $YTADIR/$target_dir
        fi
      ;;
    esac
  fi
}

function watch() {
  # Description: Watches a stream using streamlink
  emulate -L zsh
  local quality="best"
  local player="vlc"

  # Parse arguments using getopts
  while getopts ":q:p:" opt; do
    case $opt in
      q) quality="$OPTARG" ;;
      p) player="$OPTARG" ;;
      \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
  done

  # Shift arguments to skip processed options
  shift $((OPTIND-1))

  # Ensure a stream URL is provided
  if [[ -z "$1" ]]; then
    echo "Error: Please provide a stream URL." >&2
    exit 1
  fi

  # Call streamlink with parsed arguments
  streamlink --player="$player" "$1" "${quality}"
}

function dlweb() {
  # Description: Downloads a website recursively
  local url=$1
  local dest_dir=$2

  if [[ -z "$dest_dir" ]]; then
    echo "Please specify a destination subdirectory within $WEBSITEDIR"
    return 1
  fi

  local cmd="wget -m -r -l inf -k -p -E -e robots=off -U Mozilla --limit-rate=35K --random-wait -P $WEBSITEDIR/$dest_dir $url/"

  read -q "Are you sure you want to run '$cmd'? [y/N] "
  if [[ $? != 0 || ! "$REPLY" =~ ^[Yy]$ ]]; then
    return 1
  fi

  mkdir -p "$WEBSITEDIR/$dest_dir"
  eval "$cmd"
}

function  openConfig() {
    codium ~/.zshrc
    codium ~/.aliases
    codium ~/.zshfuncs
}

function srcConfig() {
    source ~/.zshrc
    source ~/.aliases
    source ~/.zshfuncs
}

# Example 'confirm && cd dir'
confirm() {
    if [ "$1" = "" ]; then
        read -r -p "${1:-Are you sure? [y/N]} " response
        case "$response" in
        [yY][eE][sS] | [yY])
            true
            ;;
        *)
            false
            ;;
        esac
    else
        read -r -p "${1:-$4? [y/N]} " response
        case "$response" in
        [yY][eE][sS] | [yY])
            true
            ;;
        *)
            false
            ;;
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

merge() {
  if [[ "$#" -lt 3 ]]; then
    echo "Usage: merge file1 file2 ... -o outputfile"
    return 1
  fi

  # Find the output file by searching for the "-o" flag
  for i in "$@"; do
    if [[ "$i" == "-o" ]]; then
      outfile="${@[$(($i+1))]}"
      break
    fi
  done

  if [[ -z "$outfile" ]]; then
    echo "No output file specified."
    return 1
  fi

  # Remove the "-o" and output file from the arguments list
  args=("${(@)@}" "-o" "$outfile")

  # Overwrite or create the output file
  > "$outfile"

  # Loop through all files and append their content to the output file
  for file in "$@"; do
    if [[ "$file" != "-o" && "$file" != "$outfile" ]]; then
      if [[ -f "$file" ]]; then
        echo "=== $file ===" >> "$outfile"
        cat "$file" >> "$outfile"
        echo >> "$outfile" # Add a newline between file contents
      else
        echo "Warning: $file does not exist, skipping..."
      fi
    fi
  done

  echo "Merged files into $outfile."
}
