return {
  { lazy = true, "nvim-lua/plenary.nvim" },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require("nvchad")
    end,
  },
  "nvchad/volt",
  {
    "nvchad/menu",
    lazy = false,
    -- mouse users + nvimtree users!
    vim.keymap.set("n", "<RightMouse>", function()
      vim.cmd.exec('"normal! \\<RightMouse>"')

      local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
      require("menu").open(options, { mouse = true })
    end, {}),
  },

  { "nvchad/minty", cmd = { "Huefy", "Shades" } },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require("nvchad.icons.devicons") }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("configs.nvim-tree")
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  -- formatting!
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { lua = { "stylua" } },
    },
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require("nvchad.configs.gitsigns")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "tsx",
      "jsx",
      "scss",
      "html",
      "markdown",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvchad/configs.treesitter")
      require("configs.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("configs.nvim-treesitter-text-objects")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        trim_scope = "outer",
        line_numbers = true,
        multiple_lines = true,
        multiline_threshold = 10,
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
          },
        },
        zindex = 25,
        mode = "cursor", -- set to `false` to disable
        max_lines = 3,
        separator = nil, -- set to `ni-l` to disable
      })

      -- 背景色の変更
      vim.cmd([[
        highlight TreesitterContext  guibg= #2E3440
      ]])
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "saadparwaiz1/cmp_luasnip",
  --     "hrsh7th/cmp-nvim-lua",
  --     "onsails/lspkind.nvim",
  --   },
  --   config = function()
  --     require("configs.cmp")
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
      -- require("nvchad.mason").install_all()
      require("configs.mason-lspconfig")
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    optional = true,
    config = function()
      require("configs.lint")
    end,
  },

  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      require("configs.mason-lint")
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("configs.conform")
    end,
  },

  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "conform.nvim" },
    config = function()
      require("configs.mason-conform")
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require("configs.null-ls")
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = {
      position = "right",
    },
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "User FilePost",
  --   opts = {
  --     indent = { char = "│", highlight = "IblChar" },
  --     scope = { char = "│", highlight = "IblScopeChar" },
  --   },
  --   config = function(_, opts)
  --     dofile(vim.g.base46_cache .. "blankline")
  --
  --     local hooks = require("ibl.hooks")
  --     hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  --     require("ibl").setup(opts)
  --
  --     dofile(vim.g.base46_cache .. "blankline")
  --   end,
  -- },
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = {
      startVisible = true,
      showBlankVirtLine = true,
      highlightColor = { link = "Comment" },
      hints = {
        Caret = { text = "^", prio = 2 },
        Dollar = { text = "$", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
      },
      disabled_fts = {
        "startify",
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "nvdash", "nvcheatsheet" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
      -- enable comment
      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
}
