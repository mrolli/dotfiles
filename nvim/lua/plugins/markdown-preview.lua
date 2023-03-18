-- Setup <PLUGIN> plugin
-- see https://github.com/<OWNER>/<PLUGIN>.nvim

return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = true,
    ft = { "markdown" },
    keys = {
      { "<leader>wp", "<Plug>MarkdownPreview", desc = "Start Markdown Preview" },
    },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
    end,
  },
}
