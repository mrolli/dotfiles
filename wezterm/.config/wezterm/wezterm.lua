local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return {
  window_decorations = "RESIZE",
  -- color_scheme = 'Gruvbox Material (Gogh)',
  color_scheme = 'Gruvbox dark, soft (base16)',
  font = wezterm.font("JetBrains Mono"),
  font_size = 15,
  use_cap_height_to_scale_fallback_fonts = true,
  hide_tab_bar_if_only_one_tab = true,
  scrollback_lines = 10000,
}
