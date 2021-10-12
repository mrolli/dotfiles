" vim-better-whitespace
" https://github.com/ntpeters/vim-better-whitespace

" Call DisableStripWhitespaceOnSave for markdown files,
" but remove them from blacklisted filetypes
:au FileType markdown DisableStripWhitespaceOnSave
let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive']

