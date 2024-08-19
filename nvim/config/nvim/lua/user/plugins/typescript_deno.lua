return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(plugin, opts)
    require("astrocore").extend_tbl(opts, {
      config = {
        denols = {
          root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
        },
        tsserver = {
          root_dir = require("lspconfig.util").root_pattern "package.json",
        },
        -- eslint = {
        --   root_dir = require("lspconfig.util").root_pattern("package.json", ".eslintrc.json", ".eslintrc.js"),
        -- },
      },
    })
  end,
}
