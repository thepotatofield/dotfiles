############################
#       ZSH - Options      #
############################

# History management
setopt EXTENDED_HISTORY          # Add timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_ALL_DUPS     # Ignore all duplicates
setopt HIST_IGNORE_DUPS         # Ignore duplicates when searching history
setopt HIST_IGNORE_SPACE        # Ignore commands that start with space
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from history
setopt HIST_SAVE_NO_DUPS        # Do not save duplicates in history
setopt HIST_VERIFY              # Verify history commands before executing them
setopt SHARE_HISTORY            # Share history between all sessions
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Directory navigation
setopt AUTO_CD           # Automatically cd to a directory if it is the name of a command
setopt AUTO_PUSHD        # Automatically push the current directory onto the stack
setopt PUSHD_IGNORE_DUPS # Ignore duplicates when pushing directories onto the stack
setopt PUSHD_MINUS       # Push directories onto the stack with a minus sign to pop them off
setopt CDABLE_VARS       # Allow cd to be used with variables

# Completion
setopt ALWAYS_TO_END    # Move cursor to the end of the line after completion
setopt AUTO_MENU        # Automatically show completion menu
setopt COMPLETE_IN_WORD # Complete from the first word of a completion if it is not ambiguous
setopt LIST_PACKED      # Pack completion lists more tightly
setopt EXTENDED_GLOB    # Enable extended globbing

# Correction and expansion
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive mode

autoload -Uz compinit && compinit