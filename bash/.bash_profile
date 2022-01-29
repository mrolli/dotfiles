# .bash_profile

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Always append to history instead of overwriting
shopt -s histappend

### Build PATH variable
PATH=/usr/local/sbin:$PATH
PATH=~/.local/bin:$PATH

# Also export HOSTNAME
export HOSTNAME

# Source profile snippets outsourced to their own files
for file in ~/.bash_{colors,exports,aliases,functions}
do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

# ... and write it down after each command
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'} history -a"


# GOPATH initialization
if which go >/dev/null 2>&1
then
   export GOPATH=$HOME/Developer/go
   PATH="${GOPATH/bin}":$PATH
fi


# git-achievements
if [ -d $HOME/.config/git-achieve ]
then
  export GIT_ACHIEVEMENTS_HOME=$HOME/.config/git-achieve
  PATH="${PATH}":"${GIT_ACHIEVEMENTS_HOME}"
  alias git="git-achievements"
fi


# Source fzf related shell configuration and completion
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

# Source a platform specific bash profile if available
[ -f "${HOME}/.bash_profile.$(uname -s)" ] && source "${HOME}/.bash_profile.$(uname -s)"

# Source a local non-versioned bash profile script if available
[ -f "${HOME}/.bash_profile.local" ] && source "${HOME}/.bash_profile.local"


# Finally the prompt now that Homebrew has been added on all platforms
posh_theme=gruvbox
oh-my-posh --version &>/dev/null \
  && eval "$(oh-my-posh --init --shell bash --config ~/.config/oh-my-posh/$posh_theme.omp.json)" \
  || . ~/.bash_prompt


true
# vim: set ft=bash:
