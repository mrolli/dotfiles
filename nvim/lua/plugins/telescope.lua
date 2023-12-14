-- Setup telescpoe-fzf-native plugin
-- see https://github.com/nvim-telescope/telescope-fzf-native.nvim

return {
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
