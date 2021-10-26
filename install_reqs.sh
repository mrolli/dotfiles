#!/usr/bin/env bash

# Python 2
target=/tmp/get-pip.py
curl -O https://bootstrap.pypa.io/pip/2.7/get-pip.py -o $target
python2 $target
rm $target
python2 -m pip install --upgrade "pip < 21.0"
python2 -m pip install --user --upgrade pynvim

# Python 3
brew install python@3.9
python3 -m pip install --user --upgrade pynvim

# Ruby support
sudo gem install neovim

# NPM support
npm install -g neovim
