-- Setup colorizer plugin
-- see https://github.com/NvChad/nvim-colorizer.lua
--
return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    opts = {
      filetypes = {
        "*",
        "!gitcommit",
      },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background, virtualtext
        mode = "virtualtext", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
}
