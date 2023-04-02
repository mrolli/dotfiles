#!/usr/bin/env zsh
# This file contains stuff that is specific for macOS

# User installed packages using OS Make sure installed python packages avallable in PATH
[ -x "$HOME/Library/Python/3.9/bin" ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# On amd64 Homebrew is now installed in /opt and not automatically available!
if ! type brew &>/dev/null && [ -x /opt/homebrew/bin/brew ]
then
    export PATH="/opt/homebrew/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Vagrant/Packer specific
export PACKER_CACHE_DIR=$HOME/.cache/packer_cache
[ -f $HOME/.vagrant.d/vcloud_token.sh ] && source $HOME/.vagrant.d/vcloud_token.sh
