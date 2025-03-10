require("nvchad.mappings")
-- add yours here
local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- save file without auto-formatting
map("n", "<leader>sn", "<cmd>noautocmd w<CR>", { desc = "Save without formatting" })
--
-- delete single character without copying into register
-- map("n", "x", "_x", { desc = "Delete character under cursor" })

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
map("n", "<Esc>", ":noh<CR>", { desc = "clear search highlight" })

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffer management
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" }) -- delete buffer
map("n", "<leader>bD", "<cmd>%bdelete<CR>", { desc = "Delete all buffers" }) -- delete all buffers
map("n", "<leader>ba", "<cmd>%bd<CR>", { desc = "Delete all buffers except current" }) -- delete all buffers except current
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Go to next buffer" }) -- go to next buffer
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" }) -- go to previous buffer
-- vim.map("n", "<Tab>", ":bnext<CR>", opts)
-- vim.map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- toggle line wrapping
map("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "toggle line wrapping" })
--

-- Resize with arrows
map("n", "<Up>", ":resize -2<CR>", { desc = "Resize window up" })
map("n", "<Down>", ":resize +2<CR>", { desc = "Resize window down" })
map("n", "<Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

require("keymaps")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
