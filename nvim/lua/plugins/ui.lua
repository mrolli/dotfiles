return {
  -- Setup virt-column.nvim by lukas-reineke
  -- see https://github.com/lukas-reineke/virt-column.nvim
  -- see :help virt-column.txt
  {
    "lukas-reineke/virt-column.nvim",
    opts = {
      char = { "┆" },
      virtcolumn = "80",
    },
  },
  -- Modify core plugin bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
}
