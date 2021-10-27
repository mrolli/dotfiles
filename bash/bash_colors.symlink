#!/usr/bin/env bash

if tput setaf 1 &> /dev/null
then
  bold=$(tput bold)
  reset=$(tput sgr0)
  # Solarized colors, taken from http://git.io/solarized-colors.
  aqua=$(tput setaf 72)
  black=$(tput setaf 0)
  blue=$(tput setaf 4)
  fg=$(tput setaf 223)
  green=$(tput setaf 2)
  orange=$(tput setaf 166)
  purple=$(tput setaf 5)
  red=$(tput setaf 1)
  yellow=$(tput setaf 11)
else
  bold=''
  reset="\e[0m"
  aqua="\e[1;35m"
  black="\e[1;30m"
  blue="\e[1;34m"
  fg="\e[1;37m"
  green="\e[1;32m"
  orange="\e[1;33m"
  purple="\e[1;35m"
  red="\e[1;31m"
  yellow="\e[1;33m"
fi

# vim: set ft=bash:
