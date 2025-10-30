local wezterm = require("wezterm")
-- local sessionizer = require("lua.sessionizer")
local config = wezterm.config_builder()

-- appearance
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 17
config.color_scheme = "rose-pine"
config.colors = {
    -- background = "#000",  -- commented out to allow background image to show
    cursor_bg = "#9B96B5",
    cursor_fg = "#1a1a1e",
    cursor_border = "#9B96B5",
}
config.window_padding = {
    left = 18,
    right = 15,
    top = 20,
    bottom = 5,
}
config.window_background_image = "/home/gc4str0/Pictures/Wallpapers/659468.jpg"
config.window_background_image_hsb = {
    brightness = 0.1,  -- very dark for better readability
    hue = 1.0,
    saturation = 1.0,   -- keep original colors
}

config.max_fps = 120
config.animation_fps = 120
config.front_end = "WebGpu"
config.prefer_egl = true


config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0" }

-- mapping ctrl a to leader similar to tmux prefix
config.leader = { key = "a" , mods = "CTRL" , timeout_milliseconds = 1000 }
config.keys = {
    -- {
    --     key = "f",
    --     mods = "CTRL",
    --     action = wezterm.action_callback(sessionizer.toggle)
    -- },
    -- Key bindings for word navigation
    {
        key = "LeftArrow",
        mods = "ALT",
        action = wezterm.action({ SendString = "\x1bb" }),
    },
    {
        key = "RightArrow",
        mods = "ALT",
        action = wezterm.action({ SendString = "\x1bf" }),
    },
    -- programming workspace with leader v
    {
        key = "v",
        mods = "LEADER",
        action = wezterm.action.SwitchToWorkspace {
            name = "main-cs",
            spawn = {
                cwd = "~/Desktop/main-cs",
                args = {
                    "nvim",
                    "~/Desktop/main-cs",
                    "-c",
                    "lua vim.api.nvim_set_current_dir(\"~/Desktop/main-cs\")"
                },
            },
        },
    },
}


return config
