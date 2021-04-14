#!/bin/sh

SESSION_NAME="puppet"

tmux has-session -t ${SESSION_NAME}

if [ $? != 0 ]
then
  # Create the session
  tmux -2 new-session -n puppet -s ${SESSION_NAME} -d
  tmux send-keys -t ${SESSION_NAME} 'cd ~/Developer/puppet-id/puppet/puppetenv' C-m
  tmux send-keys -t ${SESSION_NAME} 'vagrant ssh master' C-m
  tmux send-keys -t ${SESSION_NAME} 'sudo su -' C-m

  tmux split-window -v -t ${SESSION_NAME}
  tmux send-keys -t ${SESSION_NAME} 'cd ~/Developer/puppet-id/puppet/puppetenv' C-m

  tmux select-pane -t 1
  tmux split-window -h -t ${SESSION_NAME}
  tmux send-keys -t ${SESSION_NAME} 'cd ~/Developer/puppet-id/puppet/puppetenv' C-m
  tmux send-keys -t ${SESSION_NAME} 'vagrant ssh service' C-m
  tmux send-keys -t ${SESSION_NAME} 'sudo su -' C-m

  tmux select-pane -t 3
  tmux split-window -h -t ${SESSION_NAME}
  tmux send-keys -t ${SESSION_NAME} 'cd ~/Developer/puppet-id/puppet/puppetenv' C-m
  tmux send-keys -t ${SESSION_NAME} 'vagrant ssh hnode02' C-m
  tmux send-keys -t ${SESSION_NAME} 'sudo su -' C-m

  tmux set-window-option -t ${SESSION_NAME} synchronize-panes on
  tmux send-keys -t ${SESSION_NAME} 'clear' C-m
  tmux set-window-option -t ${SESSION_NAME} synchronize-panes off

  tmux select-pane -t 3

  # First window (0) -- vim and console
  #tmux send-keys -t ${SESSION_NAME} 'vim' C-m

  # shell (1)
  #tmux new-window -n bash -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:1 'git status' C-m

  # mysql (2)
  #tmux new-window -n mysql -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:2 'mysql -u <username> <database>' C-m

  # server/debug log (3)
  #tmux new-window -n puppet -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:3 'bundle exec rails s' C-m
  #tmux split-window -v -t ${SESSION_NAME}:3
  #tmux send-keys -t ${SESSION_NAME}:3.1 'tail -f log/development.log | grep "DEBUG"' C-m

  # rails console (4)
  #tmux new-window -n console -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:4 'pry -r ./config/environment' C-m

  # Start out on the first window when we attach
  #tmux select-window -t ${SESSION_NAME}:0
fi
tmux attach -t ${SESSION_NAME}
