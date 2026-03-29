############################
#       LISTING UTILS      #
############################
export BLOCKSIZE=1k # Display units in kibibytes (1024 bytes)
export EZA_CONFIG_DIR="$HOME/.config/eza"

alias l='eza -la --icons=always --no-time --no-permissions --git --header' # List all files and directories in the current directory
alias ll="eza -la --icons=always --time-style=long-iso --git --header" # List all files and directories in the current directory (all params)
alias lf="eza -laf --icons=always --no-time --no-permissions --git --header" # Only files (all params)
alias ld="eza -laD --icons=always --no-time --no-permissions --git --header" # Only dirs (all params)
alias lt="eza -laT --icons=always --no-user --no-time --no-permissions --git --recurse --level 2" # List tree with 2 levels