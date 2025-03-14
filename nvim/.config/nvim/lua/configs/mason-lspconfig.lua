local lspconfig = package.loaded["lspconfig"]

-- List of servers to ignore during install
local ignore_install = {}

-- Helper function to find if value is in table.
local function table_contains(table, value)
  for _, v in ipairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

-- Build a list of lsp servers to install minus the ignored list.
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
local all_servers = {}
for _, s in ipairs(servers) do
  if not table_contains(ignore_install, s) then
    table.insert(all_servers, s)
  end
end

require("mason-lspconfig").setup({
  ensure_installed = all_servers,
  automatic_installation = false,
})
