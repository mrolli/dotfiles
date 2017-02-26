#!/bin/bash

topic_dir=$(dirname "$0")
source $topic_dir/../shell_functions.sh

echo ''
info "Installing vim plugins found in vimrc..."
if source $topic_dir/plugin_install.sh
then
  success "Successfully installed plugins"
else
  fail "Error installing plugins"
fi

