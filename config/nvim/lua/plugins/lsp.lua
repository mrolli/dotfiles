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
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", vim.env.HOME .. "/.config/nvim/.markdownlint.yaml", "--" },
        },
      },
    },
  },
}
