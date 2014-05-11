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
[ -d nerdtree ] || git clone https://github.com/scrooloose/nerdtree.git
[ -d supertab ] || git clone git://github.com/ervandew/supertab.git
[ -d syntastic ] || git clone https://github.com/scrooloose/syntastic.git
[ -d tabular ] || git clone git://github.com/godlygeek/tabular.git
[ -d vim-airline ] || git clone git://github.com/bling/vim-airline.git
[ -d vim-signify ] || git clone https://github.com/mhinz/vim-signify ~/.vim/bundle/vim-signify
[ -d vim-fugitive ] || git clone git://github.com/tpope/vim-fugitive.git
#[ -d vim-phpcomplete ] || git clone github.com/shawncplus/phpcomplete.vim.git vim-phpcomplete
[ -d vim-puppet ] || git clone git://github.com/rodjek/vim-puppet.git
[ -d vim-sensible ] || git clone git://github.com/tpope/vim-sensible.git
[ -d tlib_vim ] || git clone https://github.com/tomtom/tlib_vim.git # dependancy of snnipmate
[ -d vim-addon-mw-utils ] || git clone https://github.com/MarcWeber/vim-addon-mw-utils.git # dependancy of snnipmate
[ -d vim-snipmate ] || git clone https://github.com/garbas/vim-snipmate.git
[ -d vim-snippets ] || git clone https://github.com/honza/vim-snippets.git
[ -d vim-surround ] || git clone git://github.com/tpope/vim-surround.git
echo -e "\nAll bundles setup.\n"

cd $OLDPWD
exit 0
