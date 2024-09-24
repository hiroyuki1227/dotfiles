-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
-- color_scheme = 'termnial.sexy',
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "solarized_osaka_night"
config.enable_tab_bar = false

-- This is where you actually apply your config choices

-- my coolnight colorscheme
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
-- config.font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Bold", italic = true })
config.font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" })
-- config.font = wezterm.font("UDEV Gothic 35NLG", { weight = "Bold", stretch = "Normal", style = "Normal" })
wezterm.font_with_fallback({
	{ family = "CodeNewRoman Nerd Font" },
	{ family = "UDEV Gothic 35NLG" },
	{ family = "Apple Color Emoji", assume_emoji_presentation = true },
})

wezterm.font_rules = {
	{
		italic = true,
		bolditlic = true,
		font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
	{
		bolditlic = true,
		italic = true,
		font = wezterm.font("UDEV Gothic NF", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
}

config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.70
config.macos_window_background_blur = 10

--
--  Setup Shortc cut keys
local act = wezterm.action
config.keys = {
	-- Ctrl+Shift+f によるフルスクリーン
	{
		key = "f",
		mods = "SHIFT|CTRL",
		action = act.ToggleFullScreen,
	},
	-- Ctrl+Shift+tで新しいタブを作成
	{
		key = "t",
		mods = "SHIFT|CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	-- Ctrl+Shift+dで新しいペインを作成(画面を分割)
	{
		key = "d",
		mods = "SHIFT|CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}
-- and finally, return the configuration to wezterm
return config
