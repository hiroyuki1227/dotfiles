return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup {
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
      separator = nil, -- set to `nil` to disable
    }
  end,
}
