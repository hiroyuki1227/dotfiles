return {
  "neovim/nvim-lspconfig", -- LSP設定用プラグイン
  config = function()
    -- eslint-lsp 設定
    require("lspconfig").eslint.setup({
      root_dir = require("lspconfig").util.root_pattern(".eslint.js", ".eslint.cjs", ".eslintrc.json", ".git"),
      settings = {
        format = { enabled = true },
        eslint = {
          enable = true,
          -- Next.js プロジェクトで使用する場合の設定ファイルのパス
          configFile = "./.eslintrc.js", -- プロジェクトのルートに置かれている場合
        },
      },
    })
  end,
}
