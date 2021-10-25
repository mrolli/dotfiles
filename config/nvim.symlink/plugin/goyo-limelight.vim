" goyo.vim and limelight.vim
" https://github.com/junegunn/goyo.vim
" https://github.com/junegunn/limelight.vim

" Goyo setttings
let g:goyo_linenr = 1
let g:goyo_width = 120
let g:goyo_height = '100%'

" Goyo mappings
nmap <C-w>g :Goyo<CR>

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Add key mappings
nmap <Leader>l :Limelight!!<CR>
xmap <Leader>l :Limelight!!<CR>


function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  "Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=7
  "Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
