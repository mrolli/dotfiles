local wezterm = require("wezterm")

local M = {}

-- Configuration
M.config = {
  location = "Burgdorf",
  format = "%l:+%c%t%20%20%w%20%20%m",
  timeout = 2,
}

-- Get current weather information
function M.get_weather()
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

return M
