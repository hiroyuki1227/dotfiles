--@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "catppuccin" },
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
  cmd = {
    style = "atom_colored",
    icons_left = true,
    format_color = {
      tailwind = true,
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
