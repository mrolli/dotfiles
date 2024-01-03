-- This file contains all the configuration related to AI plugins:
-- - David-Kunz/gen.nvimdev
-- - ChatGPT.vim
-- - Github Copilot plugin

return {
  {
    -- Setup David-Kunz/gen.nvim
    -- see https://github.com/David-Kunz/gen.nvim
    "David-Kunz/gen.nvim",
    enabled = true,
    keys = {
      { "<leader>ap", ":Gen<CR>", mode = { "n", "v" }, desc = "Select Gen command" },
    },
    config = function()
      local gen = require("gen")
      gen.setup({
        model = "mistral",
        -- The display mode can be "float" or "split"
        display_mode = "split",
        show_prompt = false,
      })
      gen.prompts["Ask the DevOps Engineer"] = {
        prompt = "You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: Terraform, Packer, Azure, Ansible, Bash, Python, HCL. You answer with code examples when possible. $input:\n$text",
        replace = true,
      }
      gen.prompts["Make_Style"] = {
        prompt = "Transform the following text into the styole of $input:\n$text",
        replace = true,
      }
    end,
  },
  {
    -- Setup ChatGPT.vim plugin
    -- see https://github.com/jackMort/ChatGPT.nvim
    "jackMort/ChatGPT.nvim",
    enabled = false,
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
  {
    -- Setup Github Copilot plugin
    -- see https://github.com/zbirenbaum/copilot.lua
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
        },
        enabled = false,
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            next = "<C-n>",
            prev = "<C-p>",
            dismiss = "<C-d",
          },
        },
        filetypes = {
          yaml = true,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
        },
      })
    end,
  },
}
