#!/bin/sh

session_name="$(hostname -s)"

tmux has-session -t ${session_name} >/dev/null 2>&1

if [ $? != 0 ]
then
  if [[ "${session_name}" = "rivendell" ]]
  then
    target_dir=$HOME/Developer/ubelix/puppet-installer/controlrepo/site-modules/profile
    # Create the session and implicitly window (0)
    tmux -2 new-session -n puppet -s ${session_name} -d -c $target_dir
    # Split window (0) in 4 panes
    tmux split-window -v -c $target_dir
    tmux split-window -h -c $target_dir
    tmux split-window -h -c $target_dir
    tmux select-layout tiled
    tmux send-keys -t ${session_name}:1.4 'vagrant up service01 puppet puppetdb01 nfs01 lrms01 submit01 anode001' C-m

    target_dir=$HOME/Developer/ubelix/puppet-installer/controlrepo/modules/puppet-module-slurm
    tmux new-window -n slurm -t ${session_name} -c $target_dir
    tmux split-window -v -c $target_dir
    tmux split-window -h -c $target_dir
    tmux split-window -h -c $target_dir

    target_dir=$HOME/.dotfiles
    tmux new-window -n dotfiles -t ${session_name} -c $target_dir
    tmux split-window -h -c $target_dir
    tmux split-window -v -c $target_dir
    tmux select-layout tiled

    target_dir=$HOME
    tmux new-window -n Hams -t ${session_name} -c $target_dir
    tmux split-window -v -c $target_dir
    tmux split-window -h -c $target_dir
    tmux split-window -h -c $target_dir
    tmux select-layout tiled
  fi

  tmux -2 new-session -s ${session_name} -d
  # shell (1)
  #tmux new-window -n bash -t ${session_name}
  #tmux send-keys -t ${session_name}:1 'git status' C-m

  # mysql (2)
  #tmux new-window -n mysql -t ${session_name}
  #tmux send-keys -t ${session_name}:2 'mysql -u <username> <database>' C-m

  # server/debug log (3)
  #tmux new-window -n puppet -t ${session_name}
  #tmux send-keys -t ${session_name}:3 'bundle exec rails s' C-m
  #tmux split-window -v -t ${session_name}:3
  #tmux send-keys -t ${session_name}:3.1 'tail -f log/development.log | grep "DEBUG"' C-m

  # rails console (4)
  #tmux new-window -n console -t ${session_name}
  #tmux send-keys -t ${session_name}:4 'pry -r ./config/environment' C-m

  # Start out on the first window when we attach
  #tmux select-window -t ${session_name}:0
fi
tmux attach -t ${session_name}
