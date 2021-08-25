" Plugin configuration file:
"
" Rainbow
" https://github.com/frazrepo/vim-rainbow

let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_ctermfgs = [
            \ 'Darkblue',
            \ 'darkred',
            \ 'darkgreen',
            \ 'magenta',
            \ 'brown',
            \ 'darkgray',
            \ 'darkcyan',
            \ 'darkmagenta',
            \ 'gray',
            \ ]
