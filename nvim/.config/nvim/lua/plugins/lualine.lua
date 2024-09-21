-- Set lualine as statusline
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local mode = {
      "mode",
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return " " .. str
      end,
    }

    local filename = {
      "filename",
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path 3 = Absolute path, with tilde as the home directory 4: Filename and parent dir, with tilde as the home directory
      shorting_target = 40, -- Shortens path to leave 30 spaces in the window
      symbols = {
        modified = "  ", -- Text to show when the file is modified
        readonly = "  ", -- Text to show when the file is non-modifiable or readonly
        unnamed = "[No Name]", -- Text to show for unnamed buffers
        newfile = " ", -- Text to show for new created file before first write
      },
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        -- theme = "auto", -- Set theme based on environment variable
        -- theme = "tokyonight-moon", -- Set theme based on environment variable
        -- theme = "solarized-osaka", -- Set theme based on environment variable
        -- theme = onedark_theme, -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        component_separators = "",
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = {
          { "branch" },
          {
            function()
              return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
            end,
            padding = { right = 1, left = 1 },
            separator = { left = "", right = "" },
          },
        },
        lualine_c = { filename },
        lualine_x = {
          diagnostics,
          diff,
          { "encoding", cond = hide_in_width },
          { "filetype", cond = hide_in_width },
        },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "fugitive" },
    })
  end,
}
