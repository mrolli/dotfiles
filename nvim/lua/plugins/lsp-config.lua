-- LSP related addtional configuration

local diag_format = function(d)
  local code = d.code or (d.user_data and d.user_data.lsp.code)
  if code then
    return string.format("%s (%s)", d.message, code):gsub("1. ", "")
  end
  return d.message
end

return {
  -- Show error code in virtual text output
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    opts = {
      autoformat = true,
      virtual_text = {
        format = diag_format,
      },
    },
  },

  -- Automatically intall addditional language server, debug adapters, linters and formatters
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- language servers
        "ansible-language-server",
        "bash-language-server",
        "css-lsp",
        "intelephense",
        "lua-language-server",
        "pyright",
        "solargraph",
        "yaml-language-server",
        -- debug adapters
        -- linters
        "ansible-lint",
        "flake8",
        "markdownlint",
        "rubocop",
        "selene",
        "shellcheck",
        -- formatters
        "isort",
        "stylua",
        "shfmt",
      })
    end,
  },

  -- Configure changes to LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        ansiblels = {},
        bashls = {},
        pyright = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                disable = { "lowercase-global" },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
  },

  -- Activate additional builtin sources
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      -- Make gqq work again, see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
      require("lazyvim.util").on_attach(function(client, buf)
        if client.name == "null-ls" then
          if
            not require("null-ls.generators").can_run(vim.bo[buf].filetype, require("null-ls.methods").lsp.FORMATTING)
          then
            vim.bo[buf].formatexpr = nil
          end
        end
      end)

      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.selene.with({
          condition = function(utils)
            return utils.root_has_file({ "selene.toml" })
          end,
        }),
        nls.builtins.formatting.isort,
        nls.builtins.formatting.black,
        nls.builtins.diagnostics.flake8,
        nls.builtins.code_actions.shellcheck,
      })
    end,
  },
}
