-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	term = "wezterm",

	default_prog = {
		"/opt/homebrew/bin/zsh",
		"--login",
		"-c",
		[[
    if command -v tmux >/dev/null 2>&1; then
      tmux attach || tmux new;
    else
      exec zsh;
    fi
    ]],
	},

	window_decorations = "RESIZE",
	color_scheme = "Catppuccin Mocha",
	-- color_scheme = "tokyonight",
	initial_rows = 50,
	initial_cols = 120,

	font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	font_size = 15,
	line_height = 1.0,

	enable_tab_bar = false,

	window_close_confirmation = "NeverPrompt",
	cursor_blink_ease_out = "Constant",
	cursor_blink_ease_in = "Constant",
	cursor_blink_rate = 400,

	window_padding = {
		left = 2,
		right = 2,
		top = 5,
		bottom = 5,
	},

	window_background_opacity = 0.8,
	macos_window_background_blur = 20,

	hyperlink_rules = {
		{
			regex = "\\b\\w+://\\S+",
			format = "$0",
		},
		{
			regex = "\\bfile://\\S+",
			format = "$0",
		},
		{
			regex = "\\b\\w+@\\S+",
			format = "$0:80",
		},
	},

	keys = {
		{
			key = "f",
			mods = "CTRL|CMD",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
		{
			-- Click-click will open the link under the mouse cursor
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}

return config
