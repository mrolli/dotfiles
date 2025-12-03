-- Pull in the wezterm API
local wezterm = require("wezterm")
local keybindings = require("keybindings")
local trackinfo = require("plugins.trackinfo")
local weather = require("plugins.weather")
local statusbar = require("plugins.statusbar")
local zenmode = require("plugins.zenmode")

-- Automatically start wezterm in full-screen mode
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function()
--   local _, _, window = mux.spawn_window({})
--   window:gui_window():maximize()
-- end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- table.insert(config.hyperlink_rules, {
--   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
--   format = 'https://github.com/$1/$3',
-- })
-- Make email addresses clickable
table.insert(config.hyperlink_rules, {
  regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
  format = "mailto:$0",
})

config.show_update_window = false
config.audible_bell = "Disabled"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.color_scheme = "Gruvbox dark, soft (base16)"
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  { family = "Symbols Nerd Font Mono", scale = 0.8 },
})
config.font_size = 16.0
config.use_cap_height_to_scale_fallback_fonts = true
config.scrollback_lines = 10000

-- tab bar styling
-- https://wezfurlong.org/wezterm/config/appearance.html#native-fancy-tab-bar-appearance
config.window_frame = {
  font = wezterm.font({ family = "Roboto", weight = "Regular" }),
  font_size = 14.0,
  active_titlebar_bg = "#3c3836",
  inactive_titlebar_bg = "#3c3836",
}

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#d79921",
      fg_color = "#3c3836",
    },
    inactive_tab = {
      bg_color = "#504945",
      fg_color = "#ebdbb2",
    },
  },
}

-- key bindings - https://wezfurlong.org/wezterm/config/keys.html
config.disable_default_key_bindings = true
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = keybindings.keys
config.key_tables = keybindings.key_tables
-- option key behaviour - https://wezfurlong.org/wezterm/config/keyboard-concepts.html#macos-left-and-right-option-key
-- config.send_composed_key_when_left_alt_is_pressed = true

-- Setup status bar
statusbar.setup(trackinfo, weather)

-- Setup zen mode
zenmode.setup()

-- and finally, return the configuration to wezterm
return config
