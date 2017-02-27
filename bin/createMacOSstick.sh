#!/usr/bin/env bash

[ $# -ne 2 ] && echo "Usage example: ${0} Sierra /Volumes/Untitled" && exit 1

sudo /Applications/Install\ macOS\ $1.app/Contents/Resources/createinstallmedia --volume "${2}" --applicationpath /Applications/Install\ macOS\ $1.app/ --nointeraction

