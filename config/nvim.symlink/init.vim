set nocompatible
filetype plugin indent on
syntax on

" Install vim-pug if not available
let g:vim_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(g:vim_plug_path))
  execute 'silent !curl -flo ' . g:vim_plug_path . ' --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Declare the list of plugins.
Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
Plug 'rhysd/committia.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/limelight.vim'
Plug 'rodjek/vim-puppet'
Plug 'hpc-unibe-ch/vim-markdown-preview', { 'branch': 'temp_delay_option' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
colorscheme gruvbox
" Make comments italic
hi Comment cterm=italic
" Enable and style the cursor line
set cursorline
hi Cursorline cterm=bold ctermbg=8 ctermfg=none

"if &term =~ '256color'
"  disable Background Color Erase (BCE) so that color schemes
"  render properly when inside 256-color tmux and GNU screen.
"  see also http://snk.tuxfamily.org/log/vim-256color-bce.html
" set t_ut=
"endif

" change the mapleader to something more convenient on a sg keyboard
let mapleader = ","

set encoding=utf-8             " Default encoding
set ts=4 sw=4 sts=4 et si ai   " Indentation to 4, expandtab, smartindent and autoindent
set cindent                    " recommended seting for automatic C-style indentation
set exrc                       " Automatically source local vimrcs
set laststatus=2               " Always display the status line
set showtabline=2              " Always display the tabs line
set guicursor=                 " Normal cursor, not just a vertical line
set number                     " Show line numbers
set relativenumber             " Show relative line numbers by default
set scrolloff=8                " Scroll that many lines if cursor leaves viewport
set sidescrolloff=7            " Dito for horizontal scrolling
set noerrorbells               "
set history=1000               " Store lots of :cmdline history
set hlsearch                   " Highlight searches by default
set incsearch                  " Find the next match as we type the search
set ignorecase                 " Make search case insensitive
set smartcase                  " but do case senstiive search when I use capital letters in seach word
set hidden                     " Keep buffers hidden when not displayed instead off abandon them
"set nowrap                    " Do not wrap long lines, this forces me to think about long lines
set linebreak                  " Wrap lines at convenient points
set showcmd                    " Show incomplete cmds down the bottom
set noshowmode                 " Do not show current mode down the bottom; already shown by lightline
set showmatch                  " Set show matching parenthesis
set signcolumn=yes             " Always show the signcolumn
"set colorcolumn=80             " Highlight column 80
"set wildmode=list:longest      " make cmdline tab completion similar to bash
"set wildmenu                   " enable ctrl-n and ctrl-p to scroll thru matches
"set wildignore=*.o,*.obj,*~    " stuff to ignore when tab completing
set nobackup                   " No backup files
set noswapfile                 " No swap files
set undofile                   " Write undo history
if has('nvim')
  set undodir=~/.local/share/nvim/undo
else
  set undodir=~/.vim/undofiles
endif

" Make tabs visible
set listchars=tab:▶\  " show a symbol for tabs and set colors on next line
highlight SpecialKey ctermfg=white ctermbg=9 guibg=#FF0000

" Indentation settings for certain filetypes
" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Force markdown for all files with md extension
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Fenced languages in markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'puppet']

" Jump to last cursor position when opening a file, but dont do it when writing a commit log entry
if !exists('*SetCursorPosition')
  function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
      if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g`\""
        normal! zz
      endif
    end
  endfunction
endif
autocmd BufReadPost * call SetCursorPosition()

" Don't add the comment prefix when I hit enter or o/O on a comment line.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" fast edit my vimrc
nnoremap <Leader>v :e $MYVIMRC<cr>

" Reselect visual block after indent (thanks @twe4ked)
vnoremap < <gv
vnoremap > >gv

" Signify shortcuts
if !exists('*ToggleUI*')
  function! ToggleUI()
    if !exists("b:ui_is_on") || b:ui_is_on
      :SignifyToggle
      set nu! rnu! signcolumn=no
      let b:ui_is_on=0
    else
      set nu! rnu! signcolumn=yes
      :SignifyToggle
      let b:ui_is_on=1
    endif
  endfunction
endif

" Easy show diff
nmap <leader>d :SignifyHunkDiff<CR>
" Easy reindent
nmap <leader>i gg=G<C-o><C-o>

" Funciton keys
nnoremap <F2> :buffers<CR>:buffer<Space>
nnoremap <F3> :call ToggleUI()<CR>
nnoremap <F4> :set invpaste paste?<CR>

" Highlight column of current cursor position
nnoremap <silent><Leader>mm
      \ :let &colorcolumn = &colorcolumn == 0 ?
      \ virtcol('.') : virtcol('.').",".&colorcolumn <cr>

" Remove column highlights again
nnoremap <silent><Leader>mr
      \ :let &colorcolumn =
      \ &colorcolumn[0:1] == 0  ? join(range(81,240),",") :
      \ &colorcolumn[0:1] == 81 ? join(range(121,384),",") :
      \ 0<cr>

" Quick access to tabs
nmap <leader>1 <Plug>lightline#bufferline#go(1)
nmap <leader>2 <Plug>lightline#bufferline#go(2)
nmap <leader>3 <Plug>lightline#bufferline#go(3)
nmap <leader>4 <Plug>lightline#bufferline#go(4)
nmap <leader>5 <Plug>lightline#bufferline#go(5)
nmap <leader>6 <Plug>lightline#bufferline#go(6)
nmap <leader>7 <Plug>lightline#bufferline#go(7)
nmap <leader>8 <Plug>lightline#bufferline#go(8)
nmap <leader>9 <Plug>lightline#bufferline#go(9)
nmap <leader>0 <Plug>lightline#bufferline#go(10)
