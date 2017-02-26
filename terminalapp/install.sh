#!/usr/bin/env bash

topicpath=$(dirname $0)

open "$topicpath/Dark Background.terminal"
osascript -e 'tell application "Terminal" to close window 0'
defaults write com.apple.Terminal "Default Window Settings" -string "Dark Background"
defaults delete com.apple.Terminal "Startup Window Settings"

