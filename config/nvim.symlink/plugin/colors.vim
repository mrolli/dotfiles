fun! ColorMyPencils()
  " See https://github.com/gruvbox-community/gruvbox/wiki/Configuration
  let g:gruvbox_contrast_dark = 'soft'
  let g:gruvbox_italic = 1
  let g:gruvbox_invert_signs = 0
  let g:gruvbox_improved_strings = 0

  set background=dark
  colorscheme gruvbox

  "let g:gruvbox_contrast_dark = 'medium'
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " These are the correct escape sequences for the $TERM
    " see ~/bin/termtester
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"
    set termguicolors
  endif

  "if &term =~ '256color'
  "  disable Background Color Erase (BCE) so that color schemes
  "  render properly when inside 256-color tmux and GNU screen.
  "  see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  " set t_ut=
  "endif

  "highlight LineNr ctermfg=109 guifg=#40ffff
  highlight netrwDir ctermfg=109 guifg=#40ffff
  highlight Comment cterm=italic gui=italic
  highlight ColorColumn ctermbg=0 guibg=#638578
  highlight Cursorline cterm=bold ctermbg=238 gui=bold guibg=#3c3836
  " Keep this though it does not work correctly
  highlight SpellBad gui=undercurl guisp=red term=undercurl cterm=undercurl
  " Colorize unprintable chars, i.e. tabs!
  highlight SpecialKey ctermfg=white ctermbg=9 guibg=#FF0000
  " Colorize indentation stripes
  highlight IndentBlanklineIndent1 guibg=#32302f gui=nocombine
  highlight IndentBlanklineIndent2 guibg=#3c3836 gui=nocombine
endfun
call ColorMyPencils()

nnoremap <Leader>vwm :call ColorMyPencils()<CR>
