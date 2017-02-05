#!/usr/bin/env bash

cd ~
# Link in files, replacing whatever's already there.
ln -fs ".dotfiles/bash/bashrc"                "${HOME}/.bashrc"
ln -fs ".dotfiles/bash/bash_profile"          "${HOME}/.bash_profile"
ln -fs ".dotfiles/git/gitconfig"              "${HOME}/.gitconfig"
ln -fs ".dotfiles/git/gitmessage"             "${HOME}/.gitmessage"
ln -fs ".dotfiles/git/gitignore_global"       "${HOME}/.gitignore_global"
ln -fs ".dotfiles/tmux/tmux.conf"             "${HOME}/.tmux.conf"
ln -fs ".dotfiles/vim/vimrc"                  "${HOME}/.vimrc"

# Link in directories, removing whatever's already there first.
[[ -e "${HOME}/.vim" ]] && rm -r "${HOME}/.vim"
ln -fs ".dotfiles/vim" "${HOME}/.vim"

# Finally setup vim plugins and color schemes
~/.vim/setup_vim_env.sh
