############################
#       FILE UTILS         #
############################
alias c="cp -iv"            # Copy files and directories with verbose output and interactive mode
alias m="mv -iv"            # Move files and directories with verbose output and interactive mode
alias rm="rm -rif"          # Remove files and directories with verbose output and interactive mode
alias rmt="trash"           # Remove files and directories to trash bin
alias zin="fn_archive"      # Archive a folder
alias zout="fn_extract"     # Extract an archive


##############################
#         FUNCTIONS          #
##############################

# Archive a folder — usage: archive <folder> <format>
fn_archive() {
  local target="${1%/}"  # strip trailing slash if any

  if [[ ! -e "$target" ]]; then
    echo "Error: '$target' not found"
    return 1
  fi

  case "$2" in
    tar)   tar -cvf  "${target}.tar"    "$target" ;;
    tgz)   tar -czvf "${target}.tar.gz" "$target" ;;
    *)     zip -r    "${target}.zip"    "$target" ;;  # default: zip
  esac

  echo "Done: archived as ${target}.${2:-zip}"
}

# Extract an archive — usage: extract myarchive.tar.gz
fn_extract() {
  local file="$1"

  if [[ ! -f "$file" ]]; then
    echo "Error: '$file' not found"
    return 1
  fi

  case "$file" in
    *.tar.gz)  tar -xzvf "$file" ;;
    *.tar)     tar -xvf  "$file" ;;
    *.zip)     unzip     "$file" ;;
    *)
      echo "Error: unsupported format '$file'"
      echo "Supported: .tar.gz .tar .zip"
      return 1
      ;;
  esac
  echo "Done: extracted '$file'"
}