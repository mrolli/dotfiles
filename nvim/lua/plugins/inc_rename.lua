-- Setup smjonas/inc-rename.nvim plugin
-- see https://github.com/smjonas/inc-rename.nvim

return {
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
}
