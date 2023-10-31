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
      -- ---@type lspconfig.options
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
        terraformls = {},
        tflint = {},
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

  -- additional options for terraform
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
    },
  }
}
