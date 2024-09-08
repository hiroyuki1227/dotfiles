return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
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
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'markdown',
          path = '~/github/markdown',
        },
      },
      disable_frontmatter = true,
      templates = {
        subdir = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M:%S',
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = '250-daily',
        -- folder = "notes/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
      -- name new notes starting the ISO datetime and ending with note name
      -- put them in the inbox subdir
      -- note_id_func = function(title)
      --   local suffix = ""
      --   -- get current ISO datetime with -5 hour offset from UTC for EST
      --   local current_datetime = os.date("!%Y-%m-%d-%H%M%S", os.time() - 5*3600)
      --   if title ~= nil then
      --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      --   else
      --     for _ = 1, 4 do
      --       suffix = suffix .. string.char(math.random(65, 90))
      --     end
      --   end
      --   return current_datetime .. "_" .. suffix
      -- end,

      -- key mappings, below are the defaults
      mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- toggle check-boxes
        -- ["<leader>ch"] = {
        --   action = function()
        --     return require("obsidian").util.toggle_checkbox()
        --   end,
        --   opts = { buffer = true },
        -- },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = {},
        bullets = {},
      },
    },
    {
      'lambdalisue/kensaku.vim',
      dependencies = { 'vim-denops/denops.vim' },
    },
  },
  -- NOTE:bb95dd1b068cd62c68e3ff444ac9acaa7182db7b0336a52d002438615bfdb473
  -- NOTE:Authorization: Bearer bb95dd1b068cd62c68e3ff444ac9acaa7182db7b0336a52d002438615bfdb473
  {
    'oflisback/obsidian-bridge.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian-bridge').setup {
        obsidian_server_address = 'https://localhost:27123',
        scroll_sync = true, -- See of buffer scrolling section below
      }
    end,
    event = {
      'BufReadPre *.md',
      'BufNewFile *.md',
    },
    lazy = true,
  },
}
