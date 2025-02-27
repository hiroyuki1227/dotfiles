-- ~/.config/nvim/lua/custom/plugins/ollama.lua

return {
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Ollama", "OllamaModel", "OllamaServe" },
    keys = {
      { "<leader>oo", ":<c-u>Ollama<cr>", desc = "Ollama プロンプト" },
      { "<leader>oc", ":<c-u>OllamaCheck<cr>", desc = "Ollama 接続確認" },

      -- モデル切り替えのキーマッピング
      { "<leader>om1", ":<c-u>OllamaModel llama3<cr>", desc = "Llama 3に切り替え" },
      { "<leader>om2", ":<c-u>OllamaModel mistral<cr>", desc = "Mistralに切り替え" },
      { "<leader>om3", ":<c-u>OllamaModel gemma<cr>", desc = "Gemmaに切り替え" },
      { "<leader>om4", ":<c-u>OllamaModel codellama<cr>", desc = "CodeLlamaに切り替え" },
      { "<leader>om5", ":<c-u>OllamaModel phi<cr>", desc = "Phiに切り替え" },

      -- モデル一覧を表示するキーマッピング
      {
        "<leader>oml",
        function()
          vim.cmd("OllamaModelList")
          vim.cmd("echo 'インストール済みモデル一覧'")
        end,
        desc = "インストール済みモデル一覧",
      },
    },
    opts = {
      model = "llama3", -- デフォルトモデル
      url = "http://127.0.0.1:11434",
      serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
      },
      -- モデル表示用のカスタム関数
      format = {
        model_names = true,
      },
      -- 各モデルの特性に合わせたシステムプロンプト
      system_prompts = {
        -- モデル別のシステムプロンプト設定
        llama3 = "あなたは有能なAIアシスタントです。簡潔で役立つ回答を提供してください。",
        mistral = "あなたは賢いAIアシスタントです。正確で詳細な回答を心がけます。",
        codellama = "あなたはコーディングの専門家です。最適なコード例と説明を提供します。",
        gemma = "あなたは親切なAIアシスタントです。わかりやすく丁寧に回答します。",
        phi = "あなたは効率的なAIアシスタントです。簡潔かつ的確に回答します。",
      },
    },
    config = function(_, opts)
      require("ollama").setup(opts)

      -- カスタムコマンドを追加: モデル一覧を取得して表示
      vim.api.nvim_create_user_command("OllamaModelList", function()
        local Job = require("plenary.job")
        Job:new({
          command = "ollama",
          args = { "list" },
          on_exit = function(j, return_val)
            if return_val == 0 then
              local result = table.concat(j:result(), "\n")
              vim.defer_fn(function()
                vim.cmd("botright 10split")
                local buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n"))
                vim.api.nvim_buf_set_option(buf, "modifiable", false)
                vim.api.nvim_buf_set_option(buf, "filetype", "text")
                vim.api.nvim_buf_set_name(buf, "Ollama Models")
              end, 0)
            else
              vim.notify("モデル一覧の取得に失敗しました", vim.log.levels.ERROR)
            end
          end,
        }):start()
      end, {})

      -- カスタムコマンドを追加: 新しいモデルをpull
      vim.api.nvim_create_user_command("OllamaPull", function(args)
        if args.args == "" then
          vim.notify("モデル名を指定してください: OllamaPull <model_name>", vim.log.levels.ERROR)
          return
        end

        vim.notify("モデル '" .. args.args .. "' をダウンロード中...", vim.log.levels.INFO)

        local Job = require("plenary.job")
        Job:new({
          command = "ollama",
          args = { "pull", args.args },
          on_exit = function(j, return_val)
            if return_val == 0 then
              vim.notify(
                "モデル '" .. args.args .. "' のダウンロードが完了しました",
                vim.log.levels.INFO
              )
            else
              vim.notify(
                "モデル '" .. args.args .. "' のダウンロードに失敗しました",
                vim.log.levels.ERROR
              )
            end
          end,
        }):start()
      end, {
        nargs = 1,
        complete = function()
          return { "llama3", "mistral", "gemma", "codellama", "phi", "orca-mini", "vicuna", "neural-chat" }
        end,
      })
    end,
  },

  -- gen.nvimプラグインの設定を拡張
  {
    "David-Kunz/gen.nvim",
    cmd = { "Gen" },
    keys = {
      { "<leader>]", ":Gen<cr>", desc = "AI Assistant" },

      -- 特定の用途に特化した生成コマンド
      {
        "<leader>]c",
        function()
          vim.cmd("Gen 'このコードを最適化して、より読みやすくしてください:'")
        end,
        desc = "コード最適化",
      },

      {
        "<leader>]d",
        function()
          vim.cmd("Gen 'このコードの詳細な説明を日本語で書いてください:'")
        end,
        desc = "コード説明",
      },

      {
        "<leader>]t",
        function()
          vim.cmd("Gen 'このコードのテストケースを作成してください:'")
        end,
        desc = "テスト作成",
      },
    },
    opts = {
      model = "llama3", -- デフォルトモデル
      host = "localhost",
      port = "11434",
      display_mode = "float", -- または "buffer"
      show_prompt = false,
      show_model = true,
      no_auto_close = false,
      init_message = "どのように手伝いましょうか？",

      -- モデル切り替えメニュー
      model_selector = function()
        local models = vim.fn.systemlist("ollama list | tail -n +2 | awk '{print $1}'")
        return vim.ui.select(models, { prompt = "モデルを選択:" }, function(model)
          if model then
            return model
          else
            return "llama3" -- デフォルト
          end
        end)
      end,

      command = function(options)
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/generate "
          .. "-d $body",
          {
            body = vim.fn.json_encode({
              model = options.model,
              prompt = options.prompt,
              stream = true,
            }),
          }
      end,
    },
  },
}
