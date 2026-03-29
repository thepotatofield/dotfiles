############################
#         HOMEBREW         #
############################
export HOMEBREW_DIR="/opt/homebrew"
export PATH="$HOMEBREW_DIR/bin:$PATH"

# Load brew environment variables
eval "$($HOMEBREW_DIR/bin/brew shellenv)" 
if type brew &>/dev/null; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi
export HOMEBREW_NO_ENV_HINTS=1 # Disable env hints for brew

alias brew-l="brew list --formula --versions | awk '{printf \"%-30s %s\n\", \$1, \$2}'" # List all installed formulae with versions (columnar)

alias brew-ltop="brew leaves | xargs brew list --versions | awk '{printf \"%-30s %s\n\", \$1, \$2}'" # List main (top-level) formulae with versions (columnar)
alias brew-ltop-desc="brew leaves | xargs brew desc | column -t -s ':'" # List main (top-level) formulae with descriptions (columnar)

alias brew-ltree="brew deps --tree --installed " # List dep tree for installed formulae (only formula have deps). Can take one formula as argument.
alias brew-up='brew upgrade ' # Upgrade a specific formula (takes formula name as argument)
alias brew-up-all="fn_brew__upgrade_all_formulae" # Upgrade all formulae

alias brew-lc="brew list --cask --versions | awk '{printf \"%-30s %s\n\", \$1, \$2}'" # List all installed casks with versions (columnar)
alias brew-upc='brew upgrade --cask ' # Upgrade a specific cask (takes cask name as argument)

alias brew-rm='brew uninstall ' # Uninstall a formula or cask (auto-detected)

alias brew-health="fn_brew_health" # Check Homebrew health (doctor, missing deps, outdated packages, cleanup)

alias brew-help="fn_brew_help" # List brew aliases and common raw brew commands


##############################
#         FUNCTIONS          #
##############################

# Print brew shortcuts and common commands without aliases
fn_brew_help() {
  cat <<'EOF'
------------
Brew aliases
------------
  brew-l      Installed formulae with versions
  brew-ltop    Top-level formulae with versions
  brew-ltop-desc Top-level formulae with descriptions
  brew-ltree   Dependency tree for installed formulae (optional: one formula)

  brew-up      Upgrade a specific formula
  brew-up-all  Upgrade all formulae

  brew-lc      Installed casks with versions
  brew-upc     Upgrade a specific cask
  
  brew-rm      Uninstall a formula or cask
  
  brew-health  Health snapshot: doctor, missing, outdated, cleanup preview

--------------------
Common brew commands
--------------------
  brew install <formula>        Install a CLI formula
  brew install --cask <app>     Install a macOS GUI app

  brew search <term>            Search for available formulae and casks
  brew info <name>              Show details and dependencies for a package
  brew desc <name>              Show a one-line description of a package

  brew tap <user/repo>          Add a third-party repository
  brew untap <user/repo>        Remove a third-party repository
  
  brew pin <formula>            Prevent a formula from being upgraded
  brew unpin <formula>          Re-allow a formula to be upgraded
  
  brew link <formula>           Symlink a formula's files into the prefix
  brew unlink <formula>         Remove symlinks for a formula
  
  brew services list            List all managed background services
  brew services start <name>    Start a service and enable at login
  brew services stop <name>     Stop a service and disable at login

  brew uninstall <formula>      Uninstall a formula

https://docs.brew.sh
EOF
}

# Upgrade all formulae
fn_brew__upgrade_all_formulae() { 
  set -e
  echo "--------------------"
  echo "Upgrade all formulae"
  echo "--------------------"
  brew update                  # Updates brew
  brew upgrade                 # Upgrades all formulae
  brew autoremove              # Removes old versions of packages
  brew cleanup --prune=all     # Cleans up old versions of packages
  brew doctor || echo "Brew doctor reported warnings" # Checks for potential issues
  brew missing || echo "Missing dependencies detected" # Checks for missing dependencies
  echo "Done"
}

# Check Homebrew health
fn_brew_health() {
  echo "🍺 Checking Homebrew health..."
  echo "==============================="
  echo

  if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found"
    return 1
  fi

  echo "📦 Homebrew version:"
  brew --version
  echo

  echo "🔍 Running brew doctor..."
  echo "-------------------------"
  if brew doctor; then
    echo "✅ No issues found"
  else
    echo "⚠️  Issues detected above"
  fi
  echo

  echo "🔗 Checking for missing dependencies..."
  echo "---------------------------------------"
  if brew missing; then
    echo "⚠️  Missing dependencies detected above"
  else
    echo "✅ No missing dependencies"
  fi
  echo

  echo "🔄 Checking for outdated packages..."
  echo "------------------------------------"
  outdated_formulae=$(brew outdated --formula)
  outdated_casks=$(brew outdated --cask --greedy)
  
  if [[ -z "$outdated_formulae" && -z "$outdated_casks" ]]; then
    echo "✅ All packages are up to date"
  else
    if [[ -n "$outdated_formulae" ]]; then
      echo "📦 Outdated formulae:"
      echo "$outdated_formulae"
      echo
    fi
    if [[ -n "$outdated_casks" ]]; then
      echo "📦 Outdated casks:"
      echo "$outdated_casks"
    fi
  fi
  echo

  echo "🗑️  Checking for cleanable packages..."
  echo "---------------------------------------"
  cleanup_info=$(brew cleanup -n 2>&1)
  if echo "$cleanup_info" | grep -q "Nothing to do"; then
    echo "✅ No cleanup needed"
  else
    echo "$cleanup_info"
  fi
  echo

  echo "🎉 Health check complete!"
}
