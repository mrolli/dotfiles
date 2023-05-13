#!/usr/bin/env bash

# Gruvbox dark colors for Tmux

set -g mode-style "fg=#ebdbb2,bg=#3c3836"

set -g message-style "fg=#ebdbb2,bg=#3c3836"
set -g message-command-style "fg=#ebdbb2,bg=#3c3836"

set -g pane-border-style "fg=#3c3836"
set -g pane-active-border-style "fg=#ebdbb2"

set -g status "on"
set -g status-interval 2
set -g status-justify "left"

set -g status-style "fg=#ebdbb2,bg=#3c3836"

set -g status-left-length "100"
set -g status-right-length "160"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#3c3836,bg=#d79921,bold] #S #[fg=#d79921,bg=#3c3836,nobold,nounderscore,noitalics]"

# Status right contents
set -g status-right "#[fg=#d79921,bg=#3c3836,nobold,nounderscore,noitalics]#[fg=#1D202f,bg=#d79921]"
# Add week number and date, show only if not in wezterm
if-shell '[[ "$TERM_PROGRAM" != "WezTerm" ]]' {
  set -ag status-right " KW#(date +%V)  %d.%m.%y  %R "
}
# final section in orang with the hostname
set -ag status-right "#[fg=#fe8019,bg=#d79921,nobold,nounderscore,noitalics]#[fg=#1D202f,bg=#fe8019] #h "

setw -g window-status-activity-style "underscore,fg=#3c3837,bg=#3c3836"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#bdae93,bg=#3c3836"
setw -g window-status-format "#[fg=#3c3836,bg=#3c3836,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#3c3836,bg=#3c3836,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#3c3836,bg=#665c54,nobold,nounderscore,noitalics]#[fg=#ebdbb2,bg=#665c54,bold] #I  #W #F #[fg=#665c54,bg=#3c3836,nobold,nounderscore,noitalics]"
