-- Setup indent_blankline plugin
-- see https://github.com/lukas-reineke/indent-blankline.nvim

-- Example chars: ⦙ ¦  ┆  │  ⎸  ▏
require('indent_blankline').setup {
  char = '▏',
  show_end_of_line = false,
  buftype_exclude = {'terminal'},
  fileTypeExclude = {'json', 'markdown'},
  use_treesitter = true,
  -- alternating colored columns
  --[[
  char = "",
  char_highlight_list = {
  "IndentBlanklineIndent1",
  "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
  "IndentBlanklineIndent1",
  "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
  --]]
}
