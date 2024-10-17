require("nvchad.options")
local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.relativenumber = true
opt.number = true
--
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.mouse = "a" -- enable mouse support
opt.wrap = false -- display lines as one long line(default: truet)
opt.linebreak = true -- Companion to wrap, don't split words (default: false)

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

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
opt.foldmethod = "indent"
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
--

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
