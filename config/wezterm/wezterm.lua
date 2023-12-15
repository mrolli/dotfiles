-- Pull in the wezterm API
local wezterm = require("wezterm")
local keybindings = require("keybindings")

-- Trim a strng
function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Get current platform we run on
function get_platform()
  local platform
  _, platform, _ = wezterm.run_child_process({ "uname", "-s" })
  return trim(platform)
end
wezterm.GLOBAL.platform = get_platform()

-- Automatically start wezterm in full-screen mode
local mux = wezterm.mux
wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

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

function update_trackinfo()
  wezterm.GLOBAL.current_trackinfo = wezterm.GLOBAL.platform
  if wezterm.GLOBAL.platform == "Darwin" then
    local trackinfo_script = wezterm.config_dir .. "/musicplaying"
    local success, stdout, _ = wezterm.run_child_process({ trackinfo_script })
    if success then
      wezterm.GLOBAL.current_trackinfo = trim(stdout)
    end
  end
end

function update_weather()
  local success, stdout, _ = wezterm.run_child_process({
    "curl",
    "-m 2",
    "--silent",
    "wttr.in/Burgdorf?format=%l:+%c%t%20%20%w%20%20%m",
  })
  if not success or not stdout then
    wezterm.GLOBAL.current_weather = ""
  end
  wezterm.GLOBAL.current_weather = stdout
end

wezterm.on("update-status", function(window, pane)
  local tcnt = wezterm.GLOBAL.trackinfo_loop_counter or 0
  if tcnt % 3 == 0 then
    update_trackinfo()
  end
  wezterm.GLOBAL.trackinfo_loop_counter = tcnt + 1

  local wcnt = wezterm.GLOBAL.weather_loop_counter or 0
  if wcnt % 10 == 0 then -- every 10 mins
    update_weather()
  end
  wezterm.GLOBAL.weather_loop_counter = wcnt + 1

  -- The powerline < symbol
  local LEFT_ARROW = "  " .. wezterm.nerdfonts.pl_right_soft_divider

  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

  -- The powerline < symbol
  local RIGHT_ARROW = wezterm.nerdfonts.pl_left_soft_divider .. " "

  -- The filled in variant of the < symbol
  -- local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
  local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- current music playing
  table.insert(cells, wezterm.GLOBAL.current_trackinfo)

  -- current weather data
  table.insert(cells, wezterm.GLOBAL.current_weather)

  -- Week, date and time
  local datetime = "KW"
    .. wezterm.strftime("%V")
    .. LEFT_ARROW
    .. wezterm.strftime("%d.%m.%y")
    .. LEFT_ARROW
    .. wezterm.nerdfonts.md_clock
    .. " "
    .. wezterm.strftime("%R")
  table.insert(cells, datetime)

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find("/")
    local hostname = ""
    if slash then
      hostname = cwd_uri:sub(1, slash - 1)
      -- Remove the domain name portion of the hostname
      local dot = hostname:find("[.]")
      if dot then
        hostname = hostname:sub(1, dot - 1)
      end

      table.insert(cells, hostname)
    end
  else
    table.insert(cells, "Where am I? ")
  end

  -- Color palette for the backgrounds of each cell
  local colors_bg = {
    "#3c3836",
    "#504945",
    "#d79921",
    "#fe8019",
  }

  -- Foreground color for the text across the fade
  local colors_fg = {
    "#ebdbb2",
    "#ebdbb2",
    "#3c3836",
    "#3c3836",
  }

  -- The elements to be formatted
  local elements = {}

  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = colors_fg[cell_no] } })
    table.insert(elements, { Background = { Color = colors_bg[cell_no] } })
    table.insert(elements, { Text = " " .. text .. "  " })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors_bg[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))

  local leftElements = {}
  local keyTableName = window:active_key_table()
  if keyTableName then
    table.insert(leftElements, { Foreground = { Color = colors_fg[4] } })
    table.insert(leftElements, { Background = { Color = colors_bg[4] } })
    table.insert(leftElements, { Text = " TABLE: " .. keyTableName .. " " })
  end
  table.insert(leftElements, { Foreground = { Color = colors_bg[4] } })
  table.insert(leftElements, { Background = { Color = colors_bg[1] } })
  table.insert(leftElements, { Text = SOLID_RIGHT_ARROW .. " " })

  window:set_left_status(wezterm.format(leftElements))
end)

-- and finally, return the configuration to wezterm
return config
