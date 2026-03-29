############################
#       DIRECTORIES        #
############################
export DEV_DIR="$HOME/Dev"
export DOFILES_DIR="$HOME/dotfiles"
export DOCUMENTS_DIR="$HOME/Documents"
export DESKTOP_DIR="$HOME/Desktop"
export ICLOUD_DIR="$HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs"
export ICLOUD_DOTFILES_DIR="$ICLOUD_DIR/Dotfiles"

alias cdev="cd $DEV_DIR" # Go to Dev folder
alias cdot="cd $DOFILES_DIR" # Go to Dotfiles folder
alias cdoc="cd $DOCUMENTS_DIR" # Go to Documents folder
alias cdesk="cd $DESKTOP_DIR" # Go to Desktop folder
alias cbrew="cd $HOMEBREW_DIR" # Go to Homebrew folder
alias ccloud="cd $ICLOUD_DIR" # Go to iCloud folder

alias cd1="cd .."             # Go 1 level up
alias cd2="cd ../.."          # Go 2 levels up
alias cd3="cd ../../.."       # Go 3 levels up
alias cd-="cd -"              # Go back to the previous directory

alias md="mkdir -p"         # Create directory
alias mdc="fn_mkdir_cd"     # Create directory and cd into it

##############################
#         FUNCTIONS          #
##############################

# Create directory and cd into it
fn_mkdir_cd() {
  mkdir -p "$1" && cd "$1"
}