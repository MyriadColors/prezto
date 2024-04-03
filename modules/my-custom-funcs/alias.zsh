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

# Zprestoc Command
alias refresh="source ~/.zprezto/runcoms/zshrc"
