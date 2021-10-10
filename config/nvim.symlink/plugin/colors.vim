let g:mrolli_colorscheme = "gruvbox"
fun! ColorMyPencils()
  "let g:gruvbox_contrast_dark = 'medium'
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

  set background=dark
  colorscheme gruvbox
  let g:gruvbox_contrast_dark = 'medium'
  let g:gruvbox_invert_section = '0'

  "if &term =~ '256color'
  "  disable Background Color Erase (BCE) so that color schemes
  "  render properly when inside 256-color tmux and GNU screen.
  "  see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  " set t_ut=
  "endif

  "highlight LineNr ctermfg=109 guifg=#40ffff
  highlight netrwDir ctermfg=109 guifg=#40ffff
  highlight Comment cterm=italic gui=italic
  highlight ColorColumn ctermbg=0 guibg=grey
  highlight Cursorline cterm=bold ctermbg=238 gui=bold guibg=#3c3836
endfun
call ColorMyPencils()

nnoremap <Leader>vwm :call ColorMyPencils()<CR>
