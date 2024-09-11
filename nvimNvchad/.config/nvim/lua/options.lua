require "nvchad.options"
local o = vim.o

-- turn on termguicolors for solarized_dark/tokyonight colors to work
o.termguicolors = true
o.background = "dark"
o.signcolumn = "yes"

o.foldmethod = "indent" -- fold based on indent
o.foldlevel = 99 -- don't fold by defaults
o.foldcolumn = "1" -- '0' is not bat
o.foldenable = true -- enable folding
o.foldlevelstart = 99 -- open all folds
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
