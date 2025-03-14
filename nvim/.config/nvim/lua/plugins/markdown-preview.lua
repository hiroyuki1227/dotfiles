return {
  -- install with yarn or npm-- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>msp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
      { "<leader>mss", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
      { "<leader>msx", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
    },
  },
}
