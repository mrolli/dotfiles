-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- no automatic system clipboard usage
-- see also keybindings regarding yanking
vim.opt.clipboard = ""
-- add a highlighted column
vim.opt.colorcolumn = "80"
-- turn off formatting on save
-- vim.g.autoformat = false

-- configure wildmenu related options
-- vim.opt.wildmode = "full"
-- vim.opt.wildoptions = "pum"
-- vim.opt.wildignore = {
--   "*~",
--   "**/.git/*",
--   "**/.vagrant/*",
--   "*.o",
--   "*.pyc",
--   "*pycache*",
-- }
vim.opt.pumblend = 10 -- make pop-up menu slightly transparent

-- Custom filetypes
vim.filetype.add({
  pattern = {
    [".*/ansible.*/.*%.ya?ml"] = "yaml.ansible",
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*%.ya?ml"] = "yaml.ansible",
  },
})
