#!/bin/bash

# setup pathogen first if not yet installed
echo "Setting up pathogen..."
if [ -f ~/.vim/autoload/pathogen.vim ];
then
    echo -e "... already setup - skip.\n"
else
    mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors
    curl -LSso ~/.vim/autoload/pathogen.vim \
        https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
    echo -e "... done.\n"
fi

# setup color schemes
echo "Now setting up color schemes..."
cd ~/.vim/colors
[ -f bubblegum.vim ] || curl -OSs https://raw.githubusercontent.com/baskerville/bubblegum/master/colors/bubblegum.vim
[ -f jellybeans.vim ] || curl -OSs https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
[ -f wombat.vim ] || curl -OSs https://raw.githubusercontent.com/vim-scripts/Wombat/master/colors/wombat.vim
[ -f wombat256mod.vim ] || curl -OSs https://raw.githubusercontent.com/vim-scripts/wombat256.vim/master/colors/wombat256mod.vim
echo -e "... done.\n"

# setup bundles
echo "Now setting up bundles..."
cd ~/.vim/bundle
[ -d nerdtree ]     || git clone https://github.com/scrooloose/nerdtree.git
[ -d syntastic ]    || git clone https://github.com/scrooloose/syntastic.git
[ -d supertab ]     || git clone git://github.com/ervandew/supertab.git
[ -d tabular ]      || git clone git://github.com/godlygeek/tabular.git
[ -d vim-airline ]  || git clone git://github.com/bling/vim-airline.git
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
