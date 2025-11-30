return {
  -- see https://github.com/lukas-reineke/virt-column.nvim
  -- see :help virt-column.txt
  {
    "lukas-reineke/virt-column.nvim",
    opts = {
      char = { "┆" },
      virtcolumn = "80",
    },
  },
  -- see https://github.com/b0o/incline.nvim
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup({
        -- window = { margin = { vertical = 0, horizontal = 1 } },
        -- hide = { cursorline = true, only_win = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[*]" .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)

          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
  -- Modify core plugin bufferline
  -- see :help bufferline-configuration
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- see https://github.com/folke/zen-mode.nvim
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
    },
    opts = {
      window = {
        options = {
          number = true,
          relativenumber = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
    },
  },
  -- see https://github.com/folke/twilight.nvim
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {
      context = 8,
      expand = {
        "function",
        "method",
        "block",
        "if_statement",
      },
    },
  },
}
