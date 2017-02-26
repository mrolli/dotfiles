#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed
# using Homebrew.
#
# Check for Homebrew
#
topic_dir=$(dirname $0)
source $topic_dir/../shell_functions.sh

echo ''
info "Installing Homebrew..."
if test ! $(which brew)
then
  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
  success 'Successfully installed Homebrew'.
else
  success 'Skipping Homebrew'
fi

