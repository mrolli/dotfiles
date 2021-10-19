" Quick fix list related mappings
nnoremap <C-k> :cnext<CR>zz
nnoremap <C-j> :cprev<CR>zz
nnoremap <leader>k :lnext<CR>zz
nnoremap <leader>j :lprev<CR>zz
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>q :call ToggleQFList(0)<CR>

let g:rollisch_qf_l = 0
let g:rollisch_qf_g = 1

fun! ToggleQFList(global)
    if a:global
        if g:rollisch_qf_g == 1
            let g:rollisch_qf_g = 0
            cclose
        else
            let g:rollisch_qf_g = 1
            copen
        end
    else
        if g:rollisch_qf_l == 1
            let g:rollisch_qf_l = 0
            lclose
        else
            let g:rollisch_qf_l = 1
            lopen
        end
    endif
endfun
