-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
--
-- Link to github repo
-- https://github.com/iamcco/markdown-preview.nvim

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkDownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  lazy = false,
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_theme = "dark"
  end,
  keys = {
    { "<leader>mo", "<cmd>MarkdownPreview<CR>", desc = "Open Markdown Preview" },
    { "<leader>mc", "<cmd>MarkdownPreviewStop<CR>", desc = "Stop Markdown Preview" },
  },

  -- {
  --   "arminveres/md-pdf.nvim",
  --   branch = "main", -- you can assume that main is somewhat stable until releases will be made
  --   lazy = true,
  --   keys = {
  --     {
  --       "<leader>,",
  --       function()
  --         require("md-pdf").convert_md_to_pdf()
  --       end,
  --       desc = "Markdown preview",
  --     },
  --   },
  --   opts = {},
  -- },
}
-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
--
-- Link to github repo
-- https://github.com/iamcco/markdown-preview.nvim

-- return {
--   "iamcco/markdown-preview.nvim",
--   keys = {
--     {
--       "<leader>mp",
--       ft = "markdown",
--       "<cmd>MarkdownPreviewToggle<cr>",
--       desc = "Markdown Preview",
--     },
--   },
-- }
