############################
#       INFO UTILS         #
############################
alias info-env="fn_env_info"        # Show all environment variables
alias info-path="fn_path_info"      # Show all paths in PATH
alias info-sys="fn_system_info"     # Show system information


##############################
#         FUNCTIONS          #
##############################

# Show all environment variables
fn_env_info() {
    printf "%-30s %s\n" "ENV VARIABLE" "ENV VALUE"
    printf "%-30s %s\n" "--------" "-----"
    
    # Get all environment variables, exclude PATH, sort them
    env | grep -v "^PATH=" | sort | while IFS='=' read -r var value; do
        # Truncate long values for readability
        if [[ ${#value} -gt 80 ]]; then
            value="${value:0:77}..."
        fi
        printf "%-30s %s\n" "$var" "$value"
    done
}

# Show all paths in PATH
fn_path_info() {
    echo $PATH | tr ':' $'\n'
}

# Show system information
fn_system_info() {
  local fmt="  %-18s %s\n"

  printf "$fmt" "Date:"        "$(date '+%A %d %B %Y, %H:%M')"
  printf "$fmt" "Host:"        "$(scutil --get ComputerName) ($HOST)"
  printf "$fmt" "User:"        "$(whoami)"
  printf "$fmt" "macOS:"       "$(sw_vers -productName) $(sw_vers -productVersion)"
  printf "$fmt" "Kernel:"      "$(uname -r)"
  printf "$fmt" "Uptime:"      "$(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}' | xargs)"
  printf "$fmt" "CPU:"         "$(sysctl -n machdep.cpu.brand_string)"
  printf "$fmt" "Memory:"      "$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 ))GB total"
  printf "$fmt" "Load:"        "$(sysctl -n vm.loadavg | awk '{print $2, $3, $4}') (1m 5m 15m)"
  printf "$fmt" "Disk:"        "$(df -h / | awk 'NR==2 {print $3 " used / " $2 " total (" $5 " full)"}')"
  printf "$fmt" "WiFi IP:"     "$(ipconfig getifaddr en0 2>/dev/null || echo 'not connected')"
  printf "$fmt" "Eth IP:"      "$(ipconfig getifaddr en1 2>/dev/null || echo 'not connected')"
  printf "$fmt" "Public IP:"   "$(curl -s ifconfig.me)"
  printf "$fmt" "Sessions:"    "$(w -h | grep -v console | wc -l | xargs) terminal session(s)"
}