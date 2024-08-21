return {
  -- bb95dd1b068cd62c68e3ff444ac9acaa7182db7b0336a52d002438615bfdb473
  --Authorization: Bearer bb95dd1b068cd62c68e3ff444ac9acaa7182db7b0336a52d002438615bfdb473
  {
    "oflisback/obsidian-bridge.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian-bridge").setup {
        obsidian_server_address = "https://localhost:27123",
        -- scroll_sync = true, -- See of buffer scrolling section below
      }
    end,
    event = {
      "BufReadPre *.md",
      "BufNewFile *.md",
    },
    lazy = true,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          -- path = "~/vaults/personal",
          path = "~/github/markdown/personal",
        },
        {
          name = "work",
          path = "~/github/markdown/work",
          -- path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
    {
      "lambdalisue/kensaku.vim",
      dependencies = { "vim-denops/denops.vim" },
    },
  },
}
