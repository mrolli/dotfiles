-- Setup gruvbox-material colorscheme by sainnhe
-- see https://github.com/sainnhe/gruvbox-material

return {
  -- use gruvbox-material
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_palette = "material"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_itablic = 1
      -- vim.g.gruvbox_material_visual = "blue background"
      vim.g.gruvbox_material_spell_foreground = "colored"
      vim.g.gruvbox_material_ui_contrast = "low"
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      -- vim.g.gruvbox_material_better_performance = 1

      -- now load the colorscheme here
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
}
