-- Custom AI configuration
return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        tools = {
          copilot = { cmd = { "copilot", "--alt-screen" } },
        },
      },
    },
  },
}
