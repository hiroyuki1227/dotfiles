return {
  -- messages, cmdline and the popupmenu
  {
    lazy = true,
    "folke/noice.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      -- add any options here
      -- opts.routes = noice_config.routes
      opts.notify = {
        enabled = true,
        view = "notify",
      }
      opts.messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      }
      opts.redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      }
      opts.presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      }
      opts.lsp = {
        signature = { enabled = false },
      }
    end,

    config = function(_, opts)
      require("noice").setup(opts)
      -- ※ ここは `telescope` 使用される方はお好みで
      require("telescope").load_extension "notify"
      require("telescope").load_extension "noice"
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },

  -- LazyGit integration with Telescope
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- {
  --   require("toggleterm").setup {
  --     size = 100,
  --     open_mapping = [[<c-t>]],
  --     hide_numbers = true,
  --     shade_filetypes = {},
  --     shade_terminals = true,
  --     shading_factor = 2,
  --     start_in_insert = true,
  --     insert_mappings = true,
  --     persist_size = true,
  --     direction = "float",
  --     close_on_exit = true,
  --   },
  -- },
  {
    -- startVisible = true,
    "tris203/precognition.nvim",
    config = {
      -- showBlankVirtLine = true,
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     -- prio is not currently used for gutter hints
      --     G = { text = "G", prio = 1 },
      --     gg = { text = "gg", prio = 1 },
      --     PrevParagraph = { text = "{", prio = 1 },
      --     NextParagraph = { text = "}", prio = 1 },
      -- },
    },
  },
}
