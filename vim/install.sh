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

# setup bundles
echo "Now setting up bundles..."
cd ~/.vim/bundle
[ -d nerdtree ]     || git clone https://github.com/scrooloose/nerdtree.git
[ -d syntastic ]    || git clone https://github.com/scrooloose/syntastic.git
[ -d supertab ]     || git clone git://github.com/ervandew/supertab.git
[ -d tabular ]      || git clone git://github.com/godlygeek/tabular.git
[ -d vim-airline ]  || git clone git://github.com/bling/vim-airline.git
[ -d vim-airline-themes ] || git clone https://github.com/vim-airline/vim-airline-themes
[ -d vim-signify ]  || git clone https://github.com/mhinz/vim-signify ~/.vim/bundle/vim-signify
[ -d snipmate.vim ] || git clone git://github.com/ervandew/snipmate.vim.git
[ -d snipmate.vim/snippets ] && rm -rf snipmate.vim/snippets # conflicts with below vim-snippets if directory is available
[ -d vim-snippets ] || git clone https://github.com/honza/vim-snippets.git

# tpope stuff
[ -d vim-fugitive ]   || git clone git://github.com/tpope/vim-fugitive.git
[ -d vim-git ]        || git clone git://github.com/tpope/vim-git.git
[ -d vim-markdown ]   || git clone git://github.com/tpope/vim-markdown.git
[ -d vim-repeat ]     || git clone git://github.com/tpope/vim-repeat.git
[ -d vim-sensible ]   || git clone git://github.com/tpope/vim-sensible.git
[ -d vim-surround ]   || git clone git://github.com/tpope/vim-surround.git
[ -d vim-vividchalk ] || git clone git://github.com/tpope/vim-vividchalk.git

# Ruby related
[ -d vim-ruby ]          || git clone git://github.com/vim-ruby/vim-ruby.git
[ -d vim-ruby-debugger ] || git clone git://github.com/astashov/vim-ruby-debugger.git
[ -d vim-rdoc ]          || git clone git://github.com/hallison/vim-rdoc.git
[ -d vim-cucumber ]      || git clone git://github.com/tpope/vim-cucumber.git
[ -d vim-rails ]         || git clone git://github.com/tpope/vim-rails.git
[ -d Gist.vim ]          || git clone git://github.com/vim-scripts/Gist.vim.git

# Puppet related
[ -d vim-puppet ] || git clone git://github.com/rodjek/vim-puppet.git


echo -e "All bundles setup.\n"

cd $OLDPWD
exit 0
