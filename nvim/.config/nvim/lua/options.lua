require("nvchad.options")
require("options-link")
local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.relativenumber = true
opt.number = true
vim.opt.title = true
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.backup = false -- creates a backup file
opt.showcmd = true -- show command in last line of the screen
opt.cmdheight = 1 -- height of the command bar
opt.laststatus = 3 -- global statusline
opt.expandtab = true -- convert tabs to spaces
opt.scrolloff = 10 -- is one of my fav
opt.shell = "fish"
opt.inccommand = "split"
opt.backupskip = "/tmp/*,/private/tmp/*"
opt.ignorecase = true -- ignore case when searching
opt.smarttab = true -- tab respects 'tabstop'
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.breakindent = true -- set indent on newline
opt.backspace = "indent,eol,start" -- backspace through everything in insert mode
opt.path:append({ "**" }) -- finding files - search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })

opt.mouse = "a" -- enable mouse support
opt.wrap = false -- display lines as one long line(default: truet)
opt.linebreak = true -- Companion to wrap, don't split words (default: false)

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.cursorline = true -- highlight the current line

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- opt.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed
-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitkeep = "cursor" -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- folding options
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"
-- opt.foldmethod = "indent"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = ""
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

--
-- カーソル行の背景色を変更
vim.cmd([[
   highlight CursorLine guibg= #323449
 ]])

-- カーソル行の強調表示を有効にする
opt.cursorline = true
-- opt.cursorcolumn = true
opt.ruler = true
opt.cursorlineopt = "both" -- to enable cursorline!

-- json
-- local vcmd = vim.cmd
-- vcmd("set conceallevel=0")
-- vcmd("set foldmethod=syntax")
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  -- This allows me to use cmd+v to paste stuff into neovide
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

  -- Specify the font used by Neovide
  -- vim.o.guifont = "MesloLGM_Nerd_Font:h14"
  vim.o.guifont = "CodeNewRoman Nerd Font Mono:h15"
  -- vim.o.guifont = "JetBrainsMono Nerd Font:h15"
  -- This is limited by the refresh rate of your physical hardware, but can be
  -- lowered to increase battery life
  -- This setting is only effective when not using vsync,
  -- for example by passing --no-vsync on the commandline.
  --
  -- NOTE: vsync is configured in the neovide/config.toml file, I disabled it and set
  -- this to 120 even though my monitor is 75Hz, had a similar case in wezterm,
  -- see: https://github.com/wez/wezterm/issues/6334
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  -- This is how fast the cursor animation "moves", default 0.06
  vim.g.neovide_cursor_animation_length = 0.04
  -- Default 0.7
  vim.g.neovide_cursor_trail_size = 0.7
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  -- vim.g.neovide_cursor_vfx_mode = "torpedo"
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
  -- vim.g.neovide_cursor_vfx_mode = "ripple"
  -- vim.g.neovide_cursor_vfx_mode = "wireframe"
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 9.0
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
  vim.g.neovide_cursor_vfx_particle_phase = 1.5
  vim.g.neovide_cursor_vfx_particle_curl = 1.0
  -- produce particles behind the cursor, if want to disable them, set it to ""

  -- Really weird issue in which my winbar would be drawn multiple times as I
  -- scrolled down the file, this fixed it, found in:
  -- https://github.com/neovide/neovide/issues/1550
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_for_lines = 5

  -- This allows me to use the right "alt" key in macOS, because I have some
  -- neovim keymaps that use alt, like alt+t for the terminal
  -- https://youtu.be/33gQ9p-Zp0I
  vim.g.neovide_input_macos_option_key_is_meta = "only_right"

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_floating_corner_radius = 0.3
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10

  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_redius = 5

  vim.g.neovide_show_border = true
  -- プロファイラを有効にする
  vim.g.neovide_profiler = false
  -- ウィンドウサイズを記憶
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_theme = "auto"

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.g.neovide_remember_window_size = true
  ---- IMEの設定
  -- local function set_ime(args)
  --   if args.event:match("Enter$") then
  --     vim.g.neovide_input_ime = true
  --   else
  --     vim.g.neovide_input_ime = false
  --   end
  -- end
  --
  -- local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
  --
  -- vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  --   group = ime_input,
  --   pattern = "*",
  --   callback = set_ime,
  -- })
  --
  -- vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  --   group = ime_input,
  --   pattern = "[/\\?]",
  --   callback = set_ime,
  -- })

  -- vim.g.neovide_background_color = "#24283b"
  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.6
  vim.g.neovide_normal_opacity = 0.6
  vim.g.transparency = 0.6
  --
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5

  -- tokyonight
  -- vim.g.terminal_color_0 = "#1d202f"
  -- vim.g.terminal_color_1 = "#f7768e"
  -- vim.g.terminal_color_2 = "#9ece6a"
  -- vim.g.terminal_color_3 = "#e0af68"
  -- vim.g.terminal_color_4 = "#7aa2f7"
  -- vim.g.terminal_color_5 = "#bb9af7"
  -- vim.g.terminal_color_6 = "#7dcfff"
  -- vim.g.terminal_color_7 = "#a9b1d6"
  -- vim.g.terminal_color_8 = "#414868"
  -- vim.g.terminal_color_9 = "#ff899d"
  -- vim.g.terminal_color_10 = "#9fe044"
  -- vim.g.terminal_color_11 = "#faba4a"
  -- vim.g.terminal_color_12 = "#8db0ff"
  -- vim.g.terminal_color_13 = "#c7a9ff"
  -- vim.g.terminal_color_14 = "#a4daff"
  -- vim.g.terminal_color_15 = "#c0caf5"
  --
  --   catppuccin-moch
  vim.g.terminal_color_0 = "#45475a"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#f5c2e7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#bac2de"
  vim.g.terminal_color_8 = "#585b70"
  vim.g.terminal_color_9 = "#f38ba8"
  vim.g.terminal_color_10 = "#a6e3a1"
  vim.g.terminal_color_11 = "#f9e2af"
  vim.g.terminal_color_12 = "#89b4fa"
  vim.g.terminal_color_13 = "#f5c2e7"
  vim.g.terminal_color_14 = "#94e2d5"
  vim.g.terminal_color_15 = "#a6adc8"

  vim.cmd([[autocmd VimEnter * cd ~/github/workspace/]])
end

vim.opt.guicursor = {
  "n-v-c-sm:block-Cursor", -- Use 'Cursor' highlight for normal, visual, and command modes
  "i-ci-ve:ver25-lCursor", -- Use 'lCursor' highlight for insert and visual-exclusive modes
  "r-cr:hor20-CursorIM", -- Use 'CursorIM' for replace mode
}
