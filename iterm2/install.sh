#!/usr/bin/env bash

if [ ! -d /Applications/iTerm.app ]; then
  echo "iTerm.app not found. Is it actually installed?"
  exit 1
fi

# This generates a preferences file if none is available
if [ ! -f ~/Library/Preferences/com.googlecode.iterm2.plist ]
then
  if ! (ps aux | grep "[i]Term.app" >/dev/null 2>&1); then
    open /Applications/iTerm.app
  fi
  osascript -e 'tell application "iTerm" to quit'
fi

# Delete all cache dpreferences
defaults delete com.googlecode.iterm >/dev/null 2>&1
# Copy saved preferences to right place
cp  ~/.dotfiles/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/
# Reread preferences into cache
defaults read -app iterm >/dev/null

exit 0

