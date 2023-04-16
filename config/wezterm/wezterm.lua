-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Automatically start wezterm in full-screen mode
local mux = wezterm.mux
wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

--
-- Make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://github.com/$1/$3',
})

config.show_update_window = false
config.audible_bell = "Disabled"
config.window_decorations = "RESIZE"
config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wezterm.font("JetBrains Mono")
config.font_size = 15
config.use_cap_height_to_scale_fallback_fonts = true
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

-- key bindings - https://wezfurlong.org/wezterm/config/keys.html
config.keys = {
  {
    key = 'RightArrow',
    mods = 'SUPER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'LeftArrow',
    mods = 'SUPER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
}
-- and finally, return the configuration to wezterm
return config
