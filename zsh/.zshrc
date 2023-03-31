# history setup
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# initialize autocompletion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# build the PATH variable
PATH=~/Library/Python/3.9/bin/:$PATH
PATH=~/.local/bin:/opt/homebrew/bin:$PATH

# bindings
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

# set exports
export PATH
export GPG_TTY=$(tty)
export EDITOR=nvim

# setup aliases
alias vi="nvim"

eval "$(starship init zsh)"


