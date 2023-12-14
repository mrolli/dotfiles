-- LSP related addtional configuration

local diag_format = function(d)
  local code = d.code or (d.user_data and d.user_data.lsp.code)
  if code then
    return string.format("%s (%s)", d.message, code):gsub("1. ", "")
  end
  return d.message
end

return {
  -- Automatically intall addditional language server,
  -- debug adapters, linters and formatters
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- language servers
        "ansible-language-server",
        "bash-language-server",
        "intelephense",
        "lua-language-server",
        -- debug adapters
        -- linters
        "ansible-lint",
        "shellcheck",
        -- formatters
      })
    end,
  },

  -- Configure changes to LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- -@type lspconfig.options
      -- Show error code in virtual text output
      virtual_text = {
        format = diag_format,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                disable = { "lowercase-global" },
              },
            },
          },
        },
      },
    },
  },
}
