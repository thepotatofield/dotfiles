############################
#      NETWORKING TOOLS    #
############################
# Network interface info (modern ifconfig alternative)
alias net-ip="fn_net_ip" # Get my IP addresses
alias net-hw="networksetup -listallhardwareports" # Show network hardware ports
alias net-trace="traceroute" # Trace the route to a given host

alias http-headers="fn_http_headers" # Show request + response headers in bat
alias http-view="fn_http_view" # Show request + response headers + body in bat


##############################
#         FUNCTIONS          #
##############################

# Get my IP addresses
fn_net_ip() {
  echo "WiFi:     $(ipconfig getifaddr en0 2>/dev/null || echo 'not connected')"
  echo "Ethernet: $(ipconfig getifaddr en1 2>/dev/null || echo 'not connected')"
  echo "Public:   $(curl -s ifconfig.me)"
}

# Show request + response headers in bat
fn_http_headers() {
  http --print=Hh "$@" | bat --language=http --style=header,grid
}

# Show request + response headers + body in bat
fn_http_view() {
  local url="$1"
  shift
  local args=("$@")

  # Single GET request, capture everything
  local response
  response=$(http --print=hb GET "$url" "${args[@]}")

  # Split headers and body at the blank line
  local headers body ct
  headers=$(echo "$response" | awk '/^\r?$/{found=1; next} !found{print}')
  body=$(echo "$response" | awk '/^\r?$/{found=1; next} found{print}')
  ct=$(echo "$headers" | grep -i "content-type" | awk '{print $2}')

  echo "$headers" | bat --language=http --style=plain

  if echo "$ct" | grep -q "json"; then
    echo "$body" | bat --language=json
  elif echo "$ct" | grep -q "html"; then
    echo "$body" | bat --language=html
  elif echo "$ct" | grep -q "xml"; then
    echo "$body" | bat --language=xml
  else
    echo "$body" | bat
  fi
}
