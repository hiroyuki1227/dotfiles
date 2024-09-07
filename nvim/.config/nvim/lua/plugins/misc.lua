-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- tmux & split window navigation
    'christoomey/vim-tmux-navigator',
  },
  {
    -- autoclose tags
    'windwp/nvim-ts-autotag',
  },
  {
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      -- import nvim-autopairs
      local autopairs = require 'nvim-autopairs'

      -- configure autopairs
      autopairs.setup {
        check_ts = true,                      -- enable treesitter
        ts_config = {
          lua = { 'string' },                 -- don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' }, -- don't add pairs in javscript template_string treesitter nodes
          java = false,                       -- don't check treesitter on java
        },
      }

      -- import nvim-autopairs completion functionality
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

      -- import nvim-cmp plugin (completions plugin)
      local cmp = require 'cmp'

      -- make autopairs and completion work together
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- high-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
}
