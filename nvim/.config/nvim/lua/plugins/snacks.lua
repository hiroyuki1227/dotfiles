-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/snacks.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/snacks.lua

-- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md

-- NOTE: If you experience an issue in which you cannot select a file with the
-- snacks picker when you're in insert mode, only in normal mode, and you use
-- the bullets.vim plugin, that's the cause, go to that file to see how to
-- resolve it
-- https://github.com/folke/snacks.nvim/issues/812
-- TODO

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- I don't want to use the default keymaps
    keys = {
      -- Open git log in vertical view
      {
        "<leader>lg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>es",
        function()
          require("snacks").explorer({
            hidden = true,
          })
        end,
        desc = "Snacks Explorer",
      },
      {
        "<leader>gl",
        function()
          require("snacks").picker.git_log({
            -- Snacks.picker.git_log({
            finder = "git_log",
            format = "git_log",
            preview = "git_show",
            confirm = "git_checkout",
            layout = "vertical",
          })
        end,
        desc = "Git Log",
      },
      {
        "<leader>rN",
        function()
          require("snacks").rename.rename_file()
        end,
        desc = "Fast Rename Current File",
      },
      {
        "<leader>dB",
        function()
          require("snacks").bufdelete()
        end,
        desc = "Delete or Close Buffer  (Confirm)",
      },

      -- Snacks Picker
      {
        "<leader>pf",
        function()
          require("snacks").picker.files()
        end,
        desc = "Find Files (Snacks Picker)",
      },
      {
        "<leader>pc",
        function()
          require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>pk",
        function()
          require("snacks").picker.keymaps({ layout = "ivy" })
        end,
        desc = "Search Keymaps (Snacks Picker)",
      },
      {
        "<leader>gbr",
        function()
          require("snacks").picker.git_branches({ layout = "ivy" })
        end,
        desc = "Search Git Branches (Snacks Picker)",
      },
      {
        "<leader>th",
        function()
          require("snacks").picker.colorschemes({ layout = "ivy" })
        end,
        desc = "Pick Color Scheme (Snacks Picker)",
      },
      {
        "<leader>vh",
        function()
          require("snacks").picker.help()
        end,
        desc = "Snacks Picker Help",
      },
      {
        "<leader>tt",
        function()
          require("snacks").picker.grep({
            prompt = " ",
            -- pass your desired search as a static pattern
            search = "^\\s*- \\[ \\]",
            -- we enable regex so the pattern is interpreted as a regex
            regex = true,
            -- no “live grep” needed here since we have a fixed pattern
            live = false,
            -- restrict search to the current working directory
            dirs = { vim.fn.getcwd() },
            -- include files ignored by .gitignore
            args = { "--no-ignore" },
            -- Start in normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "grep",
            format = "file",
            show_empty = true,
            supports_live = false,
            layout = "ivy",
          })
        end,
        desc = "[P]Search for incomplete tasks",
      },
      -- -- List git branches with Snacks_picker to quickly switch to a new branch
      {
        "<leader><space>",
        function()
          require("snacks").picker.files({
            -- Snacks.picker.files({
            finder = "files",
            format = "file",
            show_empty = true,
            supports_live = true,
            -- In case you want to override the layout for this keymap
            -- layout = "vscode",
          })
        end,
        desc = "Find Files",
      },
      -- Navigate my buffers
      {
        "<S-h>",
        function()
          require("snacks").picker.buffers({
            -- Snacks.picker.buffers({
            -- I always want my buffers picker to start in normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "buffers",
            format = "buffer",
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
            -- In case you want to override the layout for this keymap
            -- layout = "ivy",
          })
        end,
        desc = "[P]Snacks picker buffers",
      },
    },
    opts = {
      animate = {
        duration = 20,
        enabled = true,
        easing = "linear",
        fps = 60,
      },
      explorer = {
        enabled = true,
        layout = {
          cycle = false,
        },
      },
      -- Documentation for the picker
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
        -- file was always showing at the top, I needed a way to decrease its
        -- score, in frecency you could use :FrecencyDelete to delete a file
        -- from the database, here you can decrease it's score
        transform = function(item)
          if not item.file then
            return item
          end
          -- Demote the "lazyvim" keymaps file:
          if item.file:match("lazyvim/lua/config/keymaps%.lua") then
            item.score_add = (item.score_add or 0) - 30
          end
          -- Boost the "neobean" keymaps file:
          -- if item.file:match("neobean/lua/config/keymaps%.lua") then
          --   item.score_add = (item.score_add or 0) + 100
          -- end
          return item
        end,
        -- In case you want to make sure that the score manipulation above works
        -- or if you want to check the score of each file
        debug = {
          scores = true, -- show scores in the list
        },
        -- I like the "ivy" layout, so I set it as the default globaly, you can
        -- still override it in different keymaps
        layout = {
          preset = "ivy",
          -- When reaching the bottom of the results in the picker, I don't want
          -- it to cycle and go back to the top
          cycle = false,
        },
        layouts = {
          -- I wanted to modify the ivy layout height and preview pane width,
          -- this is the only way I was able to do it
          -- NOTE: I don't think this is the right way as I'm declaring all the
          -- other values below, if you know a better way, let me know
          --
          -- Then call this layout in the keymaps above
          -- got example from here
          -- https://github.com/folke/snacks.nvim/discussions/468
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
          telescope = {
            reverse = true, -- set to false for search bar to be on top
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.8,
              height = 0.9,
              border = "none", -- default is "none"
              {
                box = "vertical",
                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.50,
                border = "rounded",
                title_pos = "center",
              },
            },
          },
          -- I wanted to modify the layout width
          --
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              -- I'm used to scrolling like this in LazyGit
              ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
        },
      },
      -- Folke pointed me to the snacks docs
      -- https://github.com/LazyVim/LazyVim/discussions/4251#discussioncomment-11198069
      -- Here's the lazygit snak docs
      -- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
      lazygit = {
        theme = {
          selectedLineBgColor = { bg = "CursorLine" },
        },
        -- With this I make lazygit to use the entire screen, because by default there's
        -- "padding" added around the sides
        -- I asked in LazyGit, folke didn't like it xD xD xD
        -- https://github.com/folke/snacks.nvim/issues/719
        win = {
          -- -- The first option was to use the "dashboard" style, which uses a
          -- -- 0 height and width, see the styles documentation
          -- -- https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
          -- style = "dashboard",
          -- But I can also explicitly set them, which also works, what the best
          -- way is? Who knows, but it works
          width = 0,
          height = 0,
        },
      },
      notifier = {
        enabled = true,
        top_down = false, -- place notifications from top to bottom
      },
      words = { enabled = true },
      bigfile = { enabled = true },
      scratch = { enabled = true },
      quickfix = { enabled = true, exclude = { "packer" } },
      dashboard = {
        enabled = true,
        lazy = false,
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
