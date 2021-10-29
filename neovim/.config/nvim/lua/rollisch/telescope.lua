-- Setup telescope plugin
-- see https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' > ',
    color_devicons = true,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    -- for defaults see telescope/mappings.lua
    mappings = {
      i = {
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,
        --["<C-q>"] = actions.send_to_qflist,
        ["<esc>"] = actions.close,
      },
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')

local M = {}

-- only search in the context of the vim configuration files
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "~/.dotfiles/neovim/.config/nvim", --vim.env.DOTFILES,
  })
end

-- fallback to find_files() if we are not in a git project folder
M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then require('telescope.builtin').find_files(opts) end
end

return M
