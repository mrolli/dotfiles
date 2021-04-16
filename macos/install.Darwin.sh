#!/usr/bin/env bash

topic_dir="$(dirname -- "${0}")"
source "${topic_dir}/../shell_functions.sh"

echo ""
info "Setting up macos..."

chhostname=1
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

chsettings=1
prompt_confirm "Do you want me to change macOS settings now?" || chsettings=0
if [ $chsettings -eq 1 ]
then
  settings_dir="${topic_dir}/settings.d"

  # Kudos to Mathias Bynes, see:
  # ~/.macos — https://mths.be/macos

  # To see all domains available:
  # defaults domains | tr -s ', ' '\n' | less

  # Close any open System Preferences panes, to prevent them from overriding
  # settings we’re about to change
  osascript -e 'tell application "System Preferences" to quit'

  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # Now source every settings domain
  for domain in $(LC_ALL=C command ls "$settings_dir")
  do
    domain_file="${settings_dir}/${domain}"
    [[ -f "$domain_file" && -r "$domain_file" ]] && . "$domain_file"
    success "Configured domain ${domain}."
  done

  for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
             "Dock" "Finder" "Mail" "Messages" "Photos" "Safari" "SystemUIServer" "Terminal" \
             "iCal"
  do
    killall "${app}" &> /dev/null
  done
  success "Done. Note that some of these changes may require a logout/restart to take effect."
fi

success "Successfully configured macOS."

