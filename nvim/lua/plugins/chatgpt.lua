-- Setup ChatGPT.vim plugin
-- see https://github.com/jackMort/ChatGPT.nvim

if true then
  return {}
end

return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://Privat/openai.com/credential --no-newline",
      })
    end,
  },
}
