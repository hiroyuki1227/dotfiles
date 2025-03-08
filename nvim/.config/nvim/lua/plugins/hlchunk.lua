return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter", "BufReadPre", "BufNewFile" },

  config = function()
    require("hlchunk").setup({
      chunk = {
        notify = false,
        enable = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "┌",
          left_bottom = "└",
          right_arrow = ">",
        },
        style = "#00ffff",
      },
      indent = { enable = false },
      blank = { enable = false },
      line_num = { enable = false },
    })
  end,
}
