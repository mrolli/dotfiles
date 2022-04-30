--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
vim.opt.relativenumber = true
-- no mouse support
vim.opt.mouse = ""
-- no lines crossing usng cursor and h,l aka classic vim defaults
vim.opt.whichwrap = "b,s"
-- highlight column 80
vim.opt.colorcolumn = "120"
vim.opt.cindent = true
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Colorscheme setttings
lvim.colorscheme = "tokyonight"
lvim.builtin.lualine.theme = "tokyonight"
lvim.builtin.lualine.sections.lualine_y = { "spaces", {
  "fileformat",
  icons_enabled = false
}, "encoding", "filetype" }
lvim.builtin.lualine.sections.lualine_z = { "progress", "location" }
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- include vimscript for altering theme related stuff
vim.cmd 'source ~/.config/lvim/theme.vim'

-- The same list as the default except markown is removed to show whitepace in markdown files
vim.g.better_whitespace_filetypes_blacklist = { 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive' }
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }

-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.insert_mode["jj"] = false
lvim.keys.insert_mode["k"] = false
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["∆"] = "<Esc>:m .+1<CR>==gi"
lvim.keys.insert_mode["˚"] = "<Esc>:m .-2<CR>==gi"
lvim.keys.normal_mode["∆"] = ":m .+1<CR>=="
lvim.keys.normal_mode["˚"] = ":m .-2<CR>=="
lvim.keys.normal_mode["<C-w>t"] = "<cmd>Twilight<cr>"
lvim.keys.normal_mode["<C-w>z"] = "<cmd>ZenMode<cr>"
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "css",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "php",
  "python",
  "rust",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.textobjects = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,

    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
      ["<leader>A"] = "@parameter.inner",
    },
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
  lsp_interop = {
    enable = true,
    border = 'none',
    peek_definition_code = {
      ["<leader>df"] = "@function.outer",
      ["<leader>dF"] = "@class.outer",
    },
  },
}
-- Add lables to the textobjects keybindings
require("which-key").register({
  ["[["] = { "Previous class start"},
  ["[]"] = { "Previous class end"},
  ["]]"] = { "Next class end"},
  ["]["] = { "Next class start"},
  ["<leader>a"] = { "Swap w/next param" },
  ["<leader>A"] = { "Swap w/prev param" }
})
-- lvim.builtin.which_key.mappings["a"] = { "Swap with next param" }
-- lvim.builtin.which_key.mappings["A"] = { "Swap with prev param" }

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

lvim.plugins = {
  { "editorconfig/editorconfig-vim" },
  { "jeffkreeftmeijer/vim-numbertoggle" }, -- automatically toggle relativenumber for active buffer
  { "lukas-reineke/indent-blankline.nvim" }, -- visual indentation markers
  { "folke/tokyonight.nvim" },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          options = {
            number = true,
            relativenumber = false,
          }
        }
      }
    end
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        context = 12,
      }
    end
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "rodjek/vim-puppet" },
  { "godlygeek/tabular" },
  { "ntpeters/vim-better-whitespace" },
  { "vim-scripts/loremipsum" },
}
-- candidate plugins:
-- - iamcco/markdown-preview.nvim

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
  -- do not automatically strip whitespace from markdown files
  { "FileType", "markdown", ":DisableStripWhitespaceOnSave" },
}
