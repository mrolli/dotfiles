# Function definitions

# Open manpages in terminalapp
manx() { open x-man-page://$@; }
# Open mangpages as PDF in preview app
manp() { man -t $@ | open -f -a "Preview"; }

# Prepend a string to a filename
prepend() {
  if [ $# -ne 2 ]; then
    echo "Usage: ${0} FILE PREFIX"
  else
    mv "${1}" "${2}${1}"
  fi
}

# Append a sring to a filename
append() {
  if [ $# -ne 2 ]; then
    echo "Usage: ${0} FILE SUFFIX"
  else
    mv "${1}" "${1}${2}"
  fi
}

# print week number based on date or now()
week() {
  if [ "${1}" = "-h" ]; then
    echo "Usage: week [YYYY-MM-DD]"
    return
  fi

  # date on macOS does not have the --date option; install coreutils
  # using Homebrew there
  type gdate &>/dev/null && datecmd="gdate" || datecmd="date"

  [ -z "${1}" ] && $datecmd +%V || $datecmd --date="${1}" +%V
}

# print SSL certificate of remote website
https-cert() {
  if [ $# -ne 1 ]; then
    echo "Usage: https-cert HOST"
    return
  fi

  openssl s_client -showcerts -servername "${1}" -connect "${1}":443 </dev/null 2>/dev/null | openssl x509 -inform pem -noout -text
}

# Check for valid Azure CLI session
__has_az_ready() {
  if ! command -v az &>/dev/null; then
    echo "Azure CLI not found. Please install it first."
    return 1
  fi

  if ! az account show &>/dev/null; then
    echo "No Azure CLI session found. Please run 'az login' first."
    return 1
  fi
}

# Switch between Azure subscriptions using fzf
azsubswitch() {
  __has_az_ready || return 1

  if ! command -v fzf &>/dev/null; then
    echo "fzf not found. Please install it first."
    return 1
  fi

  az account list --query "[].{id:id,name:name}" -o tsv |
    fzf --no-multi --bind 'enter:execute(az account set -s {1})+abort'
}

# List available Azure subscriptions
azsublist() {
  __has_az_ready || return 1

  az account list --query "[].{name:name, subscriptionId:id}" -o table
}

# Get id of a user by UPN
azgetuserid() {
  __has_az_ready || return 1

  if [ $# -ne 1 ]; then
    echo "Usage: azgetidofuser UPN"
    return 1
  fi

  az ad user show --id "$1" --query id -o tsv
}
