#!/bin/bash

topic_dir=$(dirname "$0")
source $topic_dir/../shell_functions.sh

echo ''
info "Installing vim plugins found in vimrc"
$topic_dir/plugin_install.sh
success "All plugins successfully installed"

exit 0

