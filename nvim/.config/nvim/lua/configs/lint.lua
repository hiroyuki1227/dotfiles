local lint = require("lint")

lint.linters = {
  ["markdownlint-cli2"] = {
    args = { "--config", os.getenv("HOME") .. "/github/dotfiles/markdownlint.yaml", "--" },
  },
}

lint.linters_by_ft = {
  lua = { "luacheck" },
  javascript = { "eslint_d" },
  typescript = { "eslint-lsp", "eslint_d" },
  javascriptreact = { "eslint-lsp", "eslint_d" },
  typescriptreact = { "eslint-lsp", "eslint_d" },
  markdown = { "markdownlint-cli2", "markdown-toc" },
  ["markdown.mdx"] = { "markdownlint-cli2", "markdown-toc" },
  svelte = { "eslint-lsp", "eslint_d" },
  python = { "pylint" },
}
