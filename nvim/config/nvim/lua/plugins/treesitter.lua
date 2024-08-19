-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    -- enable syntax highlighting
    highlight = {
      enable = true,
    },
    -- enable indentation
    indent = {
      enable = true,
    },
    -- enbale autotagging (w/ nvim-ts-autotag plugin)
    autotag = {
      enbale = true,
    },
    -- ensure these language parsers are installed
    ensure_installed = {
      "lua",
      "vim",
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "markdown",
      "markdown_inline",
      "svelte",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gowork",
      "python",
      -- add more arguments for adding more treesitter parsers
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
}
