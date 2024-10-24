-- install without yarn or npm
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
  build = function()
    vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim")
    vim.fn["mkdp#util#install"]()
  end,
}
-- "iamcco/markdown-preview.nvim",
-- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
-- ft = { "markdown" },
-- build = function()
-- vim.fn["mkdp#util#install"]()
-- end,
-- }

-- -- install with yarn or npm
-- {
--   "iamcco/markdown-preview.nvim",
--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--   build = "cd app && yarn install",
--   init = function()
--     vim.g.mkdp_filetypes = { "markdown" }
--   end,
--   ft = { "markdown" },
-- },
