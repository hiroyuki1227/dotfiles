local nvimtree = require("nvim-tree")

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.2 -- You can change this too

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local options = {
  vim.cmd([[
    nnoremap - :NvimTreeToggle<CR>
  ]]),

  -- vim.g.loaded_netrw = 1
  -- vim.g.loaded_netrwPlugin = 1

  -- vim.opt.termguicolors = true

  nvimtree.setup({
    -- loaded_netrw = true,
    -- loaded_netrwPlugin = true,
    -- termguicolors = true,
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    view = {
      relativenumber = true,
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = 0
          -- local center_x = (screen_w - window_w) / 2
          local center_y = 0
          -- local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
    },
    -- filters = {
    --   custom = { "^.git$" },
    -- },
    -- renderer = {
    --   indent_width = 1,
    -- },
  }),
  vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" }),
}

return options
