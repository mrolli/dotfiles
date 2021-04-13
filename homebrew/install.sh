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
if ! command -v brew >/dev/null 2>&1
then
  # Install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  success 'Successfully installed Homebrew'.
else
  success 'Skipping Homebrew, already installed'
fi

echo ""
info "Running brew bundle..."
brewfile="Brewfile.$(uname)"
if [ -f "${brewfile}" ]
then
  info "  - found ${brewfile}"
  brew bundle --file $brewfile
else
	info "  - no Brewfile found"
fi

# Install newer bash on macOS
if test "$(uname)" = "Darwin"
then
  # Switch to using brew-installed bash as default shell
  brew_prefix=$(brew --prefix)
  if [ -x "${brew_prefix}/bin/bash" ]
  then
    echo ""
    info "Found newer bash shell, replacing default shell"
    # Add the new bash to /etc/shells
    if ! fgrep -q "${brew_prefix}/bin/bash" /etc/shells
    then
      echo "${brew_prefix}/bin/bash" | sudo tee -a /etc/shells
    fi
    # Change default shell if needed
    curShell=$(dscl . -read ~/ UserShell | cut -d" " -f 2)
    if [ "$curShell" != "${brew_prefix}/bin/bash" ]
    then
      chsh -s "${brew_prefix}/bin/bash"
      success "Default shell set to ${brew_prefix}/bin/bash"
    else
      success "Default shell already set to ${brew_prefix}/bin/bash"
    fi
  fi
fi
