############################
#           GIT            #
############################
alias lg='lazygit --use-config-file $DOFILES_DIR/lazygit/config.yml' # Open lazygit with custom config

alias g-log="git log -1 --stat"
alias g-open-url='open $(git config remote.origin.url);' # Open the github repo in the default web browser
alias g-pull-all='find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull \;' # Pull all repositories in the current directory
