-- Add a new keymap group for mappings regarding AI tools
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        mode = { "n", "v" },
        { "<leader>a", group = "ai tools", mode = { "n", "v" } },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
      },
    },
  },
}
