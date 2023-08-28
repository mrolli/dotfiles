#!/usr/bin/env zsh

# Initialize and configure autocompletion
# Guide about style: https://thevaluable.dev/zsh-completion-guide-examples/
if command -v brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
  FPATH="$ZDOTDIR/zsh-completions:${FPATH}"
fi

autoload -U compinit && compinit -d $ZCACHEDIR/zcompdump
_comp_options+=(globdots) # with hidden files
zstyle ':completion:*' completer _extensions _complete
#zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
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

if command -v op &>/dev/null 2>&1; then
  eval "$(op completion zsh)"; compdef _op op
fi

if command -v wezterm &>/dev/null 2>&1; then
  eval "$(wezterm shell-completion --shell zsh)"
fi

if command -v az &>/dev/null 2>&1; then
  autoload bashcompinit && bashcompinit
  source $(brew --prefix)/etc/bash_completion.d/az
fi

if command -v terraform &>/dev/null 2>&1; then
  complete -C /usr/local/bin/terraform terraform
fi
