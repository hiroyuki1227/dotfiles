-- lua/plugins/harpoon.lua
return {
  -- 必須の依存プラグイン
  { "nvim-lua/plenary.nvim" },
  -- Harpoonの設定
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      -- キーマッピング
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ha",
        '<cmd>lua require("harpoon.mark").add_file()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>hm",
        '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>h1",
        '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>h2",
        '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>h3",
        '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>h4",
        '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
        { noremap = true, silent = true }
      )

      -- TelescopeとHarpoonの連携設定
      require("telescope").load_extension("harpoon")

      -- TelescopeでHarpoonを呼び出すキーマッピング
      vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>Telescope harpoon marks<CR>", { noremap = true, silent = true })
    end,
  },
  -- Telescopeの設定
  { "nvim-telescope/telescope.nvim" },
}
