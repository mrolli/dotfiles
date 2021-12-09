set encoding=utf-8                 " Default encoding
set ts=4 sw=4 sts=4 et sta si ai   " Indentation to 4, expandtab, smarttab,smartindent and autoindent
set exrc                           " Automatically source local vimrcs
set laststatus=2                   " Always display the status line
set showtabline=2                  " Always display the tab line
set guicursor=                     " Normal cursor, not just a vertical line
set number                         " Show line numbers
set relativenumber                 " Show relative line numbers by default
set scrolloff=2                    " Scroll that many lines if cursor leaves viewport
set sidescrolloff=7                " Dito for horizontal scrolling
set noerrorbells                   " No beeps and bleeps please
set history=1000                   " Store lots of :cmdline history
set hlsearch                       " Highlight searches by default
set incsearch                      " Find the next match as we type the search
set ignorecase                     " Make search case insensitive
set smartcase                      " but do case senstiive search when I use capital letters in seach word
set hidden                         " Keep buffers hidden when not displayed instead off abandon them
set nowrap                         " Do not wrap long lines, this forces me to think about long lines
set linebreak                      " Wrap lines at convenient points
set list                           " Enable list mode
set listchars=tab:\ →              " Show a symbol for tabs
"set listchars+=eol:↲               " Show the end of a line
set showcmd                        " Show incomplete cmds down the bottom
set noshowmode                     " Do not show current mode down the bottom; already shown by lightline
set showmatch                      " Set show matching parenthesis
set signcolumn=yes                 " Always show the signcolumn
set cursorline                     " Display the cursorline
set colorcolumn=80                 " Highlight column 80
set cmdheight=1                    " Height of the command line

" Completion menu options
set completeopt=menu,menuone,noinsert,noselect
set shortmess+=c

" Enable enhanced mode of command line completion
set wildmode=longest,full
set wildmenu
" Ignore files
set wildignore+=*.o
set wildignore+=*.obj
set wildignore+=*~

" Folding related settings
set nofoldenable               " Don't fold by default
"set foldmethod=indent          " Fold based on indent
set foldlevel=99               " Open all folds
set foldnestmax=3              " Deepest fold is 3 levels

" Speical files handling
set nobackup                   " No backup files
set noswapfile                 " No swap files
set undofile                   " Write undo history
if has('nvim')
  set undodir=~/.local/share/nvim/undo
else
  set undodir=~/.vim/undofiles
endif

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

