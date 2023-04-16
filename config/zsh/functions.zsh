#!/usr/bin/env bash

# For the confirmation moments in life
prompt_confirm() {
  while true; do
    quest=$(printf "\r[ ${yellow}??${reset} ] ${1:-Continue?} [y/n]: ")
    read "reply?$quest"
    case $reply in
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

  for type in formulae casks; do
    out=$(brew outdated --$type)
    if [ -n "${out}" ]
    then
      echo "[ ${blue}..${reset} ] The following $type are outdated:"
      echo $out
      if [ "${1}" = "-f" ] || prompt_confirm "Shall I upgrade all of them?"
      then
        brew upgrade --$type
        echo "[ ${blue}..${reset} ] Running brew cleanup"
        brew cleanup
      fi
    fi
  done

  echo "[ ${blue}..${reset} ] Running brew doctor"
  brew doctor

  if [ "${1}" = "-f" ] || prompt_confirm "Shall I upgrade AppStore apps?"
  then
    echo "[ ${blue}..${reset} ] Running mas upgrade"
    mas upgrade
  fi
}

# print week number based on date or now()
function week {
  if [ "${1}" = "-h" ]
  then
    echo "Usage: week [YYYY-MM-DD]"
    return
  fi

  # date on macOS does not have the --date option; install coreutils
  # using Homebrew there
  type gdate &>/dev/null && datecmd="gdate" || datecmd="date"

  [ -z "${1}" ] && $datecmd +%V || $datecmd --date="${1}" +%V
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
