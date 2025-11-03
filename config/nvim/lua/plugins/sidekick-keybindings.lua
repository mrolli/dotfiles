-- Customize sidekick keybindings to avoid conflicts

-- Copilot Chat keeps its default bindings
-- <leader>aa = Toggle Copilot Chat
-- <leader>ax = Clear Copilot Chat
-- <leader>aq = Quick Chat
-- <leader>ap = Copilot Chat Prompt Actions
return {
  -- Sidekick: remap keybindings to avoid conflict with copilot-chat
  {
    "folke/sidekick.nvim",
    keys = {
      -- Keep the inline NES tab navigation
      { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },

      -- Remap sidekick main toggle from <leader>aa to <leader>ak (ai-sidekick)
      {
        "<c-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>ak",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Sidekick Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Sidekick Detach CLI",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Sidekick Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Sidekick Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Sidekick Send Visual Selection",
      },
      {
        "<leader>ai",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
}
