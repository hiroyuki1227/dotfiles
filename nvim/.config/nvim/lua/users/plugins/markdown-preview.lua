-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
--
-- Link to github repo
-- https://github.com/iamcco/markdown-preview.nvim

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  lazy = false,
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
}
