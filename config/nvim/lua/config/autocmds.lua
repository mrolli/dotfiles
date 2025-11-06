-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make commentstring work for Bicep files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "bicep", "bicep-params" },
  command = "set commentstring=//\\ %s",
})

-- Set relative line numbers when not in insert mode
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = 'if &nu && mode() != "i" | set rnu   | endif',
})

-- Set absolute line numbers when in insert mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "if &nu | set nornu | endif",
})
