-- Setup colorizer plugin
-- see https://github.com/norcalli/nvim-colorizer.lua
--
return {
  {
    "norcalli/nvim-colorizer.lua",
    enabled = true,
    config = function()
      require("colorizer").setup({
        "*",
        "!gitcommit",
      }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = "background", -- Set the display mode.
      })
    end,
  },
}
