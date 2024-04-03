  # Python functions
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

function watchstream() {
  # Description: Watches a stream using streamlink
  emulate -L zsh
  local -A args

  argparse 'quality=' 'player=' -- $argv

  args+=(quality="${_flag_quality:-best}")
  args+=(player="${_flag_player:-vlc}")

  streamlink --player="${args[player]}" "$argv[1]" "${args[quality]}"
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

#read man pages on okular as pdf files
function manpdf() {
  local target=$1

  man -Tpdf "$1" | okular -
}

alias man="manpdf"

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
mvFiles() {
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

queryPacks() {
    pacman -Ss $1 | paste - - | grep --color=always -e '/'$1'' | less -R
}

dlyt() {
    # Check for yt-dlp existence
    if ! command -v yt-dlp &> /dev/null; then
        echo "Error: yt-dlp is not installed. Please install it before using this script."
        exit 1
    fi

    local media_type="$1"
    local url="$2"
    local target="$3"
    local index="$4"
    #local extra="$5"

    local defaultDir="$HOME/Youtube"

    if [ "$media_type" = "h" ] || [ "$media_type" = "-h" ] || [ "$media_type" = "--help" ]; then
        echo "Usage: dlyt <media_type> (audio/video) <url> <dest_dir> (optional) <index> (optional) <extra> (optional)"
        echo "If no destination directory is specified, it will be downloaded to the default directory for the media type."
        echo "If no index is specified, it will download every video in the playlist."
        echo "Example: dlyt audio https://www.youtube.com/playlist?list=PL1g_M8-ZPy79UTOUiheecrOlGLVMtoPU6 Music 1:5"
        echo "Will download the first 5 videos in the playlist 'Music' to the 'Music' directory in the default directory for audio."
        echo "You can also type dlyt defaultDir to see where your files are going."
        echo "If you want to download to the default directory just add '.' at the third argument."
        echo "If you want to ignore index, add '0' to the fourth argument."
        exit 1
    fi

    if [ "$media_type" = "audio" ]; then
        defaultDir+="/Audio"
        if [ "$target" = "." ]; then
            if [ "$index" = "0" ]; then
                yt-dlp -N 5 -c -f 'ba' -x --audio-format mp3 -P $defaultDir $url
            else
                yt-dlp -N 5 -c -f 'ba' -x --audio-format mp3 -P $defaultDir -I $index $url
            fi
        else
            mkdir -p $defaultDir/$target/
            if [ "$index" = "0" ]; then
                yt-dlp --progress -N 5 -c -f 'ba' -x --audio-format mp3 -P $defaultDir/$target/ $url
            else
                yt-dlp --progress -N 5 -c -f 'ba' -x --audio-format mp3 -P $defaultDir/$target/ -I $index $url $defaultDir/$target
            fi
        fi
    elif [ "$media_type" = "video" ]; then
        defaultDir+="/Video"
        if [ "$target" = "." ]; then
            if [ "$index" = "0" ]; then
                yt-dlp --progress -N 5 -c -f 'bestvideo[height<=720]+bestaudio/best[height<=720]+bestaudio' -P $defaultDir $url
            else
                yt-dlp -N 5 -c -f 'bestvideo[height<=720]+bestaudio/best[height<=720]+bestaudio' -P $defaultDir -I $index $url
            fi
        else
            mkdir -p $defaultDir/$target/
            if [ "$index" = "0" ]; then
                yt-dlp --progress -N 5 -c -f 'bestvideo[height<=720]+bestaudio/best[height<=720]+bestaudio' -P $defaultDir/$target/ $url
            else
                yt-dlp --progress -N 5 -c -f 'bestvideo[height<=720]+bestaudio/best[height<=720]+bestaudio' -P $defaultDir/$target/ -I $index $url
            fi
        fi
    fi
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

function new_project() {
  # Description: Creates a new project with optional git remote.
  # Usage: new_project language project_name extension [--remote remote_url]

  emulate -L zsh
  local -A args

  argparse 'h/help' -- $argv

  if [[ $_flag_help ]]; then
    echo "Usage: new_project language project_name extension [--remote remote_url]"
    echo "  language: the programming language of the project"
    echo "  project_name: the name of the project"
    echo "  extension: the name of the extension for the language"
    echo "  --remote remote_url: add a git remote"
    echo "  examples:"
    echo "    new_project python py my_project"
    echo "    new_project rust rs my_project --remote git@github.com:user/my_project.git"
    return 0
  fi

  local language="${argv[1]}"
  local project_name="${argv[2]}"
  local extension="${argv[3]}"

  if [[ -z "$language" ]]; then
    echo "Please specify a language"
    return 1
  fi

  if [[ -z "$project_name" ]]; then
    echo "Please specify a project name"
    return 1
  fi

  if [[ -z "$extension" ]]; then
    echo "Please specify an extension"
    return 1
  fi

  local location="/home/pedrot/Desktop/Coding/$language/$project_name"
  echo "Project location: $location"

  mkdir -p "$location"

  echo "Opening $location in $editor"
  cd "$location"
  touch "main.$extension"
  git init
  git add "main.$extension"
  git commit -m "Initial commit"

  if [[ "$argv[4]" == "--remote" ]]; then
    local remote_url="${argv[5]}"
    git remote add origin "$remote_url"
    git push -u origin master
  fi

  $editor .

  echo "Created a new $language project $project_name at $location."
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

function printt() {
  echo $1
}
