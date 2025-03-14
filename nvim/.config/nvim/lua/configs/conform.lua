local conform = require("conform")
local options = {

  formatters_by_ft = {
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    svelte = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
    -- yaml = { "prettierd","prettier" },
    markdown = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    liquid = { "prettierd", "prettier" },
    lua = { "stylua" },
    python = { "isort", "black" },
    go = { "gofmt" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    -- timeout_ms = 5000,
    timeout_ms = 9999,
  },

  formatters = {
    -- -- C & C++
    -- ["clang-format"] = {
    --     prepend_args = {
    --         "-style={ \
    --                 IndentWidth: 4, \
    --                 TabWidth: 4, \
    --                 UseTab: Never, \
    --                 AccessModifierOffset: 0, \
    --                 IndentAccessModifiers: true, \
    --                 PackConstructorInitializers: Never}",
    --     },
    -- },
    -- -- Golang
    -- ["goimports-reviser"] = {
    --     prepend_args = { "-rm-unused" },
    -- },
    -- golines = {
    --     prepend_args = { "--max-len=80" },
    -- },
    -- -- Lua
    -- stylua = {
    --     prepend_args = {
    --         "--column-width", "80",
    --         "--line-endings", "Unix",
    --         "--indent-type", "Spaces",
    --         "--indent-width", "4",
    --         "--quote-style", "AutoPreferDouble",
    --     },
    -- },
    -- -- Python
    -- black = {
    --     prepend_args = {
    --         "--fast",
    --         "--line-length",
    --         "80",
    --     },
    -- },
    -- isort = {
    --     prepend_args = {
    --         "--profile",
    --         "black",
    --     },
    -- },
  },
  vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end, { desc = "Format file or range (in visual mode)" }),
}

require("conform").setup(options)
