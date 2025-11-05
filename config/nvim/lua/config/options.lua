-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- add support for bicep and bicepparam files
vim.filetype.add({
  extension = {
    bicep = "bicep",
    bicepparam = "bicep-params",
  },
})
