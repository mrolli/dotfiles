" Signify
" https://github.com/mhinz/vim-signify

" git only
let g:signify_vcs_list = [ 'git' ]

" Easy show diff
nnoremap <Leader>di :SignifyHunkDiff<CR>
