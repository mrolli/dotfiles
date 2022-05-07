#!/usr/bin/env bash

# TokyoNight colors for Tmux

set -g mode-style "fg=#7aa2f7,bg=#3b4261"

set -g message-style "fg=#7aa2f7,bg=#3b4261"
set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#7aa2f7"

set -g status "on"
set -g status-interval 2
set -g status-justify "left"

set -g status-style "fg=#7aa2f7,bg=#1f2335"

set -g status-left-length "100"
set -g status-right-length "140"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#1D202F,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1f2335,nobold,nounderscore,noitalics]"

set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335]"
# Only on my macOS
if-shell '[[ $(uname -s) = "Darwin" ]]' {
  # Add current playing song
  set -ag status-right "#(musicplaying) "
  # Add the weather
  WEATHER='#(curl -m 1 -s wttr.in/Burgdorf\?format\="%%l:+%%c%%20%%t%%20%%w%%20%%m&period=60")'
  set -ag status-right "#[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] $WEATHER "
  set -ag status-right "#[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1D202f,bg=#7aa2f7]"
}

# All other machines
if-shell '[[ $(uname -s) != "Darwin" ]]' {
  set -ag status-right "#[fg=#7aa2f7,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#1D202f,bg=#7aa2f7]"
}
# Add week number and date
set -ag status-right " KW#(date +%V)  %d.%m.%y  %R "
# new section
set -ag status-right "#[fg=#e0af68,bg=#7aa2f7,nobold,nounderscore,noitalics]#[fg=#1D202f,bg=#e0af68]"
# Add the hostname
set -ag status-right " #h "

setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#1f2335"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#a9b1d6,bg=#1f2335"
setw -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"

