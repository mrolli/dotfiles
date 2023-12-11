-- Setup zen-mode and twilight plugin
-- see https://github.com/folke/zen-mode.nvim
-- see https://github.com/folke/twilight.nvim

return {
  {
    "folke/zen-mode.nvim",
    enabled = true,
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
    },
    opts = {
      window = {
        options = {
          number = true,
          relativenumber = false,
        },
      },
    },
  },
  {
    "folke/twilight.nvim",
    enabled = true,
    keys = {
      { "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = { context = 6 },
  },
}
