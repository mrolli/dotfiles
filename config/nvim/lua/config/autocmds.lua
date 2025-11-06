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

-- Automatically set text width for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set tw=80",
})

-- Empty formatexpr for markdwon files to make gqq and gqap work again
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "gitcommit" },
  command = "set formatexpr=",
})

-- Some filetypes should have wrapping enabled by default
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "json" },
  -- enable wrap mode
  command = "setlocal wrap",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "json", "jsonc" },
--   callback = function()
--     vim.opt.conceallevel = 0
--   end,
-- })

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
