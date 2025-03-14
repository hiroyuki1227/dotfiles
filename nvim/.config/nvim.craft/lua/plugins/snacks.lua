-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/snacks.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/snacks.lua

-- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md

-- NOTE: If you experience an issue in which you cannot select a file with the
-- snacks picker when you're in insert mode, only in normal mode, and you use
-- the bullets.vim plugin, that's the cause, go to that file to see how to
-- resolve it
-- https://github.com/folke/snacks.nvim/issues/812
-- TODO
-- local Snacks = require("snacks")
local icons = require("lib.icons")

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- I don't want to use the default keymaps
		keys = {
			-- Open git log in vertical view
			{
				"<leader>lg",
				function()
					require("snacks").lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>es",
				function()
					require("snacks").explorer({
						hidden = true,
					})
				end,
				desc = "Snacks Explorer",
			},
			{
				"<leader>gl",
				function()
					require("snacks").picker.git_log({
						-- Snacks.picker.git_log({
						finder = "git_log",
						format = "git_log",
						preview = "git_show",
						confirm = "git_checkout",
						layout = "vertical",
					})
				end,
				desc = "Git Log",
			},
			{
				"<leader>rN",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Fast Rename Current File",
			},
			{
				"<leader>dB",
				function()
					require("snacks").bufdelete()
				end,
				desc = "Delete or Close Buffer  (Confirm)",
			},

			-- Snacks Picker
			{
				"<leader>pf",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files (Snacks Picker)",
			},
			{
				"<leader>pc",
				function()
					require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>pk",
				function()
					require("snacks").picker.keymaps({ layout = "vertical" })
				end,
				desc = "Search Keymaps (Snacks Picker)",
			},
			{
				"<leader>gbr",
				function()
					require("snacks").picker.git_branches({ layout = "select" })
				end,
				desc = "Search Git Branches (Snacks Picker)",
			},
			-- {
			--   "<leader>th",
			--   function()
			--     require("snacks").picker.colorschemes({ layout = "ivy" })
			--   end,
			--   desc = "Pick Color Scheme (Snacks Picker)",
			-- },
			{
				"<leader>vh",
				function()
					require("snacks").picker.help()
				end,
				desc = "Snacks Picker Help",
			},
			{
				"<leader>tt",
				function()
					require("snacks").picker.grep({
						prompt = " ",
						-- pass your desired search as a static pattern
						search = "^\\s*- \\[ \\]",
						-- we enable regex so the pattern is interpreted as a regex
						regex = true,
						-- no “live grep” needed here since we have a fixed pattern
						live = false,
						-- restrict search to the current working directory
						dirs = { vim.fn.getcwd() },
						-- include files ignored by .gitignore
						args = { "--no-ignore" },
						-- Start in normal mode
						on_show = function()
							vim.cmd.stopinsert()
						end,
						finder = "grep",
						format = "file",
						show_empty = true,
						supports_live = false,
						layout = "ivy",
					})
				end,
				desc = "[P]Search for incomplete tasks",
			},
			-- -- Iterate throuth completed tasks in Snacks_picker lamw26wmal
			{
				"<leader>tc",
				function()
					require("snacks").picker.grep({ -- Snacks.picker.grep({
						prompt = " ",
						-- pass your desired search as a static pattern
						search = "^\\s*- \\[x\\] `done:",
						-- we enable regex so the pattern is interpreted as a regex
						regex = true,
						-- no “live grep” needed here since we have a fixed pattern
						live = false,
						-- restrict search to the current working directory
						dirs = { vim.fn.getcwd() },
						-- include files ignored by .gitignore
						args = { "--no-ignore" },
						-- Start in normal mode
						on_show = function()
							vim.cmd.stopinsert()
						end,
						finder = "grep",
						format = "file",
						show_empty = true,
						supports_live = false,
						layout = "ivy",
					})
				end,
				desc = "[P]Search for complete tasks",
			},
			{
				"<leader><space>",
				function()
					require("snacks").picker.files({
						-- Snacks.picker.files({
						finder = "files",
						format = "file",
						show_empty = true,
						supports_live = true,
						-- In case you want to override the layout for this keymap
						-- layout = "vscode",
					})
				end,
				desc = "Find Files",
			},
			-- Navigate my buffers
			{
				"<S-h>",
				function()
					require("snacks").picker.buffers({
						-- Snacks.picker.buffers({
						-- I always want my buffers picker to start in normal mode
						on_show = function()
							vim.cmd.stopinsert()
						end,
						finder = "buffers",
						format = "buffer",
						hidden = false,
						unloaded = true,
						current = true,
						sort_lastused = true,
						win = {
							input = {
								keys = {
									["d"] = "bufdelete",
								},
							},
							list = { keys = { ["d"] = "bufdelete" } },
						},
						-- In case you want to override the layout for this keymap
						-- layout = "ivy",
					})
				end,
				desc = "[P]Snacks picker buffers",
			},
		},
		opts = {
			animate = {
				duration = 20,
				enabled = true,
				easing = "linear",
				fps = 60,
			},
			explorer = {
				enabled = true,
				layout = {
					cycle = false,
				},
			},
			picker = {
				transform = function(item)
					if not item.file then
						return item
					end
					-- Demote the "lazyvim" keymaps file:
					if item.file:match("lazyvim/lua/config/keymaps%.lua") then
						item.score_add = (item.score_add or 0) - 30
					end
					return item
				end,
				-- 左側にスコアの数字を表示させる
				-- debug = {
				--   scores = true, -- show scores in the list
				-- },
				layout = {
					preset = "ivy",
					cycle = false,
				},
				layouts = {
					ivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							row = -1,
							width = 0,
							height = 0.5,
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{ win = "input", height = 1, border = "bottom" },
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
							},
						},
					},
					telescope = {
						reverse = true, -- set to false for search bar to be on top
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0.8,
							height = 0.9,
							border = "none", -- default is "none"
							{
								box = "vertical",
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.50,
								border = "rounded",
								title_pos = "center",
							},
						},
					},
					-- I wanted to modify the layout width
					--
					vertical = {
						layout = {
							backdrop = false,
							width = 0.8,
							min_width = 80,
							height = 0.8,
							min_height = 30,
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
						},
					},
				},
				matcher = {
					frecency = true,
				},
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "n", "i" } },
							["J"] = { "preview_scroll_down", mode = { "i", "n" } },
							["K"] = { "preview_scroll_up", mode = { "i", "n" } },
							["H"] = { "preview_scroll_left", mode = { "i", "n" } },
							["L"] = { "preview_scroll_right", mode = { "i", "n" } },
						},
					},
				},
			},
			lazygit = {
				enabled = true,
				theme = {
					selectedLineBgColor = { bg = "CursorLine" },
				},
				win = {
					width = 0,
					height = 0,
				},
			},
			notifier = {
				enabled = true,
				timeout = 2000,
				width = { min = 40, max = 0.4 },
				height = { min = 1, max = 0.6 },
				margin = { top = 0, right = 1, bottom = 0 },
				padding = true,
				sort = { "level", "added" },
				level = vim.log.levels.TRACE,
				icons = {
					debug = icons.ui.Bug,
					error = icons.diagnostics.Error,
					info = icons.diagnostics.Information,
					trace = icons.ui.Bookmark,
					warn = icons.diagnostics.Warning,
				},
				style = "compact",
				-- top_down = true,
				top_down = false,
				date_format = "%R",
				more_format = " ↓ %d lines ",
				refresh = 50,
			},
			words = { enabled = false },
			bigfile = {
				enabled = true,
				notify = true,
				size = 200 * 1024,
			},
			scope = {
				enabled = true,
				keys = {
					textobject = {
						ii = {
							min_size = 2, -- minimum size of the scope
							edge = false, -- inner scope
							cursor = false,
							treesitter = { blocks = { enabled = false } },
							desc = "inner scope",
						},
						ai = {
							cursor = false,
							min_size = 2, -- minimum size of the scope
							treesitter = { blocks = { enabled = false } },
							desc = "full scope",
						},
					},
					jump = {
						["[a"] = {
							min_size = 1, -- allow single line scopes
							bottom = false,
							cursor = false,
							edge = true,
							treesitter = { blocks = { enabled = false } },
							desc = "jump to top edge of scope",
						},
						["]a"] = {
							min_size = 1, -- allow single line scopes
							bottom = true,
							cursor = false,
							edge = true,
							treesitter = { blocks = { enabled = false } },
							desc = "jump to bottom edge of scope",
						},
					},
				},
			},
			scratch = {
				enabled = true,
				name = "SCRATCH",
				ft = function()
					if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
						return vim.bo.filetype
					end
					return "markdown"
				end,
				icon = nil,
				root = vim.fn.stdpath("data") .. "/scratch",
				autowrite = true,
				filekey = {
					cwd = true,
					branch = true,
					count = true,
				},
				win = {
					width = 120,
					height = 40,
					bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
					minimal = false,
					noautocmd = false,
					zindex = 20,
					wo = { winhighlight = "NormalFloat:Normal" },
					border = "rounded",
					title_pos = "center",
					footer_pos = "center",

					keys = {
						["execute"] = {
							"<cr>",
							function(_)
								vim.cmd("%SnipRun")
							end,
							desc = "Execute buffer",
							mode = { "n", "x" },
						},
					},
				},
				win_by_ft = {
					lua = {
						keys = {
							["source"] = {
								"<cr>",
								function(self)
									local name = "scratch."
										.. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
									require("snacks").debug.run({ buf = self.buf, name = name })
								end,
								desc = "Source buffer",
								mode = { "n", "x" },
							},
							["execute"] = {
								"e",
								function(_)
									vim.cmd("%SnipRun")
								end,
								desc = "Execute buffer",
								mode = { "n", "x" },
							},
						},
					},
				},
			},
			bufdelte = { enabled = true },
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign" },
				right = { "fold", "git" },
				folds = {
					open = false,
					git_hl = false,
				},
				git = {
					patterns = { "GitSign", "MiniDiffSign" },
				},
				refresh = 50,
			},
			debug = { enabled = true },
			quickfix = { enabled = true, exclude = { "packer" } },
			dim = {
				enabled = true,
				scope = {
					min_size = 5,
					max_size = 20,
					siblings = true,
				},
				-- animate scopes. Enabled by default for Neovim >= 0.10
				-- Works on older versions but has to trigger redraws during animation.
				animate = {
					enabled = vim.fn.has("nvim-0.10") == 1,
					easing = "outQuad",
					duration = {
						step = 20, -- ms per step
						total = 300, -- maximum duration
					},
				},
				-- what buffers to dim
				filter = function(buf)
					return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
				end,
			},
			git = { enabled = true },
			util = {
				wo = {
					winblend = 0,
				},
				is_transparent = true,
			},
			gitbrowse = { enabled = true },
			styles = {
				snacks_image = {
					relative = "editor",
					col = -1,
				},
			},
			image = {
				enabled = true,
				doc = {
					-- Personally I set this to false, I don't want to render all the
					-- images in the file, only when I hover over them
					-- render the image inline in the buffer
					-- if your env doesn't support unicode placeholders, this will be disabled
					-- takes precedence over `opts.float` on supported terminals
					inline = vim.g.neovim_mode == "skitty" and true or false,
					-- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
					-- render the image in a floating window
					-- only used if `opts.inline` is disabled
					float = true,
					-- Sets the size of the image
					-- max_width = 60,
					max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
					max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
					-- max_height = 30,
					-- Apparently, all the images that you preview in neovim are converted
					-- to .png and they're cached, original image remains the same, but
					-- the preview you see is a png converted version of that image
					--
					-- Where are the cached images stored?
					-- This path is found in the docs
					-- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
					-- For me returns `~/.cache/neobean/snacks/image`
					-- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
				},
			},
			-- dashboard = {
			--   enabled = true,
			--   sections = {
			--     { section = "header" },
			--     {
			--       pane = 2,
			--       section = "terminal",
			--       cmd = "colorscript -e square",
			--       -- cmd = "ascii-image-converter ~/.config/nvim/images/Profile.jpg -C -c",
			--       height = 5,
			--       padding = 1,
			--     },
			--     { section = "keys", gap = 1, padding = 1 },
			--     { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			--     { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			--     {
			--       pane = 2,
			--       icon = " ",
			--       title = "Git Status",
			--       section = "terminal",
			--       enabled = function()
			--         -- return vim.g.sna.git.get_root() ~= nil
			--         return require("snacks").git.get_root() ~= nil
			--       end,
			--       cmd = "git status --short --branch --renames",
			--       height = 5,
			--       padding = 1,
			--       ttl = 5 * 60,
			--       indent = 3,
			--     },
			--     { section = "startup" },
			--   },
			-- },
			dashboard = {
				enabled = true,
				lazy = false,
				sections = {
					{ section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
			zen = {
				enabled = true,
				toggle = {
					dim = true,
					git_signs = false,
					mini_diff_signs = false,
					-- diagnostics = false,
					-- inlay_hints = false,
				},
				show = {
					statusline = false,
					tabline = false,
				},
				win = { style = "zen" },
				zoom = {
					toggles = {},
					show = { statusline = true, tabline = true },
					win = {
						backdrop = { transparent = false }, -- transparent = false,
						width = 120,
					},
				},
			},
		},
	},
}
