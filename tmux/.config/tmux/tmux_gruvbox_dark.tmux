#!/usr/bin/env bash

# Gruvbox dark colors for Tmux

# default statusbar colors
set-option -g status-style fg=yellow,bg=black #yellow and base02

# default window title colors
set-option -g window-status-style fg=colour7,bg=default

# active window title colors
set-window-option -g window-status-current-style fg=brightred,bg=default,bright #orange and default

# pane border of active pane
set-option -g pane-border-style fg=black
set-option -g pane-active-border-style fg=colour7

# message text
set-option -g message-style fg=brightred,bg=black #orange and base01

# pane number display
set-option -g display-panes-active-colour brightred
set-option -g display-panes-colour  white

# clock
set-option -g clock-mode-colour brightred

# activity and bell style
set-option -g window-status-activity-style fg=black,bg=colour7
set-option -g window-status-bell-style fg=black,bg=colour7

#### Status bar contents
# Status bar design
set-option -g status-justify centre
set-option -g status-interval 2
set-option -g status-left "#[fg=green] #S #[default]"

# Window mode and message style
set-option -g message-style fg=black,bg=yellow

# Window status design
set-option -g window-status-current-format '#[fg=yellow]| #I:#W#F |#[default]'

# enable activity alerts
set-option -g monitor-activity on
set-option -g activity-action other
set-option -g visual-activity off

# Additionally decorate status bar
# add cpu/mem/load to left are
set-option -ag status-left "#(tmux-mem-cpu-load -c -p -q -g 0 -m 2 -i 2)"
set-option -g  status-left-length 70

set-option -g  status-right ""
# add current playing song and the weather locally on my machine
if-shell '[[ $(hostname -s) = rivendell ]]' {
  set-option -ag status-right "#(musicplaying) | "
}
# add the weather
WEATHER='#(curl -m 1 -s wttr.in/Burgdorf\?format\="%%l:+%%c%%20%%t%%20%%w%%20%%m&period=60")'
set-option -ag status-right "$WEATHER | "
# and style the status right area
set-option -ag status-right "%d.%m.%y KW#(date +%V) | %R "
set-option -g  status-right-style fg=colour7
set-option -g  status-right-length 110
