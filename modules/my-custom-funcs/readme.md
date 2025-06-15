# Zsh Configuration and Utility Script

This repository contains a Zsh script designed to enhance your command-line experience by providing a variety of aliases, functions, and environment variables. These customizations streamline navigation, package management, and other common tasks.

## Features

### Aliases

- **Coding Directories**: Quickly navigate to your coding directories with commands like `gocode`, `gocpp`, `gojava`, etc.
- **Terminal Commands**: Simplify terminal operations with aliases for clearing the screen (`c`, `cl`, `cls`, `clr`) and exiting the terminal (`q`, `:q`).
- **File Viewing**: Use `ccat` to display files with syntax highlighting.
- **Directory Navigation**: Shortcuts to frequently used directories such as `home`, `dl` (Downloads), and `dt` (Desktop).
- **SillyTavern Management**: Manage the SillyTavern application with commands like `start-st`, `update-st`, and `open-st`.
- **Games**: Navigate to game directories with aliases like `bar`, `bnet`, `lastepoch`, etc.
- **Yay Package Management**: Manage packages with `yay` using aliases like `yi` (install), `yr` (remove), and `yu` (update).

### Environment Variables

- Set up environment variables for various directories and paths, such as `YTDIR` for YouTube downloads and `CODING` for the coding directory.

### Functions

- **Python Package Management**: Functions like `pipi`, `pips`, and `pipr` to install, search, and remove Python packages via `yay`.
- **Media Downloading**: `pydlyt` to download YouTube videos as audio or video.
- **Stream Watching**: `watch` to watch streams using `streamlink`.
- **Website Downloading**: `dlweb` to download websites recursively.
- **Configuration Management**: `openConfig` and `srcConfig` to open and source Zsh configuration files.
- **Confirmation Prompts**: `confirm` and `confirm_v2` to prompt for user confirmation before executing commands.
- **Alias Management**: `addAlias` to add new aliases to the `~/.aliases` file.
- **Random Number Generation**: `rng` and `generate_rng` to generate random numbers within a specified range.
- **Command Not Found Handler**: Custom handler to suggest packages when a command is not found.
- **File Management**: `mvfiles` to move files with confirmation, `extract` and `compressDir/File` to extract and compress files.
- **Media Playback**: `play_media` to play audio or video files using VLC.
- **Disk Usage**: `dh` to display disk usage sorted by size.
- **GitHub Backup**: `backup_git` to back up all public repositories from a GitHub account.
- **Project Creation**: `create_project` to create a new project directory with a specified language and initialize a Git repository.
- **Pacman Package Listing**: `list_pacman_packages` to list installed Pacman packages sorted by name or size.

## Usage

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Source the Script**: Add the script to your `.zshrc` or source it directly in your terminal session.
3. **Customize**: Modify the aliases, functions, and environment variables to suit your needs.

## Requirements

- **Zsh**: Ensure you have Zsh installed and set as your default shell.
- **Yay**: Required for package management functions.
- **VLC**: Required for media playback functions.
- **Streamlink**: Required for stream watching functions.
- **7za**: Required for file extraction and compression functions.
- **Git**: Required for GitHub backup and project creation functions.