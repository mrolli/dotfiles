#!/usr/bin/env zsh
# This file contains stuff that is specific for macOS

# Python packages installed using OS Python binary Make sure they are available
# in PATH
[ -x "$HOME/Library/Python/3.9/bin" ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# On arm64 platform Homebrew is not automatically in PATH
if ! commanmd -v brew &>/dev/null && [ -x /opt/homebrew/bin/brew ]
then
    export PATH="/opt/homebrew/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Initialize Homebrew for all platforms here
command -v brew &>/dev/null && eval "$(brew shellenv)"

[ -f "$HOME/.vagrant.d/vcloud_token.sh" ] && source "$HOME/.vagrant.d/vcloud_token.sh"
