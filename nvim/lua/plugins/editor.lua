-- Add a new keymap group for mappings regarding AI tools
return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>a"] = { name = "+ai tools" },
      },
    },
  },
}
