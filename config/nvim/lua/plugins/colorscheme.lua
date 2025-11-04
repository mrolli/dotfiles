return {
  -- Setup gruvbox-material colorscheme by sainnhe
  -- see https://github.com/sainnhe/gruvbox-material
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_palette = "material"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_itablic = 1
      vim.g.gruvbox_material_visual = "red background"
      vim.g.gruvbox_material_spell_foreground = "colored"
      vim.g.gruvbox_material_ui_contrast = "low"
      -- vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      -- vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
  -- Setup Modicator.nvim (auto color line number based on mode)
  -- see https://github.com/mawkler/modicator.nvim
  {
    "mrolli/modicator.nvim",
    branch = "invert_colors",
    dependencies = "sainnhe/gruvbox-material",
    init = function()
      -- These are required for Modicator to work
      vim.o.termguicolors = true
      vim.o.cursorline = true
      vim.o.number = true
    end,
    opts = {
      -- Warn if any required option above is missing. May emit false positives
      -- if some other plugin modifies them, which in that case you can just
      -- ignore. Feel free to remove this line after you've gotten Modicator to
      -- work properly.
      show_warnings = true,
      integration = {
        lualine = {
          highlight = "fg",
        },
      },
    },
  },
}
