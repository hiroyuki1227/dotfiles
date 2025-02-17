local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")
nvlsp.defaults() -- loads nvchad's defaults

lspconfig.lua_ls.setup({
  settings = {
    lua = {
      runtime = { version = "Lua 5.3" },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

local servers = {
  "ts_ls",
  "eslint",
  "yamlls",
  "pyright",
  "pylsp",
  "prismals",
  "dockerls",
  "docker_compose_language_service",
  "html",
  "cssls",
  "tailwindcss",
  "svelte",
  "graphql",
  "emmet_ls",
  "lua_ls",
  "html",
  "cssls",
  "clangd",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end

lspconfig.graphql.setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetype = { "graphql", "typescript", "typescriptreact", "javascript", "javascriptreact" },
})

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "E501" },
        },
        pyflakes = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        mccabe = { enabled = false },
        pylsp_mypy = { enabled = false },
        pylsp_block = { enabled = false },
        pylsp_isort = { enabled = false },
      },
    },
  },
})

lspconfig.emmet_ls.setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "json",
    "html",
    "svelte",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "tsx",
    "css",
    "html",
    "scss",
    "sass",
  },
})
