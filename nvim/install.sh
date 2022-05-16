#!/usr/bin/env bash

# Some tools that are used under the hood
brew install fd npm ripgrep

# Python 3
brew install python@3.9
python3 -m pip install --user --upgrade pynvim

# Ruby support
sudo gem install neovim

# NPM support
npm install -g neovim
