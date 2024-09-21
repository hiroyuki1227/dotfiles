local wezterm = require("wezterm")
return {

	-- color_scheme = 'termnial.sexy',
	-- color_scheme = "tokyonight",
	color_scheme = "solarized_osaka_night",
	enable_tab_bar = false,

	-- font = wezterm.font("SpaceMono Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	-- font = wezterm.font("UDEV Gothic NF", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	-- font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	-- font = wezterm.font("Hack Nerd Font Mono"),

	font_size = 15.0,
	-- cell_width = 1.0,
	-- cell_height = 1.0,
	-- line_height = 1.0,
	use_cap_height_to_scale_fallback_fonts = true,

	-- This increases color saturation by 50%
	-- foreground_text_hsb = {
	-- 	hue = 1.0,
	-- 	saturation = 1.0,
	-- 	brightness = 1.2,
	-- },

	-- text_background_opacity = 0.70,
	window_background_opacity = 0.70,
	macos_window_background_blur = 10,
	-- macos_window_background_blur = 10,
	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
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

	-- window_background_gradient = {
	-- Can be "Vertical" or "Horizontal".  Specifies the direction
	-- in which the color gradient varies.  The default is "Horizontal",
	-- with the gradient going from left-to-right.
	-- Linear and Radial gradients are also supported; see the other
	-- examples below
	-- orientation = "Vertical",
	-- orientation = "Horizontal",

	-- Specifies the set of colors that are interpolated in the gradient.
	-- Accepts CSS style color specs, from named colors, through rgb
	-- strings and more
	-- colors = {
	--      "#0f0c29",
	--      "#302b63",
	--      "#24243e",
	--},
	-- colors = {
	-- 	"#0f0c29",
	-- 	"#282a36",
	-- 	"#343746",
	-- 	"#3a3f52",
	-- 	"#343746",
	-- 	"#282a36",
	-- },
	-- colors = { "Inferno" },

	-- Instead of specifying `colors`, you can use one of a number of
	-- predefined, preset gradients.
	-- A list of presets is shown in a section below.
	-- preset = "Warm",

	-- Specifies the interpolation style to be used.
	-- "Linear", "Basis" and "CatmullRom" as supported.
	-- The default is "Linear".
	-- interpolation = "Linear",
	-- interpolation = "CatmullRom",
	--
	-- How the colors are blended in the gradient.
	-- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
	-- The default is "Rgb".
	-- blend = "Rgb",

	-- To avoid vertical color banding for horizontal gradients, the
	-- gradient position is randomly shifted by up to the `noise` value
	-- for each pixel.
	-- Smaller values, or 0, will make bands more prominent.
	-- The default value is 64 which gives decent looking results
	-- on a retina macbook pro display.
	-- noise = 256,

	-- By default, the gradient smoothly transitions between the colors.
	-- You can adjust the sharpness by specifying the segment_size and
	-- segment_smoothness parameters.
	-- segment_size configures how many segments are present.
	-- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
	-- 1.0 is a soft edge.

	-- 	segment_size = 11,
	-- 	segment_smoothness = 1.0,
	-- },
}
