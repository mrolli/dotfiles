# General functions used in shell scripts

# Style variables
if tput setaf 1 &> /dev/null
then
  reset=$(tput sgr0)
  bold=$(tput bold)
  underline=$(tput smul)
  nounderline=$(tput rmul)
  # Solarized colors, taken from http://git.io/solarized-colors.
  black=$(tput setaf 0)
  blue=$(tput setaf 33)
  cyan=$(tput setaf 37)
  green=$(tput setaf 64)
  orange=$(tput setaf 166)
  purple=$(tput setaf 125)
  red=$(tput setaf 124)
  violet=$(tput setaf 61)
  white=$(tput setaf 15)
  yellow=$(tput setaf 136)
else
  # See https://techstop.github.io/bash-script-colors/
  reset="\e[0m"
  bold=''
  underline=''
  nounderline=''
  black="\e[1;30m"
  blue="\e[1;34m"
  cyan="\e[1;36m"
  green="\e[1;32m"
  orange="\e[1;33m"
  purple="\e[1;35m"
  red="\e[1;31m"
  violet="\e[1;35m"
  white="\e[1;37m"
  yellow="\e[1;33m"
fi

prompt_confirm() {
  while true; do
    printf "\r  [ ${yellow}??${reset} ] ${1:-Continue?} [y/n]: "
    read -r -n 1 REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " ${red} %s \n${reset}" "invalid input"
    esac
  done
}

function info {
  printf "\r  [ ${blue}..${reset} ] $1\n"
}

function warning {
  printf "\r  [ ${yellow}??${reset} ] $1"
}

function success {
  printf "\r  [ ${green}OK${reset} ] $1\n"
}

function fail {
  printf "\r  [${red}FAIL${reset}] $1\n" >&2
}
