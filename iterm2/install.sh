#!/usr/bin/env bash

topic_dir=$(dirname "$0")
prefs=~/Library/Preferences/com.googlecode.iterm2.plist

source $topic_dir/../shell_functions.sh

echo ''
info 'Configuring iterm2...'

if [ ! -d /Applications/iTerm.app ]; then
  fail 'iterm2 not found'
  exit 1
fi

# This generates a preferences file if none is available
if [ ! -f $prefs ]
then
  if ! (ps aux | grep "[i]Term.app" >/dev/null 2>&1); then
    open /Applications/iTerm.app
  fi
  osascript -e 'tell application "iTerm" to quit'
fi

# Delete all cache dpreferences
defaults delete com.googlecode.iterm >/dev/null 2>&1
# Copy saved preferences to right place
cp  $topic_dir/com.googlecode.iterm2.plist $prefs
# Reread preferences into cache
defaults read -app iterm >/dev/null
success "Successfully configured iterm2"

