-- lsp-status configuration {{{
-- shamelessly copied from tj

local lsp_status = require "lsp-status"

local status = {}

status.select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ["start"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[1]),
      },
      ["end"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[2]),
      },
    }

    return require("lsp-status.util").in_range(cursor_pos, value_range)
  end
end

status.activate = function()
  lsp_status.config {
    select_symbol = status.select_symbol,

    indicator_errors = "",
    indicator_warnings = "",
    indicator_info = "🛈",
    indicator_hint = "!",
    indicator_ok = "",
    spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
    status_symbol ='',
  }

  lsp_status.register_progress()
end

status.on_attach = function(client)
  lsp_status.on_attach(client)

  vim.cmd [[augroup rollisch_lsp_status]]
  vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
  vim.cmd [[augroup END]]
end

return status

-- }}}
