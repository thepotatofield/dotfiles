############################
#       Python Utils       #
############################
alias uv-new="fn_uv_new" # Create a new project with given name and cd into it


##############################
#         FUNCTIONS          #
##############################
# Create a new project with given name and cd into it
fn_uv_new() {
    if [[ -z "$1" ]]; then
        echo "Usage: fn_uv_new <project-name>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" && uv init
}