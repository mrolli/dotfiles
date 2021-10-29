# .bash_profile

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Always append to history instead of overwriting
shopt -s histappend

### Build PATH variable
PATH=/usr/local/sbin:$PATH
PATH=~/.bin:$PATH

# Also export HOSTNAME
export HOSTNAME

# Source profile snippets outsourced to their own files
for file in ~/.bash_{colors,exports,aliases,functions,prompt}
do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

# ... and write it down after each command
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'} history -a; history -c; history -r"


# GOPATH initialization
if which go >/dev/null 2>&1
then
   export GOPATH=$HOME/Developer/go
   PATH="${GOPATH/bin}":$PATH
fi


# git-achievements
if [ -d $HOME/.git-achieve ]
then
  export GIT_ACHIEVEMENTS_HOME=$HOME/.git-achieve
  PATH="${PATH}":"${GIT_ACHIEVEMENTS_HOME}"
  alias git="git-achievements"
fi


# Source fzf related shell configuration and completion
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

# Source a platform specific bash profile if available
[ -f "${HOME}/.bash_profile.$(uname -s)" ] && source "${HOME}/.bash_profile.$(uname -s)"

# Source a local non-versioned bash profile script if available
[ -f "${HOME}/.bash_profile.local" ] && source "${HOME}/.bash_profile.local"

true
# vim: set ft=bash:
