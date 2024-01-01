-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- Automatically set text width for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set tw=80",
})

-- Empty formatexpr for markdwon files to make gqq and gqap work again
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set formatexpr=",
})

-- Markdown should have wrapping enabled by default
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set wrap",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- Empty formatexpr for LSP buffers to make gqq and gqap work again
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     vim.bo[args.buf].formatexpr = nil
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
