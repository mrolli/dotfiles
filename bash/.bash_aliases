#!/usr/bin/env bash

# shortcuts to upper dirs... give it a try
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Alias vi to nvim as Homebrew manages vi to be a symlink to
# vim as long vim is still installed
alias vi='nvim'

# Detect which `ls` flavor is in use
# https://geoff.greer.fm/lscolors/
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color=auto"
  export LS_COLORS='di=1;33:ln=36:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:or=40;31;07'
else # macOS `ls`
  colorflag="-G"
  export LSCOLORS='Dxfxcxdxbxegedabagacad'
fi

# Colored ls output but on stdout only
# Additionally make sure not aliasing alias by using command here
alias ls="command ls ${colorflag}"

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

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

# shorcut to screen locking (= ctrl-cmd q)
alias afk=$'osascript -e \'tell application "System Events" to key code 12 using {control down, command down}\''

# IP addresses
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the on the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Some weather forecast aliases, because fun
alias wetter_burgdorf='curl http://wttr\.in/burgdorf'
alias wetter_bern='curl http://wttr\.in/bern'
alias wetter_burgdorf2='curl http://v2.wttr\.in/burgdorf'
alias wetter_bern2='curl http://v2.wttr\.in/bern'

# To easyily use brave from the CLI
alias brave="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

# unset variables set in this file
unset colorflag

# vim: set ft=bash:
