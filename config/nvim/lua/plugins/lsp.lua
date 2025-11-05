-- Custom LSP configuration
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- automatically install with mason and load with lspconfig
        bicep = {},
      },
    },
  },
}
