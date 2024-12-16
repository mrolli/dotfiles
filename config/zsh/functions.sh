# Function definitions

# Open manpages in terminalapp
function manx { open x-man-page://$@; }
# Open mangpages as PDF in preview app
function manp { man -t $@ | open -f -a "Preview"; }

# Prepend a string to a filename
function prepend {
  if [ $# -ne 2 ]; then
    echo "Usage: ${0} FILE PREFIX"
  else
    mv "${1}" "${2}${1}"
  fi
}

# Append a sring to a filename
function append {
  if [ $# -ne 2 ]; then
    echo "Usage: ${0} FILE SUFFIX"
  else
    mv "${1}" "${1}${2}"
  fi
}

# print week number based on date or now()
function week {
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
function https-cert {
  if [ $# -ne 1 ]; then
    echo "Usage: https-cert HOST"
    return
  fi

  openssl s_client -showcerts -servername "${1}" -connect "${1}":443 </dev/null 2>/dev/null | openssl x509 -inform pem -noout -text
}

# load a local tmuxp config file in a directory by first changing pwd
function tmuxpl {
  # Show usage if no argument is provided
  [ $# -ne 1 ] && echo "Usage: tmuxpl DIR" && return 1
  # Is it a filepath or a named config to a configuration already? Load it!
  if [ -f $1 -o -f ~/.config/tmuxp/$1.y*ml ]
  then
    tmuxp load $1
    return 0
  # Assume it's a directory, check for it
  elif [ -d $1 ]
  then
    (cd $1 && tmuxp load .)
    return 0
  else
     echo "Error: Provided path is not a readable directory path" && return 2
  fi
}

# Check for valid Azure CLI session
function __has_az_ready {
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
function azsubswitch {
  __has_az_ready || return 1

  if ! command -v fzf &>/dev/null; then
    echo "fzf not found. Please install it first."
    return 1
  fi

  az account list --query "[].{id:id,name:name}" -o tsv |
    fzf --no-multi --bind 'enter:execute(az account set -s {1})+abort'
}

# List available Azure subscriptions
function azsublist {
  __has_az_ready || return 1

  az account list --query "[].{name:name, subscriptionId:id}" -o table
}
