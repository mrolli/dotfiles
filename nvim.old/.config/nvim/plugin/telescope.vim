lua require('rollisch')

nnoremap <Leader>fg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>ff :lua require('rollisch.telescope').project_files()<CR>

nnoremap <Leader>fw :lua require('telescope.builtin').grep_string()<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fbi :Telescope builtin<CR>
nnoremap <Leader>fh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>fv :lua require('rollisch.telescope').search_dotfiles()<CR>
