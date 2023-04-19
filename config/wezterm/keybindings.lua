local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    -- Enter resize_pane key table
    {
      key = 'r',
      mods = 'LEADER',
      action = act.ActivateKeyTable {
        name = 'resize_pane',
        one_shot = false,
        -- timeout_milliseconds = 1003,
      },
    },

    -- Enter copy_mode key table
    { key = 'Escape', mods = 'LEADER', action = act.ActivateCopyMode, },

    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendString '\x01', },

    -- Some tmux-like key assignemtns for pane handling
    { key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }), },
    { key = "/", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }), },
    { key = "|", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }), },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = "c", mods = "LEADER", action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'Enter', mods = 'LEADER', action = act.ToggleFullScreen },

    -- Window handling
    { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    { key = 'q', mods = 'SHIFT|CTRL', action = act.QuitApplication },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    { key = 'h', mods = 'SHIFT|CTRL', action = act.HideApplication },
    { key = 'h', mods = 'SUPER', action = act.HideApplication },

    -- Tab handling key assignments
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'LeftArrow', mods = 'SUPER', action = wezterm.action.ActivateTabRelative(-1), },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = 'SUPER', action = wezterm.action.ActivateTabRelative(1), },
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'LeftArrow', mods = 'SHIFT|SUPER', action = act.MoveTabRelative(-1) },
    { key = 'RightArrow', mods = 'SHIFT|SUPER', action = act.MoveTabRelative(1) },
    { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
    { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
    { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
    { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
    { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
    { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
    { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
    { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
    { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) },

    -- Font size manipulation
    { key = '+', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },

    -- Buffer manipulation
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

    -- Overlays
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },

    -- Clipboard management
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'u', mods = 'SUPER', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },

    -- Miscellaneous, not sure if useful
    { key = 'f', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
  },

  key_tables = {
    -- Defines the keys that are active in our resize-pane mode.
    -- Since we're likely to want to make multiple adjustments,
    -- we made the activation one_shot=false. We therefore need
    -- to define a key assignment for getting out of this mode.
    -- 'resize_pane' here corresponds to the name="resize_pane" in
    -- the key assignments above.
    resize_pane = {
      { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
      { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
      { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
      { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
      -- Cancel the mode by pressing escape
      { key = 'Escape', action = 'PopKeyTable' },
    },
    -- Apparently the default key tables are preserved and are not purged
    -- due to adding this new one.
  }
}
