return {
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "rest-nvim/tree-sitter-http" }, -- 必須依存関係
  ft = { "http" }, -- HTTPリクエスト用ファイルタイプでのみロード
  config = function()
    -- rest.nvim の設定
    local ok, rest = pcall(require, "rest-nvim")
    if not ok then
      vim.notify("rest,nvim could not be loaded", vim.log.levels.ERROR)
      return
    end
    rest.setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false, -- 結果を縦分割で表示
      skip_ssl_verification = true, -- SSL検証をスキップ
      highlight = {
        enabled = true, -- ハイライトを有効化
        timeout = 150, -- ハイライトの表示時間 (ms)
      },
      jump_to_request = false, -- リクエスト実行後にカーソルを移動しない

      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        -- show the generated curl command in case you want to launch
        -- the same request via the terminal (can be verbose)
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
        -- table of curl `--write-out` variables or false if disabled
        -- for more granular control see Statistics Spec
        show_statistics = false,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
          end,
        },
      },
    })
    -- キーマッピングの設定
    local keymap = vim.keymap.set -- Neovimの推奨設定方法
    -- local opts = { noremap = true, silent = true, desc = "REST keymap" }

    -- キーマップ
    keymap("n", "<leader>rr", function()
      rest.run()
    end, { noremap = true, silent = true, desc = "Run HTTP request" })
    keymap("n", "<leader>rp", function()
      rest.preview()
    end, { noremap = true, silent = true, desc = "Preview HTTP request" })
    keymap("n", "<leader>rl", function()
      rest.last()
    end, { noremap = true, silent = true, desc = "Run last HTTP request" })
    -- keymap("n", "<leader>rr", "<Plug>RestNvim", opts) -- カーソル位置のリクエストを実行
    -- keymap("n", "<leader>rp", "<Plug>RestNvimPreview", opts) -- リクエストをプレビュー
    -- keymap("n", "<leader>rl", "<Plug>RestNvimLast", opts) -- 最後のリクエストを再実行
  end,
}

-- return {
--   {
--     "rest-nvim/rest.nvim",
--     dependencies = { { "nvim-lua/plenary.nvim" } },lua
--     config = function()
--       require("rest-nvim").setup({
--         -- Open request results in a horizontal split
--         result_split_horizontal = true,
--         -- Keep the http file buffer above|left when split horizontal|vertical
--         result_split_in_place = false,
--         -- stay in current windows (.http file) or change to results window (default)
--         stay_in_current_window_after_split = false,
--         -- Skip SSL verification, useful for unknown certificates
--         skip_ssl_verification = true, -- SSL検証をスキップ
--         -- Encode URL before making request
--         encode_url = true,
--         -- Highlight request on run
--         highlight = {
--           enabled = true,
--           timeout = 150,
--         },
--         result = {
--           -- toggle showing URL, HTTP info, headers at top the of result window
--           show_url = true,
--           -- show the generated curl command in case you want to launch
--           -- the same request via the terminal (can be verbose)
--           show_curl_command = false,
--           show_http_info = true,
--           show_headers = true,
--           -- table of curl `--write-out` variables or false if disabled
--           -- for more granular control see Statistics Spec
--           show_statistics = false,
--           -- executables or functions for formatting response body [optional]
--           -- set them to false if you want to disable them
--           formatters = {
--             json = "jq",
--             html = function(body)
--               return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
--             end,
--           },
--         },
--         -- Jump to request line on run
--         jump_to_request = false,
--         env_file = ".env",
--         custom_dynamic_variables = {},
--         yank_dry_run = true,
--         search_back = true,
--       })
--     end,
--     -- vim.api.nvim_create_autocmd("FileType", {
--     --   pattern = "http",
--     --   callback = function()
--     --     local rest_nvim = require("rest-nvim")
--     --     local buff = tonumber(vim.fn.expand("<abuf>"), 10)
--     --     vim.keymap.set("n", "<leader>rr", rest_nvim.run, { noremap = true, buffer = buff })
--     --     vim.keymap.set("n", "<leader>rl", rest_nvim.last, { noremap = true, buffer = buff })
--     --     vim.keymap.set("n", "<leader>rp", function()
--     --       rest_nvim.run(true)
--     --     end, { noremap = true, buffer = buff })
--     --   end,
--     -- }),
--
--     keys = {
--       {
--         "\\rn",
--         "<Plug>RestNvim",
--         desc = "Test the current file",
--       },
--       {
--
--         "\\rl",
--         "<Plug>RestNvimLast",
--         desc = "Test the previous request",
--       },
--       {
--         "\\rp",
--         "<Plug>RestNvimPreview",
--         desc = "Preview the current request",
--       },
--     },
--   },
-- }
