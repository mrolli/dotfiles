local wezterm = require("wezterm")

local M = {}

-- Handle ZEN_MODE changes
local function handle_zen_mode(window, pane, value)
  local overrides = window:get_config_overrides() or {}
  local incremental = value:find("+")
  local number_value = tonumber(value:match("%d+"))
  
  if incremental ~= nil then
    -- Incremental mode: increase font size step by step
    while number_value > 0 do
      window:perform_action(wezterm.action.IncreaseFontSize, pane)
      number_value = number_value - 1
    end
    overrides.enable_tab_bar = false
  elseif number_value < 0 then
    -- Reset mode: restore defaults
    window:perform_action(wezterm.action.ResetFontSize, pane)
    overrides.font_size = nil
    overrides.enable_tab_bar = true
  else
    -- Direct mode: set specific font size
    overrides.font_size = number_value
    overrides.enable_tab_bar = false
  end
  
  window:set_config_overrides(overrides)
end

-- Setup function to register the event handler
function M.setup()
  wezterm.on("user-var-changed", function(window, pane, name, value)
    wezterm.log_info("user-var-changed event: name=" .. name .. ", value=" .. tostring(value))
    if name == "ZEN_MODE" then
      wezterm.log_info("Handling ZEN_MODE with value: " .. value)
      handle_zen_mode(window, pane, value)
    end
  end)
end

return M
