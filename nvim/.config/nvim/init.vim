set nocompatible
set path+=*
filetype plugin indent on
syntax on

" Declare the mapleader early to avoid surprises
let mapleader = " "

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
Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-signify'   "or? Plug 'airblade/vim-gitgutter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'godlygeek/tabular'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'luochen1990/rainbow'
Plug 'rhysd/committia.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/vim-vsnip'
" LSP, autocompletion, snippets
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'folke/lsp-colors.nvim'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Specific languages related plugins
Plug 'rodjek/vim-puppet', { 'for': ['puppet'] }
Plug 'mrolli/vim-markdown-preview', { 'for': ['markdown'], 'branch': 'temp_delay_option' }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['markdown'] }
Plug 'tpope/vim-sensible'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Make Lua Keymap DSL available before anything doing lua keymappings
runtime plugin/astronauta.vim

" Now load lua stuff
lua require('rollisch')

" Fenced languages in markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby']

" Jump to last cursor position when opening a file, but don't do it when writing a commit log entry
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

" map some specials to unused keys
map ö [
map ä ]
map é \

" additional undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" reload my vimrc
nnoremap <Leader>r :so $MYVIMRC<CR>:call ColorMyPencils()<CR>

" Make file in current buffer executable
nnoremap <Leader>x :silent !chmod +x %<CR>

" Reselect visual block after indent (thx @twe4ked)
vnoremap < <gv
vnoremap > >gv
" Visually move selcted block around (thx @ThePrimeagen)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Exit to normal mode in terminal emulator for non us key layouts
tnoremap <Leader><Esc> <C-\><C-n>

" Window resizing
nnoremap <Leader>+ :resize +5<CR>
nnoremap <Leader>- :resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

" Toggle UI elements
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

" Toggle the colorcolumn
if !exists('*ToggleColorcolumn*')
  function! ToggleColorcolumn()
    if !exists("b:cc_vis") || b:cc_vis
      set colorcolumn=""
      let b:cc_vis=0
    else
      set colorcolumn=120
      let b:cc_vis=1
    endif
  endfunction
endif

" Replace in visual mode
xnoremap <Leader>p "_dP
" Delete to black hole register to save current register content
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
" easy yank to OS clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
" yank whole file
nnoremap <Leader>Y gg"+yG

" Display the undotree panel
nnoremap <leader>u :UndotreeShow<CR>
" Easy reindent
nnoremap <Leader>i gg=G<C-o>

" Map some function keys
nnoremap <F2> :call ToggleUI()<CR>
nnoremap <F3> :set invpaste paste?<CR>
nnoremap <F4> :call ToggleColorcolumn()<CR>

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
