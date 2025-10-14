local wezterm = require 'wezterm'

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  -- pane:split { direction = "Bottom", size = 0.5 }
end)

return {
  font = wezterm.font 'FiraCode',
  -- config.font = wezterm.font_with_fallback {
  --   'Fira Code', 
  --   'Victor Mono',
  --   'JetBrains Mono',
  -- }

  font_size = 14.5,
  color_schemes = {
    ["Violet Pulse"] = {
      foreground = "#e0e0e0",
      background = "#0f0f1a",
      cursor_bg = "#7700F0",
      cursor_border = "#7700F0",
      cursor_fg = "#0f0f1a",
      selection_bg = "#3f0070",
      selection_fg = "#ffffff",
      ansi = {"#1c1c1c", "#ff5f5f", "#5fff5f", "#ffff5f", "#5f5fff", "#ff5fff", "#5fffff", "#e0e0e0"},
      brights = {"#808080", "#ff8787", "#87ff87", "#ffff87", "#8787ff", "#ff87ff", "#87ffff", "#ffffff"},
    },
  },
  color_scheme = "Violet Pulse",
  window_background_opacity = 0.95,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  default_prog = { '/usr/bin/zsh' },
  keys = {
    { key = 'v', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'Enter', mods = 'CTRL|SHIFT', action = wezterm.action.ToggleFullScreen },
    { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Next' },
    { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
  },
  -- tar bar
  
}
