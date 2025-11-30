local wezterm = require("wezterm")

local M = {}

-- Configuration
M.config = {
  location = "Burgdorf",
  format = "%l:+%c%t%20%20%w%20%20%m",
  timeout = 2,
  update_interval = 20, -- Update every 20 calls
}

-- Internal state
M.cache = {
  value = "",
  counter = 0,
}

-- Fetch current weather information
local function fetch_weather()
  local url = string.format("wttr.in/%s?format=%s", M.config.location, M.config.format)
  local success, stdout, _ = wezterm.run_child_process({
    "curl",
    "-m", tostring(M.config.timeout),
    "--silent",
    url,
  })
  
  if not success or not stdout then
    return ""
  end
  
  return stdout
end

-- Get current weather information (with caching)
function M.get_weather()
  if M.cache.counter % M.config.update_interval == 0 then
    M.cache.value = fetch_weather()
  end
  M.cache.counter = M.cache.counter + 1
  
  return M.cache.value
end

return M
