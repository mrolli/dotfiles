#!/bin/sh
#
# Installs Homebrew and all dependencies from Brewfile if
# one is found for the architecture.
#
# On macOS the script also changes the user's default
# shell if bash got installed by Homebrew.
#
topic_dir=$(dirname $0)
source $topic_dir/../shell_functions.sh

echo ""
info "Installing Homebrew..."
if ! type brew >/dev/null 2>&1
then
  # Install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  success 'Successfully installed Homebrew'.
else
  success 'Skipping Homebrew, already installed'
fi

brewfile="${topic_dir}/../Brewfile.$(uname)"
if [ -f "${brewfile}" ]
then
  echo ""
  info "Running brew bundle --file ${brewfile}"
  brew bundle --file $brewfile
fi

# Install newer bash on macOS
if test "$(uname)" = "Darwin"
then
  # Switch to using brew-installed bash as default shell
  BREW_PREFIX=$(brew --prefix)
  if [ -x "${BREW_PREFIX}/bin/bash" ]
  then
    echo ""
    info "Found Homebrew found, replacing default shell"
    # Add the new bash to /etc/shells
    if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells
    then
      echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
    fi
    # Change default shell if needed
    curShell=$(dscl . -read ~/ UserShell | cut -d" " -f 2)
    if [ "$curShell" != "${BREW_PREFIX}/bin/bash" ]
    then
      chsh -s "${BREW_PREFIX}/bin/bash"
      success "Default shell set to ${BREW_PREFIX}/bin/bash"
    else
      success "Default shell already set to ${BREW_PREFIX}/bin/bash"
    fi
  fi
fi
