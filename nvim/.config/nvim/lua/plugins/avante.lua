return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
  },
  config = function()
    require("avante_lib").load()
    require("avante").setup({
      opts = {
        provider = "claude",
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- timeout in milliseconds
          temperature = 0, -- adjust if needed
          max_tokens = 4096,
        },
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-7-sonnet",
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
          disable_tools = true, -- disable tools!
        },
        ollama = {
          endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
          model = "qwq:32b",
        },

        auto_suggestions_provider = "copilot", -- 一応設定しておく
        file_selector = {
          provider = "telescope",
        },
        behaviour = {
          auto_suggestions = false, -- 試験的機能につき無効化を推奨
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = true,
          minimize_diff = true,
        },
        windows = {
          position = "right",
          wrap = true,
          width = 30,
          sidebar_header = {
            enabled = true,
            align = "right",
            rounded = false,
          },
          input = {
            height = 5,
          },
          edit = {
            border = "single",
            start_insert = true,
          },
          ask = {
            floating = true,
            start_insert = true,
            border = "single",
          },
        },
      },
    })
  end,

  {
    -- support for image pasting
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = true,
      },
    },
  },
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
