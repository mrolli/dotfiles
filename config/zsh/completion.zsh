#!/usr/bin/env zsh

# Initialize and configure autocompletion
# Guide about style: https://thevaluable.dev/zsh-completion-guide-examples/

# Load Homebrew featured completions if available
if [ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]
then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi

autoload -U compinit && compinit -d $ZCACHEDIR/zcompdump

# Replay recored compdef calls
zinit cdreplay -q

_comp_options+=(globdots) # with hidden files
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _extensions _complete
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' rehash true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Activate 1password autocompletion if 1password is avaialble
if command -v op &>/dev/null; then
  eval "$(op completion zsh)"; compdef _op op
fi

# Activate wezterm autocompletion if wezterm is avaialble
if command -v wezterm &>/dev/null; then
  eval "$(wezterm shell-completion --shell zsh)"
fi

# Active fzf autocompletion and shell integration
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi

# Activate azure autocompletion if az is avaialble
if command -v az &>/dev/null; then
  autoload autload -U +X bashcompinit && bashcompinit && \
  source $HOMEBREW_PREFIX/etc/bash_completion.d/az
fi

# Activate terraform autocompletion if terraform is avaialble
if command -v terraform &>/dev/null; then
  complete -C "$(command -v terraform)" terraform
fi

# Activate packer autocompletion if packer is avaialble
if command -v packer &>/dev/null; then
  complete -C "$(command -v packer)" packer
fi
