-- Setup better whitespace plugin
-- see https://github.com/ntpeters/vim-better-whitespace

return {
  {
    "ntpeters/vim-better-whitespace",
    enabled = false,
    setup = function()
      -- Enable highlighting and stripping on modified lines only
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_only_modified_lines = 1

      -- The same list as the default except markown is removed to show whitepace in markdown files
      vim.g.better_whitespace_filetypes_blacklist =
        { "diff", "git", "gitcommit", "unite", "qf", "help", "fugitive", "toggleterm" }

      -- Autocommands for this plugins
      local group = vim.api.nvim_create_augroup("user.plugins.better_whitespace", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        -- do not automatically strip whitespace from markdown files
        command = ":DisableStripWhitespaceOnSave",
        group = group,
      })
    end,
  },
}
