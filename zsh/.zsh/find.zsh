##############################
#    FIND UTILS - FZF / FD   # 
##############################
alias f="fzf" # Fuzzy finder (stdin → pick one line)
alias fo="fn_fzf_open" # Fuzzy finder with open the selected file in the default application
alias fq="fzf -q" # Fuzzy finder with input query
alias foq="fn_fzf_open_query" # Fuzzy finder with input query and open the selected file in the default application
alias fx="fn_fzf_exec" # Fuzzy-find an alias and run it
alias ff="fn_fzf_finder" # Fuzzy-find a file or folder and reveal it in macOS Finder


##############################
#           FZF SETUP        #
##############################
# Note: After install with brew run install $(brew --prefix)/opt/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF Options
# --extended — enables extended search syntax, meaning you can use special patterns: 
# ^word (prefix match), word$ (suffix match), !word (exclude), 'exact (exact match). 
# Without it, fzf only does fuzzy matching.
# --height 40% — fzf takes up 40% of the terminal height instead of the full screen, 
# so you keep context of what's above it.
# --layout=reverse — puts the input prompt at the top and results below it, which feels 
# more natural for most people (default is prompt at the bottom).
# --border — draws a border around the fzf window.
# --info=inline — shows the match count (e.g. 10/42) on the same line as the prompt, 
# rather than on its own line, saving vertical space.
export FZF_DEFAULT_OPTS="--extended --height 40% --layout=reverse --border --info=inline"


# FZF Default Command
# It uses the fd finder tool to search for files (installed through brew)
# By default FZF uses the built in "find" command.
# This is used to search for files in the current directory and all subdirectories.
# The --hidden option means search for hidden files.
# The --follow option means follow symlinks.
# The --exclude .git option means exclude the .git directory.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
# Ctrl + T: Find file to pass to a command (example: cat CTRL+T)
# Alt + C: Find directory to cd into
# Ctrl + R: Find in shell history


##############################
#         FUNCTIONS          #
##############################

# Show find shortcuts and common commands without aliases
fn_find_help() {
  cat <<'EOF'
------------
Find aliases
------------
  f            Run fzf on stdin (pick one line)
  fo           Pick a file path and open it with open(1)
  fq           fzf with -q (add your query after the alias)
  foq          Pick a file to open; usage: foq <query>
  fx           Fuzzy-pick a shell alias and run it
  ff           Pick a file or folder and reveal it in macOS Finder

----------------------------------------
Common fzf / integration (if fzf.zsh sourced)
----------------------------------------
  Ctrl+T    Insert picked file path into the command line
  Alt+C     cd into picked directory
  Ctrl+R    Fuzzy-search shell history

https://github.com/junegunn/fzf
EOF
}
# Open the selected file in the default application
fn_fzf_open() {
  local file="$(fzf)"
  [[ -n "$file" ]] && open "$file"
}

# Input query and open the selected file in the default application
fn_fzf_open_query() {
  if [[ -z "$1" ]]; then
    echo "Usage: fn_fzf_queryopen <query>"
    return 1
  fi
  fzf -q "$1" | xargs open
}


# Fuzzy-find a file or folder and reveal it in macOS Finder.
# Files: opens the parent folder with the file selected (open -R).
# Folders: opens the folder directly.
fn_fzf_finder() {
  local selected
  selected=$(fd --hidden --follow --exclude .git | fzf --prompt='finder> ')
  [[ -z "$selected" ]] && return
  if [[ -d "$selected" ]]; then
    echo "Opening folder: $selected"
    open "$selected"
  else
    echo "Opening folder: $(dirname "$selected")"
    open -R "$selected"
  fi
}


# Fuzzy-pick an alias and run it in this zsh.
fn_fzf_exec() {
  local cmd
  local -a candidates

  candidates=( ${(k)aliases} )

  cmd=$(
    print -rl -- $candidates \
      | LC_ALL=C sort -u \
      | command fzf --prompt='run> '
  ) || return

  cmd=${cmd//$'\r'/}
  [[ -n $cmd ]] || return 0

  if ! whence -- "$cmd" &>/dev/null; then
    print -u2 "zsh: command not found: $cmd"
    return 127
  fi

  print -s -- "$cmd"
  print -r -- "$cmd"
  eval "$cmd"
}