local wezterm = require("wezterm")

local M = {}

-- Trim a string
local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Get current track information
function M.get_trackinfo(platform)
  local trackinfo = platform or "Unknown"
  
  if platform == "Darwin" then
    local trackinfo_script = wezterm.config_dir .. "/plugins/musicplaying"
    local success, stdout, _ = wezterm.run_child_process({ trackinfo_script })
    if success then
      trackinfo = trim(stdout)
    end
  end
  
  return trackinfo
end

return M
