# Aliases definitions

# Alias vi to nvim as Homebrew manages vi to be a symlink to
# vim as long vim is still installed
alias vi="\$EDITOR"

# Use eza instead of ls if available
if command -v eza &>/dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias la="eza -a --icons --group-directories-first"
  alias ld="eza -D -a --icons"
  alias ll="eza -lah --icons --git --group-directories-first"
  alias lt="eza --tree --level=2 --icons"
  alias tree="eza --tree --icons"
fi

# Always enable colore *grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use bat by default for cat if available
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
fi

# Enable simple aliases to be sudo'ed. ("sudone"?)
# http://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias sudo='sudo '

# Because we all forget sudo
alias pls='sudo !!'

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

# Some GitHub copilot aliases if gh is available
if command -v gh &>/dev/null; then
  alias ghe="GH_HOST=github.unibe.ch gh"
fi

alias devup="devcontainer up --mount type=bind,source=/Users/mrolli/.gnupg,target=/home/vscode/.gnupg --dotfiles-repository https://github.com/mrolli/dotfiles --dotfiles-install-command setup_devcontainer.sh --workspace-folder ."
alias devrm="docker rm \$(docker ps -q) -f"
alias devcon="devcontainer exec --workspace-folder . --remote-env \"GH_TOKEN=\$(gh auth token)\" zsh"

alias tfp="terraform plan"
alias tfpp="terraform plan -out tfplan"
alias tfa="terraform apply -auto-approve"
alias tfap="terraform apply -auto-approve tfplan"
