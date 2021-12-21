-- nvim-lspconfig plugin configuration {{{
-- see https://github.com/neovim/nvim-lspconfig
--     https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"
local lsp_status = require "lsp-status"
lsp_status.register_progress()

local nnoremap = vim.keymap.nnoremap
local buf_nnoremap = function(opts)
  opts.buffer = 0
  nnoremap(opts)
end

local inoremap = vim.keymap.inoremap
local buf_inoremap = function(opts)
  opts.buffer = 0
  inoremap(opts)
end

-- Can set this lower if needed.
--require("vim.lsp.log").set_level "debug"
--require("vim.lsp.log").set_level "trace"

local status = require "rollisch.lsp.status"
status.activate()


local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end


local custom_attach = function(client)
  lsp_status.on_attach(client)

  -- Add key mapping per buffer on attaching
  buf_nnoremap { "<leader>vd", vim.lsp.buf.definition }
  buf_nnoremap { "<leader>vi", vim.lsp.buf.implementation }
  buf_nnoremap { "<leader>vsh", vim.lsp.buf.signature_help }
  buf_inoremap { "<leader>vsh", vim.lsp.buf.signature_help }
  buf_nnoremap { "<leader>vrr", vim.lsp.buf.references }
  buf_nnoremap { "<leader>vrn", vim.lsp.buf.rename }
  buf_nnoremap { "<leader>vh", vim.lsp.buf.hover }
  buf_nnoremap { "<leader>vca", vim.lsp.buf.code_action }
  buf_nnoremap { "<leader>vsd", vim.diagnostic.open_float }
  buf_nnoremap { "<leader>vn", vim.diagnostic.goto_next }
  buf_nnoremap { "<leader>vll", vim.diagnostic.setloclist } --{ open_loclist = false } }

  --telescope_mapper("gr", "lsp_references", nil, true)
  --telescope_mapper("gI", "lsp_implementations", nil, true)
  --telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  --telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]]
  end
end


local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, lsp_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)


-- nvim-lsp-installer plugin configuration
-- see https://github.com/williamboman/nvim-lsp-installer
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
  bashls = true,
  intelephense = true,
  jsonls = true,
  vimls = true,
  yamlls = true,
  puppet = true,

  gopls = {
    root_dir = function(fname)
      local Path = require "plenary.path"

      local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
      local absolute_fname = Path:new(fname):absolute()

      if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        return absolute_cwd
      end

      return lspconfig_util.root_pattern("go.mod", ".git")(fname)
    end,

    settings = {
      gopls = {
        codelenses = { test = true },
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },

  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

-- helper function to setup languae servers
local setup_server = function(name, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = 50,
    },
  }, config)

  -- Check that the server is supported in nvim-lsp-installer
  local server_available, requested_server = lsp_installer.get_server(name)
  if server_available then
    requested_server:on_ready(function ()
      requested_server:setup(config)
    end)

    if not requested_server:is_installed() then
      print("Installing " .. name)
      requested_server:install()
    end
  else
    -- handle manual stuff here
    --lspconfig[name].setup(config)
  end
end

-- then configure and attach them to lspconfig
for server, config in pairs(servers) do
  setup_server(server, config)
end

--[[
-- then configure and attach them to lspconfig
lsp_installer.on_server_ready(function(server)
  local default_opts = {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
  }

  -- Create a server_opts table for specific language servers if needed:
  -- see https://github.com/williamboman/nvim-lsp-installer/wiki/Advanced-Configuration#automatically-install-lsp-servers
  local server_opts = {
    --["tsserver"] = function()
    --  default_opts.cmd = {
    --  }
    --  default_opts.flags {
    --  ...
    --  default_opts.on_init = custom_init
    --  default_opts.on_attach = custom_attach
    --  default_opts.capabilities = updated_capabilities
    --end,
  }

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
end)
]]

-- }}}
