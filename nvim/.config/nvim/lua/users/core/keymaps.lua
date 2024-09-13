vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffer management
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" }) -- delete buffer
keymap.set("n", "<leader>bD", "<cmd>%bdelete<CR>", { desc = "Delete all buffers" }) -- delete all buffers
keymap.set("n", "<leader>ba", "<cmd>%bd<CR>", { desc = "Delete all buffers except current" }) -- delete all buffers except current
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Go to next buffer" }) -- go to next buffer
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" }) -- go to previous buffer
-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
-- vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)

-- toggle line wrapping
keymap.set("n", "<leader>lw", "<cmd>set warp!<CR>", { desc = "toggle line wrapping" })
--
-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "clear search highlight" })

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<Down>", ":resize +2<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })
