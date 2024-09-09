local wezterm = require("wezterm")
return {

	-- color_scheme = 'termnial.sexy',
	color_scheme = "tokyonight",
	enable_tab_bar = false,
	font_size = 15.0,
	font = wezterm.font("UDEV Gothic NF", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	-- font = wezterm.font("JetBrainsMonoNL Nerd Font"),
	-- font = wezterm.font("Hack Nerd Font Mono"),
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 10,
	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	window_background_opacity = 0.75,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
	-- keys = {
	--   {
	--     key = "f",
	--     mods = "CTRL",
	--     action = wezterm.action.ToggleFullScreen,
	--   },
	-- },
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
