#!/usr/bin/env bash

[ $# -ne 1 ] && echo "Usage ${0}: <short hostname>" && exit 1

myhostname=$1

sudo scutil --set ComputerName "${myhostname}"
sudo scutil --set HostName "${myhostname}"
sudo scutil --set LocalHostName "${myhostname}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${myhostname}"

