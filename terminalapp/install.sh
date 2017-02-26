#!/usr/bin/env bash

topic_dir=$(dirname "$0")
source $topic_dir/../shell_functions.sh

echo ''
info "Configuring Terminal.app..."
open "$topic_dir/Dark Background.terminal"
osascript -e 'tell application "Terminal" to close window 0'
defaults write com.apple.Terminal "Default Window Settings" -string "Dark Background"
defaults delete com.apple.Terminal "Startup Window Settings"
success "Successfully configured Terminal.app"

