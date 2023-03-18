-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- no automatic system clipboard usage
-- see also keybindings regarding yanking
vim.opt.clipboard = ""
-- add a highlighted column
vim.opt.colorcolumn = "80"

-- configure folding for Treesitter usage
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 7

-- configure wildmenu related options
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"
vim.opt.wildignore = {
  "*~",
  "**/.git/*",
  "**/.vagrant/*",
  "*.o",
  "*.pyc",
  "*pycache*",
}
vim.opt.pumblend = 10 -- make pop-up menu slightly transparent
