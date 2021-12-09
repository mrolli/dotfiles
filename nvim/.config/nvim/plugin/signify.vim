" Signify
" https://github.com/mhinz/vim-signify

" git only
let g:signify_vcs_list = [ 'git' ]

" easy show diff
nnoremap <Leader>gd :SignifyDiff<CR>
nnoremap <Leader>ghd :SignifyHunkDiff<CR>
nnoremap <leader>gu :SignifyHunkUndo<cr>
" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
