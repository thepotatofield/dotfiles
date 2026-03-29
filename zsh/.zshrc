[[ -f ~/.config/secrets/env.zsh ]] && source ~/.config/secrets/env.zsh

############################
#       ZSH OPTIONS        #
############################
export ZSH_CONFIG_DIR="$HOME/.zsh"
fpath=("$ZSH_CONFIG_DIR" $fpath)
source "$ZSH_CONFIG_DIR/zsh-opt.zsh"

############################
#         ZSH FILES        #
############################
source "$ZSH_CONFIG_DIR/brew.zsh"
source "$ZSH_CONFIG_DIR/theme.zsh"

source "$ZSH_CONFIG_DIR/dir.zsh"
source "$ZSH_CONFIG_DIR/edit.zsh"
source "$ZSH_CONFIG_DIR/file.zsh"
source "$ZSH_CONFIG_DIR/find.zsh"
source "$ZSH_CONFIG_DIR/info.zsh"
source "$ZSH_CONFIG_DIR/list.zsh"
source "$ZSH_CONFIG_DIR/network.zsh"

source "$ZSH_CONFIG_DIR/git.zsh"
source "$ZSH_CONFIG_DIR/python.zsh"

############################
#       MISC ALIASES       #
############################
alias h="tldr"                # Show help for a command using tldr tool
alias r="exec zsh"            # Reload the shell (also source ~/.zshrc). More thorough than just source ~/.zshrc.
alias ss="cmatrix -a -s -b"   # Display matrix animation as screensaver
alias top="htop"              # List top-level processes using htop tool
alias x="clear"               # Clear the screen
alias xl="clear; l"           # Clear the screen and list current directory
alias y="yazi"                # Open yazi file manager
