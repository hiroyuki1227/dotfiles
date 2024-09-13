return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status' -- to configure lazy pending updates count

    local colors = {
      -- blue = "#65D1FF",
      blue = '#82aaff',
      -- green = "#3EFFDC",
      green = '#c3e88d',
      violet = '#fca7ea',
      -- violet = "#FF61EF",
      yellow = '#FFc777',
      -- yellow = "#FFDA7B",

      red = '#FF757f',
      -- red = "#FF4A4A",
      fg = '#c3ccdc',
      -- fg = "#828bb8",
      -- bg = "#112638",
      bg = '#222436',
      bg1 = '#2d3f76',
      inactive_bg = '#2f334d',
      -- inactive_bg = "#2c3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = 'bold' },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'tokyonight'

    -- Define a table of themes
    local themes = {
      mytheme = my_lualine_theme,
      tokyonight = 'tokyonight',
    }

    local mode = {
      'mode',
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return ' ' .. str
      end,
    }

    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
    }
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = themes[env_var_nvim_theme], -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        -- disabled_filetypes = { 'alpha', 'neo-tree' },
        -- always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = '#ff9e64' },
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
