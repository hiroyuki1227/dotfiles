-- Conditional settings based on mode
if vim.g.neovim_mode == "skitty" then
  vim.opt.laststatus = 2
  vim.opt.statusline = "%m"

  -- Line numbers
  vim.opt.number = false
  vim.opt.relativenumber = false

  -- Disable the gutter
  vim.opt.signcolumn = "no"

  -- Text width and wrapping
  vim.opt.textwidth = 28

  vim.opt.linebreak = false
  vim.opt.wrap = false

  -- No colorcolumn in skitty
  vim.opt.colorcolumn = ""

  local colors = require("configs.colors")
  vim.cmd(string.format([[highlight WinBar1 guifg=%s]], colors["linkarzu_color03"]))
  -- -- Set the winbar to display "skitty-notes" with the specified color
  -- vim.opt.winbar = "%#WinBar1#   skitty-notes%*"
  -- Set the winbar to display the current file name on the left and "linkarzu" aligned to the right
  vim.opt.winbar = "%#WinBar1# %t%*%=%#WinBar1# %*"
else
  vim.opt.textwidth = 120
  vim.opt.colorcolumn = "120"

  local colors = require("configs.colors")
  vim.cmd(string.format([[highlight WinBar1 guifg=%s]], colors["linkarzu_color03"]))
  vim.cmd(string.format([[highlight WinBar2 guifg=%s]], colors["linkarzu_color02"]))
  vim.cmd(string.format([[highlight WinBar3 guifg=%s gui=bold]], colors["linkarzu_color24"]))
  -- Function to get the full path and replace the home directory with ~
  local function get_winbar_path()
    local full_path = vim.fn.expand("%:p:h")
    return full_path:gsub(vim.fn.expand("$HOME"), "~")
  end
  -- Function to get the number of open buffers using the :ls command
  local function get_buffer_count()
    local buffers = vim.fn.execute("ls")
    local count = 0
    -- Match only lines that represent buffers, typically starting with a number followed by a space
    for line in string.gmatch(buffers, "[^\r\n]+") do
      if string.match(line, "^%s*%d+") then
        count = count + 1
      end
    end
    return count
  end
  -- Function to update the winbar
  local function update_winbar()
    local home_replaced = get_winbar_path()
    local buffer_count = get_buffer_count()
    vim.opt.winbar = "%#WinBar1#%m "
      .. "%#WinBar2#("
      .. buffer_count
      .. ") "
      -- this shows the filename on the left
      .. "%#WinBar3#"
      .. vim.fn.expand("%:t")
      -- This shows the file path on the right
      .. "%*%=%#WinBar1#"
      .. home_replaced
    -- I don't need the hostname as I have it in lualine
    -- .. vim.fn.systemlist("hostname")[1]
  end
  -- Autocmd to update the winbar on BufEnter and WinEnter events
  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    callback = update_winbar,
  })
end

vim.opt.conceallevel = 0

-- Function to get the model of my mac, can be used by copilot-chat plugin
local function get_computer_model()
  local ok, handle = pcall(io.popen, "sysctl -n hw.model")
  if not ok or not handle then
    return nil
  end
  local result = handle:read("*a")
  handle:close()
  if result then
    return result:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace
  end
  return nil
end
-- Store the computer model globally
_G.COMPUTER_MODEL = get_computer_model()
-- Compute the Copilot model based on the computer model
_G.COPILOT_MODEL = _G.COMPUTER_MODEL == "MacBookPro18,2" and "gpt-4o" or "claude-3.5-sonnet"
-- Optional: Create a command to show the computer model
vim.api.nvim_create_user_command("ShowComputerModel", function()
  local model = _G.COMPUTER_MODEL or "Unknown"
  print("Computer Model: " .. model)
end, {})

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false })
    end
  end,
})

vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
  "localoptions",
}

vim.opt.spelllang = { "jp", "en" }
