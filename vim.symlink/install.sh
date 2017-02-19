#!/bin/bash

# setup pathogen first if not yet installed
echo -n "Setting up Vundle... "
if [ -d ~/.vim/bundle/Vundle.vim ];
then
    echo "already setup - skip."
else
    mkdir -p ~/.vim/bundle ~/.vim/colors
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim >/dev/null 2>&1
    echo "done."
fi

# Let Vundle do the heavy lifting
echo -n "Installing specified plugins... "
vim +PluginInstall +qall
echo "done."

exit 0

