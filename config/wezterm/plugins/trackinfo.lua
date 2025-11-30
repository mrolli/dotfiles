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
  platform = nil,
}

-- Trim a string
function M.trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Get current platform (cached)
local function get_platform()
  if not M.cache.platform then
    local platform
    _, platform, _ = wezterm.run_child_process({ "uname", "-s" })
    M.cache.platform = M.trim(platform)
  end
  return M.cache.platform
end

-- Fetch current track information
local function fetch_trackinfo()
  if get_platform() ~= "Darwin" then
    return nil
  end

  local trackinfo_script = wezterm.config_dir .. "/plugins/musicplaying"
  local success, stdout, _ = wezterm.run_child_process({ trackinfo_script })

  if success and stdout then
    return M.trim(stdout)
  end

  return nil
end

-- Get current track information (with caching)
function M.get_trackinfo()
  if M.cache.counter % M.config.update_interval == 0 then
    M.cache.value = fetch_trackinfo()
  end
  M.cache.counter = M.cache.counter + 1

  return M.cache.value
end

return M
