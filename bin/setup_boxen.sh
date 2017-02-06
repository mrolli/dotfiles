#!/usr/bin/env bash

prompt_confirm() {
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input"
    esac
  done
}

chhostname=1
prompt_confirm "> Do you want me to change the hostname of this machine?" || chhostname=0

if [ $chhostname -eq 1 ]; then
  read -r -p "> Which short hostname should I set? " myhostname
  sudo scutil --set ComputerName "${myhostname}"
  sudo scutil --set HostName "${myhostname}"
  sudo scutil --set LocalHostName "${myhostname}"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${myhostname}"
  echo "Hostname set to ${myhostname}."
fi

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

echo "> xcode-select --install"
if xcode-select --install >/dev/null 2>&1; then
  echo "Choose an option in the dialog to download the command line developer tools."
  echo "Rerun this script after the  installation has finished."
  exit 1
fi
#sudo xcodebuild -license accept

if [ ! -d /opt/boxen/repo ]; then
  echo "> Cloning boxen repo"
  sudo mkdir -p /opt/boxen
  sudo chown ${USER}:staff /opt/boxen
  git clone https://github.com/mrolli/myboxen /opt/boxen/repo
fi

echo "> Boxen is now ready at /opt/boxen/repo."

exit 0


