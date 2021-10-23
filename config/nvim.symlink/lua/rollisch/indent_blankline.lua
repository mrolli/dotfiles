-- Setup indent_blankline plugin
-- see https://github.com/lukas-reineke/indent-blankline.nvim

-- Example chars: ⦙ ¦  ┆  │  ⎸  ▏
require('indent_blankline').setup {
    char = '⎸',
    show_end_of_line = true,
    buftype_exclude = {'terminal'},
    --fileTypeExclude = {'json', 'markdown'},
}
