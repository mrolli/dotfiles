-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- These remaps make the jumps scroll to the middle of
-- the screen for less eye distraction
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "gd", "gdzzzv")

-- Feature Ctrl+a to select all text in buffer
-- As this overwrites the default increment mapping, move
-- increasing/decreasing to it to + and -
-- map("n", "<C-a>", "ggVG", { desc = "Select all" })
-- map("n", "+", "<C-a>", { desc = "Increment" })
-- map("n", "-", "<C-x>", { desc = "Decrement" })

--[[
  Using leader + y/Y to yank to unnameplus or paste from unnamedplus register.
  The register unnamedplus is the system's clipboard and is the default
  clipboard register in LazyVim, but I don't like that.
  Therefore clipboard is changed to empty value (see lua/config/options.lua) and these
  additional mappings below using the leader key are in place to yank to and paste
  from the unnamedplus register.
  Found at https://github.com/LunarVim/LunarVim/issues/930#issuecomment-890597260
  ]]

-- Yank to system clipboard
-- map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
-- map("n", "<leader>yy", '"+yy', { desc = "Yank line to clipboard" })
-- map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- Paste from system clipbard
-- map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
-- map("n", "<leader>P", '"+P', { desc = "Paste from clipboard" })
-- map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Deliberately delete to black hole register
-- map("n", "<leader>d", '"_d', { desc = "Delete to black hole" })
-- map("v", "<leader>d", '"_d', { desc = "Delete to black hole" })

-- Make file in current buffer executable
map("n", "<leader>fx", "<cmd>silent !chmod +x %<CR>", { desc = "Make current buffer executable" })

-- Show all known snippets for the current filetype
-- map("n", "<leader>cs", ":lua require('luasnip.extras.snippet_list').open()<CR>", { desc = "Show Snippet List" })

-- Align markdown tables using pa'doc
-- map("v", "<leader>ct", "!pandoc -t markdown-simple_tables<CR>", { desc = "Align selected md table using pandoc" })
