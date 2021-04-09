" Plugin configuration file:
"
" lightline.vim
" https://github.com/itchyny/lightline.vim
"
" Below configuration relys on an patched font
" for powerline. Set the font in respective
" terminal emulator.
"
" Fonts can be found here:
" https://github.com/powerline/fonts
"
" Recommendations: Menlo for Powerline, Cousine for Powerline
"
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [[ 'mode', 'paste', ], [ 'fugitive', 'filename' ]],
      \   'right': [[ 'percent', 'lineinfo' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], [ 'fileformat', 'fileencoding', 'filetype' ], [ 'trailingspace', 'trailingtab' ]]
      \ },
      \ 'component': {
      \   'percent': '%p%%',
      \   'lineinfo': '%l:%v'
      \ },
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'trailingspace': 'StatuslineTrailingSpaceWarning',
      \   'trailingtab': 'StatuslineTabWarning',
      \   'mylineinfo': 'MyLineInfo'
      \ },
      \ 'component_type': {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '|' }
      \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*FugitiveHead")
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    let trailing = search('\s\+$', 'nw')
    if trailing != 0
      let b:statusline_trailing_space_warning = printf('trailing[%s]', trailing)
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw')
    let spaces = search('^ ', 'nw')

    if tabs && spaces
      let b:statusline_tab_warning =  printf('mixed-indenting[%s]', tabs)
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction

