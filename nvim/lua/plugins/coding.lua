return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
    end,
    keys = {
      {
        "<A-,>",
        function()
          if require("luasnip").choice_active() then
            require("luasnip").jump(1)
          end
        end,
        mode = { "i", "s" },
      },
      {
        "<A-m>",
        function()
          if require("luasnip").choice_active() then
            require("luasnip").jump(-1)
          end
        end,
        mode = { "i", "s" },
      },
    },
  },
}
