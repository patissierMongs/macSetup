-- ═══════════════════════════════════════════════════════════════
-- WezTerm Configuration
-- ═══════════════════════════════════════════════════════════════

local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 14.0
config.line_height = 1.2
config.cell_width = 1.0

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}
config.initial_cols = 140
config.initial_rows = 40

-- Tab Bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- Cursor
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500
config.cursor_thickness = 2

-- Scrollback
config.scrollback_lines = 10000

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
}

-- Performance
config.enable_wayland = false
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 60
config.max_fps = 120

-- Key Bindings
config.keys = {
    -- Pane splitting
    { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    
    -- Pane navigation
    { key = 'h', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Down' },
    
    -- Pane resizing
    { key = 'h', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'l', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'k', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'j', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
    
    -- Tab navigation
    { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
    { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
    { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
    { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
    { key = '5', mods = 'CMD', action = act.ActivateTab(4) },
    { key = '6', mods = 'CMD', action = act.ActivateTab(5) },
    { key = '7', mods = 'CMD', action = act.ActivateTab(6) },
    { key = '8', mods = 'CMD', action = act.ActivateTab(7) },
    { key = '9', mods = 'CMD', action = act.ActivateTab(-1) },
    
    -- Close pane/tab
    { key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } },
    
    -- Copy mode
    { key = 'x', mods = 'CMD|SHIFT', action = act.ActivateCopyMode },
    
    -- Search
    { key = 'f', mods = 'CMD|SHIFT', action = act.Search { CaseSensitiveString = '' } },
    
    -- Zoom pane
    { key = 'z', mods = 'CMD|SHIFT', action = act.TogglePaneZoomState },
    
    -- Show launcher
    { key = 'l', mods = 'CMD|SHIFT', action = act.ShowLauncher },
    
    -- Reload configuration
    { key = 'r', mods = 'CMD|SHIFT', action = act.ReloadConfiguration },
}

-- Mouse bindings
config.mouse_bindings = {
    -- Right click paste
    {
        event = { Up = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = act.PasteFrom 'Clipboard',
    },
    -- Middle click paste
    {
        event = { Up = { streak = 1, button = 'Middle' } },
        mods = 'NONE',
        action = act.PasteFrom 'PrimarySelection',
    },
}

return config
