#!/usr/bin/env zsh

# Alias vi to nvim as Homebrew manages vi to be a symlink to
# vim as long vim is still installed
alias vi="\$EDITOR"

# List all files colorized in long format
alias l="ls -lF"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF"

# List only directories
alias lsd="ls -lF | grep --color=never '^d'"

# Always enable colore *grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable simple aliases to be sudo'ed. ("sudone"?)
# http://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias sudo='sudo ';

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'

# shorcut to screen locking (= ctrl-cmd q)
alias afk=$'osascript -e \'tell application "System Events" to key code 12 using {control down, command down}\''

# IP addresses
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# Some weather forecast aliases, because fun
alias wetter_burgdorf='curl http://wttr\.in/burgdorf'
alias wetter_bern='curl http://wttr\.in/bern'
alias wetter_burgdorf2='curl http://v2.wttr\.in/burgdorf'
alias wetter_bern2='curl http://v2.wttr\.in/bern'

# All tldr pages with fzf preview
alias tldrf='tldr --list | fzf --preview "tldr {1}" --preview-window=right,60% | xargs tldr'

# Quicliy conect to a VM
alias vssh='vagrant ssh'

# Some GitHub copilot aliases if gh is available
if command -v gh &> /dev/null
then
  if ! gh extension list | grep -q "github/gh-copilot"; then
    gh extension install github/gh-copilot
  fi
  eval "$(gh copilot alias -- zsh)"
  alias \?\?="ghcs -t shell"
  alias git\?="ghcs -t git"
  alias gh\?="ghcs -t gh"
  alias ghe="GH_HOST=github.unibe.ch gh"
fi
