--@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "solarized_osaka",
  -- theme = "tokyonight",
  theme_toggle = { "tokyonight", "solarized_osaka" },
  transparency = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  build = function()
    require("base46").load_all_highlights()
  end,
}

M.ui = {
  -- hl_overrides = {
  --   CursorLine = { bg = "one_fg", fg = "one_bg" },
  --   Cursor = { bg = "one_bg", fg = "one_fg" },
  -- },
  statusline = {
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    enabled = true,
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- theme = "minimal",
    separator_style = "round",
  },
  cmp = {
    enabled = true,
    style = "default", -- default/flat_light/flat_dark/atom_colored
    icons_left = true,
    fileds = {
      "kind",
      "abbr",
      "menu",
    },
    format_color = {
      tailwind = true,
      icon = "󱓻",
    },
  },

  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    -- modules = nil,
    modules = {
      abc = function()
        return "hl"
      end,
    },
  },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true, tailwind = true, oklch = true },
  },
}

return M
