#!/usr/bin/env bash

# For the confirmation moments in life
prompt_confirm() {
  while true; do
    printf "\r[ ${yellow}??${reset} ] ${1:-Continue?} [y/n]: "
    read -r -n 1 REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " ${red} %s \n${reset}" "invalid input"
    esac
  done
}

# Open manpages in terminalapp
function manx { open x-man-page://$@ ; }
# Open mangpages as PDF in preview app
function manp { man -t $@ | open -f -a "Preview" ; }

# Prepend a string to a filename
function prepend {
  if [ $# -ne 2 ]
  then
    echo "Usage: ${0} FILE PREFIX"
  else
    mv "${1}" "${2}${1}"
  fi
}

# Append a sring to a filename
function append {
  if [ $# -ne 2 ]
  then
    echo "Usage: ${0} FILE SUFFIX"
  else
    mv "${1}" "${1}${2}"
  fi
}

# brewup one-liner to keep things up2date
function brewup {
  echo "[ ${blue}..${reset} ] Updating Homebrew"
  brew update
  out=$(brew outdated)
  if [ ! -z "${out}" ]
  then
    echo "[ ${blue}..${reset} ] The following updates are available:"
    echo $out
    if [ "${1}" = "-f" ] || prompt_confirm "Shall I upgrade all?"
    then
      brew upgrade
      brew cleanup
    fi
  fi
  echo "[ ${blue}..${reset} ] Running brew doctor"
  brew doctor
}

# print week number based on date or now()
function week {
  if [ "${1}" = "-h" ]
  then
    echo "Usage: week [YYYY-MM-DD]"
    return
  fi

  [ -z "${1}" ] && date +%V || date --date="${1}" +%V
}

# load a local tmuxp config file in a directory by first changing pwd
function tmuxpl {
  # Show usage if no argument is provided
  [ $# -ne 1 ] && echo "Usage: tmuxpl DIR" && return 1
  # If there's a named config, load it
  if [ -f ~/.tmuxp/$1.y*ml ]
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

# vim: set ft=bash: