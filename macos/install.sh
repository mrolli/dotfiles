#!/usr/bin/env bash

topic_dir=$(dirname $0)
source $topic_dir/../shell_functions.sh

doupdate=1
echo ''
prompt_confirm "Do you want me to run softwareupdate?" || doupdate=0
if [ $doupdate -eq 1 ]
then
  # Invoke softwareupdate from CLI
  info "sudo softwareupdate -i -a"
  sudo softwareupdate -i -a
fi

chhostname=1
echo ''
prompt_confirm "Do you want me to change the hostname of this machine?" || chhostname=0
if [ $chhostname -eq 1 ]
then
  user "Which short hostname should I set? "
  read -r myhostname
  sudo scutil --set ComputerName "${myhostname}"
  sudo scutil --set HostName "${myhostname}"
  sudo scutil --set LocalHostName "${myhostname}"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${myhostname}"
  success "Hostname set to ${myhostname}."
fi

