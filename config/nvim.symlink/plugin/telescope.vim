lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' > ',
    color_devicons = true,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        --["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
        ["<esc>"] = actions.close,
      },
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require('telescope')

--local M = {}
--M.search_dotfiles = function()
--  require("telescope.builtin").find_files({
--    prompt_title = "< VimRC >",
--    cwd = "~/.dotfiles/config/nvim",
--  })
--end

return M
--.load_extension('fzy_native')

EOF

nnoremap <Leader>fg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>fgi :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>

nnoremap <Leader>fs :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fh :lua require('telescope.builtin').help_tags()<CR>
"nnoremap <Leader>fv :lua require('').search_dotfiles()<CR>
