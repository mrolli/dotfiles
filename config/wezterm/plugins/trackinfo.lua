local wezterm = require("wezterm")

local M = {}

-- Configuration
M.config = {
  update_interval = 3, -- Update every 3 calls
}

-- Internal state
M.cache = {
  value = nil,
  counter = 0,
}

-- Trim a string
local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Fetch current track information
local function fetch_trackinfo(platform)
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

-- Get current track information (with caching)
function M.get_trackinfo(platform)
  if M.cache.counter % M.config.update_interval == 0 then
    M.cache.value = fetch_trackinfo(platform)
  end
  M.cache.counter = M.cache.counter + 1
  
  return M.cache.value or platform or "Unknown"
end

return M
