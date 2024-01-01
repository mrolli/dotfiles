return {
  -- Setup David-Kunz/gen.nvim
  -- see https://github.com/David-Kunz/gen.nvim
  {
    "David-Kunz/gen.nvim",
    enabled = true,
    keys = {
      { "<leader>ap", ":Gen<CR>", mode = { "n", "v" }, desc = "Select Gen command" },
    },
    opts = {
      model = "mistral",
      show_prompt = false,
    },
    config = function()
      require("gen").prompts["Ask the DevOps Engineer"] = {
        prompt = "You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: Terraform, Packer, Azure, Ansible, Bash, Python, HCL. You answer with code examples when possible. $input:\n$text",
        replace = true,
      }
    end,
  },
  -- Setup ChatGPT.vim plugin
  -- see https://github.com/jackMort/ChatGPT.nvim
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = "op read op://Privat/openai.com/credential --no-newline",
  --     })
  --   end,
  -- },
}
