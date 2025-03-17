-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	term = "wezterm",

	-- default_prog = {
	-- 	"/opt/homebrew/bin/zsh",
	-- 	"--login",
	-- 	"-c",
	-- 	[[
	--    if command -v tmux >/dev/null 2>&1; then
	--      tmux attach || tmux new;
	--    else
	--      exec zsh;
	--    fi
	--    ]],
	-- },

	window_decorations = "RESIZE",
	-- color_scheme = "Solarized (dark) (terminal.sexy)",
	-- color_scheme = "Solarized Osaka",
	-- color_scheme_dirs = { "~/.config/wezterm/themes" },
	-- color_scheme = "Solarized Osaka",
	colors = {
		foreground = "#839395",
		background = "#001419",
		cursor_bg = "#839395",
		cursor_border = "#839395",
		cursor_fg = "#001419",
		selection_bg = "#1a6397",
		selection_fg = "#839395",
		ansi = { "#001014", "#db302d", "#849900", "#b28500", "#268bd3", "#d23681", "#29a298", "#9eabac" },
		brights = { "#001419", "#db302d", "#849900", "#b28500", "#268bd3", "#d23681", "#29a298", "#839395" },
		["tab_bar"] = {
			inactive_tab_edge = "#002c38",
			background = "#191b28",
			["active_tab"] = {
				bg_color = "#2b8bd3",
				fg_color = "#001419",
			},
			["inactive_tab"] = {
				bg_color = "#002c38",
				fg_color = "#063540",
			},
			["inactive_tab_hover"] = {
				bg_color = "#002c38",
				fg_color = "#268bd3",
			},
			["new_tab_hover"] = {
				fg_color = "#002c38",
				bg_color = "#268bd3",
			},
			["new_tab"] = {

				fg_color = "#268bd3",
				bg_color = "#191b28",
			},
		},
		-- ["metadata"] = {
		-- 	aliases = "Solarized Osaka",
		-- 	authors = "caftzdog",
		-- 	name = "Solarized Osaka",
		-- },
	},
	initial_rows = 60,
	initial_cols = 200,

	-- font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),

	font = wezterm.font_with_fallback({
		{ family = "CodeNewRoman Nerd Font", weight = "Bold", stretch = "Normal", style = "Normal" },
		{ family = "UDEV Gothic NF", weight = "Bold", stretch = "Normal", style = "Normal" },
		{ family = "JetBrains Nerd Font", weight = "Bold", stretch = "Normal", style = "Normal" },
	}),

	font_size = 15,
	line_height = 1.2,

	enable_tab_bar = false,

	window_close_confirmation = "NeverPrompt",
	cursor_blink_ease_out = "Constant",
	cursor_blink_ease_in = "Constant",
	cursor_blink_rate = 400,

	window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	},

	window_background_opacity = 0.7,
	macos_window_background_blur = 20,
	max_fps = 120,
	prefer_egl = true,

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
