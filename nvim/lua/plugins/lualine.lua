-- Change lualine plugin configuration to my taste
-- see https://github.com/nvim-lualine/lualine.nvim

local window_width_limit = 100

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > window_width_limit
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local function mixed_indenting()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, "nwc")
  local tab_indent = vim.fn.search(tab_pat, "nwc")
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ""
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return "MI:" .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return "MI:" .. tab_indent
  else
    return "MI:" .. space_indent
  end
end

-- See https://github.com/nvim-lualine/lualine.nvim#general-component-options
local components = {
  encoding = {
    "encoding",
    -- fmt = string.upper,
    cond = conditions.hide_in_width,
    padding = 0,
  },
  fileformat = {
    "fileformat",
    icons_enabled = true,
    symbols = {
      unix = "LF",
      dos = "CRLF",
      mac = "CR",
    },
    cond = nil,
  },
  filetype = { "filetype", cond = nil, padding = 0 },
  location = { "location", cond = nil, padding = 0 },
  mixedindent = {
    mixed_indenting(),
    cond = nil,
    padding = 0,
  },
  progress = { "progress", cond = nil, padding = 0 },
  spaces = {
    function()
      local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "local" })
      return "sw=" .. shiftwidth
    end,
    cond = nil,
    padding = 1,
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    opts = {
      options = {
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_y = {
          components.filetype,
          components.fileformat,
          components.encoding,
          components.spaces,
          components.mixedindent,
        },
        lualine_z = {
          components.progress,
          components.location,
        },
      },
    },
  },
}
