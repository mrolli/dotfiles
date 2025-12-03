local wezterm = require("wezterm")

local M = {}

-- Configuration
M.config = {
  -- Powerline symbols
  symbols = {
    left_arrow = "  " .. wezterm.nerdfonts.pl_right_soft_divider,
    solid_left_arrow = wezterm.nerdfonts.pl_right_hard_divider,
    right_arrow = wezterm.nerdfonts.pl_left_soft_divider .. " ",
    solid_right_arrow = wezterm.nerdfonts.pl_left_hard_divider,
  },
  
  -- Color palette for the backgrounds of each cell
  colors_bg = {
    "#3c3836",
    "#504945",
    "#d79921",
    "#fe8019",
  },
  
  -- Foreground color for the text across the fade
  colors_fg = {
    "#ebdbb2",
    "#ebdbb2",
    "#3c3836",
    "#3c3836",
  },
}

-- Build datetime cell content
local function build_datetime()
  return "KW"
    .. wezterm.strftime("%V")
    .. M.config.symbols.left_arrow
    .. wezterm.strftime("%d.%m.%y")
    .. M.config.symbols.left_arrow
    .. wezterm.nerdfonts.md_clock
    .. " "
    .. wezterm.strftime("%R")
end

-- Build right status bar cells
local function build_right_cells(trackinfo, weather)
  local cells = {}
  
  -- current music playing
  if trackinfo then
    table.insert(cells, trackinfo)
  end
  
  -- current weather data
  if weather then
    table.insert(cells, weather)
  end
  
  -- Week, date and time
  table.insert(cells, build_datetime())
  
  -- Hostname
  table.insert(cells, wezterm.hostname())
  
  return cells
end

-- Format cells into powerline elements
local function format_cells(cells)
  local elements = {}
  local num_cells = 0
  
  for i, cell in ipairs(cells) do
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = M.config.colors_fg[cell_no] } })
    table.insert(elements, { Background = { Color = M.config.colors_bg[cell_no] } })
    table.insert(elements, { Text = " " .. cell .. "  " })
    
    local is_last = i == #cells
    if not is_last then
      table.insert(elements, { Foreground = { Color = M.config.colors_bg[cell_no + 1] } })
      table.insert(elements, { Text = M.config.symbols.solid_left_arrow })
    end
    
    num_cells = num_cells + 1
  end
  
  return elements
end

-- Build left status bar elements
local function build_left_status(key_table_name)
  local elements = {}
  
  if key_table_name then
    table.insert(elements, { Foreground = { Color = M.config.colors_fg[4] } })
    table.insert(elements, { Background = { Color = M.config.colors_bg[4] } })
    table.insert(elements, { Text = " TABLE: " .. key_table_name .. " " })
  end
  
  table.insert(elements, { Foreground = { Color = M.config.colors_bg[4] } })
  table.insert(elements, { Background = { Color = M.config.colors_bg[1] } })
  table.insert(elements, { Text = M.config.symbols.solid_right_arrow .. " " })
  
  return elements
end

-- Update status bar
function M.update_status(window, pane, trackinfo, weather)
  -- Build and set right status
  local right_cells = build_right_cells(trackinfo, weather)
  local right_elements = format_cells(right_cells)
  window:set_right_status(wezterm.format(right_elements))
  
  -- Build and set left status
  local key_table_name = window:active_key_table()
  local left_elements = build_left_status(key_table_name)
  window:set_left_status(wezterm.format(left_elements))
end

-- Setup function to register the event handler
function M.setup(trackinfo_plugin, weather_plugin)
  wezterm.on("update-status", function(window, pane)
    local trackinfo = trackinfo_plugin.get_trackinfo()
    local weather = weather_plugin.get_weather()
    M.update_status(window, pane, trackinfo, weather)
  end)
end

return M
