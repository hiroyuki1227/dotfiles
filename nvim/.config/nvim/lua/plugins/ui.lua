return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "moll/vim-bbye",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- vim.opt.linespace = 8

      require("bufferline").setup {
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
          numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
          right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
          middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
          -- buffer_close_icon = '󰅖',
          buffer_close_icon = "✗",
          -- buffer_close_icon = '✕',
          close_icon = "",
          path_components = 1, -- Show only the file name without the directory
          modified_icon = "●",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 30,
          max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
          tab_size = 21,
          diagnostics = false,
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          separator_style = { "│", "│" }, -- | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          show_tab_indicators = false,
          indicator = {
            -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = "none", -- Options: 'icon', 'underline', 'none'
          },
          icon_pinned = "󰐃",
          minimum_padding = 1,
          maximum_padding = 5,
          maximum_length = 15,
          sort_by = "insert_at_end",
        },
        highlights = {
          separator = {
            fg = "#434C5E",
          },
          buffer_selected = {
            bold = true,
            italic = false,
          },
          -- separator_selected = {},
          -- tab_selected = {},
          -- background = {},
          -- indicator_selected = {},
          -- fill = {},
        },
      }

      -- Keymaps
      local opts = { noremap = true, silent = true, desc = "Go to Buffer" }
      vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
      vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
      vim.keymap.set("n", "<leader>1", "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
      vim.keymap.set("n", "<leader>2", "<cmd>lua require('bufferline').go_to_buffer(2)<CR>", opts)
      vim.keymap.set("n", "<leader>3", "<cmd>lua require('bufferline').go_to_buffer(3)<CR>", opts)
      vim.keymap.set("n", "<leader>4", "<cmd>lua require('bufferline').go_to_buffer(4)<CR>", opts)
      vim.keymap.set("n", "<leader>5", "<cmd>lua require('bufferline').go_to_buffer(5)<CR>", opts)
      vim.keymap.set("n", "<leader>6", "<cmd>lua require('bufferline').go_to_buffer(6)<CR>", opts)
      vim.keymap.set("n", "<leader>7", "<cmd>lua require('bufferline').go_to_buffer(7)<CR>", opts)
      vim.keymap.set("n", "<leader>8", "<cmd>lua require('bufferline').go_to_buffer(8)<CR>", opts)
      vim.keymap.set("n", "<leader>9", "<cmd>lua require('bufferline').go_to_buffer(9)<CR>", opts)
    end,
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup {
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
