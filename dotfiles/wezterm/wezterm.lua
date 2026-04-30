local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ==========================================
-- Plugins
-- ==========================================
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- 1. Auto-load state when Wezterm starts
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

-- 2. Auto-save state continuously
resurrect.state_manager.periodic_save({
  interval_seconds = 60,
  save_workspaces = true,
  save_windows = true,
  save_tabs = true,
})

-- Initialize Tabline (Overrides native tab bar & update-status hook)
tabline.setup({
  options = {
    theme = "Tokyo Night",
    section_separators = { left = "", right = "" },
    component_separators = { left = "|", right = "|" },
  },
  sections = {
    tabline_a = {}, -- Removes "NORMAL"
    tabline_y = {}, -- Removes Time & Battery
    tabline_z = {}, -- Removes "local"
  },
})
tabline.apply_to_config(config)

-- ==========================================
-- Core & Performance
-- ==========================================
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.scrollback_lines = 100000
config.front_end = "WebGpu"
config.max_fps = 60

-- ==========================================
-- Appearance & Window
-- ==========================================
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13.0
config.default_cursor_style = "BlinkingBar"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.5,
}

-- ==========================================
-- Hyperlink Rules
-- ==========================================
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[\b[0-9a-f]{7,40}\b]],
  format = "https://github.com/search?q=$0&type=commits",
})

-- ==========================================
-- Hooks
-- ==========================================
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- ==========================================
-- Keybindings
-- ==========================================
local mod = "SUPER"

config.keys = {
  -- Pane Management
  { key = "Enter", mods = mod, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = mod, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = mod, action = act.CloseCurrentPane({ confirm = false }) },
  { key = "z", mods = mod, action = act.TogglePaneZoomState },

  -- Pane Navigation
  { key = "h", mods = mod, action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = mod, action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = mod, action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = mod, action = act.ActivatePaneDirection("Right") },

  -- Tab Management
  { key = "t", mods = mod, action = act.SpawnTab("CurrentPaneDomain") },
  { key = "Enter", mods = mod .. "|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = mod, action = act.ActivateTabRelative(-1) },
  { key = "]", mods = mod, action = act.ActivateTabRelative(1) },

  -- Utilities
  { key = "p", mods = mod, action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  { key = "Space", mods = mod .. "|SHIFT", action = act.QuickSelect },
}

-- Numeric Tab Navigation (1-9)
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = mod,
    action = act.ActivateTab(i - 1),
  })
end

return config
