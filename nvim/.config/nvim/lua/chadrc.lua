--@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  theme_toggle = { "solarized_osaka", "tokyonight" },
  transparency = true,
  build = function()
    require("base46").load_all_highlights()
  end,
}

M.ui = {
  hl_overrides = {
    CursorLine = { bg = "one_fg", fg = "one_bg" },
    Cursor = { bg = "one_bg", fg = "one_fg" },
  },
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom_colored
    icons_left = true,
    format_color = {
      tailwind = true,
      hex = true,
      lspkind = true,
      icon = "󱓻",
    },
    -- lazyload it when there are 1+ buffers
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
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual",
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true, tailwind = true, virtual = true },
}

return M
