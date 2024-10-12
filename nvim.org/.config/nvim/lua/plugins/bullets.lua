return {
  "bullets-vim/bullets.vim",
  config = function()
    vim.g.bullets_enabled_file_types = {
      "markdown",
      "text",
      "gitcommit",
      "scratch",
      "org",
    }
  end,
}
