#!/usr/bin/env bash

topic_dir=$(dirname $0)
source $topic_dir/../shell_functions.sh

# Invoke softwareupdate from CLI
echo ''
info "sudo softwareupdate -i -a"
sudo softwareupdate -i -a

