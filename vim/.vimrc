" be iMproved
set nocompatible
set path+=*
filetype plugin indent on
syntax on

" Install vim-plug if not yet available
let g:vim_plug_path = has('nvim') ? stdpath('data') . '/site/autoload/plug.vim' : '~/.vim/autoload/plug.vim'
if empty(glob(g:vim_plug_path))
  execute 'silent !curl -flo ' . g:vim_plug_path . ' --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Declare the list of plugins.
" General Plugins
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'godlygeek/tabular'
Plug 'mhinz/vim-signify'
Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tmhedberg/SimpylFold'
Plug 'preservim/tagbar'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'luochen1990/rainbow'
" Additional text objects and motions
Plug 'michaeljsmith/vim-indent-object'
" UltiSnips & Co
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Coding specific
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'rodjek/vim-puppet'
Plug 'fatih/vim-go'
Plug 'mzlogin/vim-markdown-toc'
Plug 'JamshedVesuna/vim-markdown-preview'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"
" Brief help
" :PlugInstall      - installs plugins
" :PluginUpdate     - update the available plugins
" :PluginClean      - confirms removal of unused plugins
"
"change leader to something more
"convenient on a sg keyboard
let mapleader = ","

"setup color scheme
"turn on syntax highlighting
syntax enable
set background=dark
"let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized8

" always display status line
set laststatus=2

source $HOME/.vim/config/ale.vim
source $HOME/.vim/config/editorconfig.vim
source $HOME/.vim/config/indentline.vim
source $HOME/.vim/config/lightline.vim
source $HOME/.vim/config/markdown-preview.vim
source $HOME/.vim/config/nerdtree.vim
source $HOME/.vim/config/rainbow.vim
source $HOME/.vim/config/signify.vim
source $HOME/.vim/config/ultisnips.vim
source $HOME/.vim/config/vim-better-whitespace.vim

set showcmd                    " show incomplete cmds down the bottom
set noshowmode                 " do not show current mode down the bottom; already shown by lightline
set showmatch                  " set show matching parenthesis
set number                     " show line numbers
set relativenumber             " show relative line numbers by default
set scrolloff=3                " scroll that many lines if cursor leaves viewport
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000               " store lots of :cmdline history
set incsearch                  " find the next match as we type the search
set hlsearch                   " hilight searches by default
set ignorecase                 " ignore case when searching
set wrap                       " dont wrap lines
set linebreak                  " wrap lines at convenient points
set wildmode=list:longest      " make cmdline tab completion similar to bash
set wildmenu                   " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~    " stuff to ignore when tab completing

" Swap files in a central location, no swap files amongst project.
set backupdir=~/.vim/swap//
set directory=~/.vim/swap//
set undodir=~/.vim/undofiles//
set undofile
set noswapfile

" Make sure these directories exist
if isdirectory(expand('~/.vim/swap')) == 0
  :silent !mkdir /.vim/swap
endif

if isdirectory(expand('~/.vim/undofiles')) == 0
  :silent !mkdir ~/.vim/undofiles
endif

" Default to Unicode/UTF-8 rather than latin1
set encoding=utf-8

" Default indentation settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smarttab
set autoindent
set cindent           " recommended seting for automatic C-style indentation
set listchars=tab:▶\  " show a symbol for tabs and set colors on next line
highlight SpecialKey ctermfg=white ctermbg=9 guibg=#FF0000

" Indentation settings for certain filetypes
" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" some key assignments
nnoremap <F2> :SignifyToggle<CR>:set invnu<CR>
nnoremap <F3> :set invpaste paste?<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

"folding settings
set foldmethod=indent   "fold based on indent
set foldlevel=99        "open all folds
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
" toggle code fold with space
nnoremap <space> za

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"some stuff to get the mouse going in term
"set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

" Force markdown for all files with md extension
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Fenced languages in markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'puppet']

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

" Don't add the comment prefix when I hit enter or o/O on a comment line.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Split window behaviour
set splitbelow
set splitright

" Split windows navigation
" Arrow keys navigation
nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>
" VIM movement keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Reselect visual block after indent (thanks @twe4ked)
vnoremap < <gv
vnoremap > >gv

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" TexLive stuff
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

