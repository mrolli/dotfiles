# This file contains stuff that is specific for macOS

# Do not archive resoruce forks when using system tar
export COPYFILE_DISABLE=true

# Python packages installed using OS Python binary Make sure they are available
# in PATH
[ -x "$HOME/Library/Python/3.9/bin" ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# On arm64 platform Homebrew is not automatically in PATH
if ! commanmd -v brew &>/dev/null && [ -x /opt/homebrew/bin/brew ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Initialize Homebrew for all platforms here
command -v brew &>/dev/null && eval "$(brew shellenv)"

# Make the lateest ruby version installed with brew the default
[ -d "$HOMEBREW_PREFIX/opt/ruby/bin" ] &&
  export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"

# Use a keg-only version of PHP
if [ -d "$HOMEBREW_PREFIX/opt/php@8.3/bin" ]; then
  export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
  export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"
fi

# Add binary path of libpq if available
[ -d "$HOMEBREW_PREFIX/opt/libpq/bin" ] && PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"

[ -f "$HOME/.vagrant.d/vcloud_token.sh" ] && source "$HOME/.vagrant.d/vcloud_token.sh"
