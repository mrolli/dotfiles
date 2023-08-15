-- Setup Github Copilot plugin
-- see https://github.com/zbirenbaum/copilot.lua

return {
  {
      'zbirenbaum/copilot.lua',
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
              auto_trigger = true,
              keymap = {
                accept = false
              }
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
  }
}
