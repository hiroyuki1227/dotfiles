-- Lazy.nvim用の設定
return {
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.2",
    config = function()
      local distant = require "distant"

      -- distantのセットアップ
      distant.setup {
        ["*"] = {
          timeout = 30,
          log = {
            level = "info",
            file = "/path/to/distant.log",
          },
          binary = "/usr/local/bin/distant",
        },
      }

      -- 環境変数からホスト名とリモートパスを取得する関数
      local function get_host_and_path_from_env()
        local host = vim.loop.os_getenv "REMOTE_HOST" or "localhost:3000"
        local path = vim.loop.os_getenv "REMOTE_PATH" or "/home/ubuntu"
        return host, path
      end

      local map = vim.api.nvim_set_keymap
      -- 接続用のキーマップ（環境変数からホストとリモートパスを取得）
      vim.api.nvim_set_keymap("n", "<leader>dc", "", {
        noremap = true,
        silent = true,
        callback = function()
          local host, path = get_host_and_path_from_env()
          if host ~= nil and path ~= nil then
            -- リモートホストへの接続
            vim.cmd("DistantLaunch " .. host)
            print("Connected to " .. host .. " at " .. path)
            -- リモートパスを開く
            vim.cmd("DistantOpen " .. path)
          else
            print "REMOTE_HOST or REMOTE_PATH is not set"
          end
        end,
      })
      --  { desc = "[Distant] Connect to remote host and open remote path" })

      -- 切断用のキーマップ
      vim.api.nvim_set_keymap("n", "<leader>dd", "", {
        noremap = true,
        silent = true,
        callback = function()
          -- リモートセッションを停止
          vim.cmd "DistantStop"
          print "Disconnected from remote host"
        end,
      })
      -- { desc = "[Distant] Disconnect from remote host" })

      -- クリーンアップ用のキーマップ（セッションのクリーン）
      vim.api.nvim_set_keymap("n", "<leader>dx", "", {
        noremap = true,
        silent = true,
        callback = function()
          -- セッションをクリーンアップ
          vim.cmd "DistantClean"
          print "Cleaned up distant sessions"
        end,
      })
      --  { desc = "[Distant] Clean up distant sessions" })
    end,
  },
}
