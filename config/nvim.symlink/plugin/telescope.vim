lua require('rollisch')

nnoremap <Leader>fg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>fgi :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>

nnoremap <Leader>fs :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fh :lua require('telescope.builtin').help_tags()<CR>
"nnoremap <Leader>fv :lua require('').search_dotfiles()<CR>
