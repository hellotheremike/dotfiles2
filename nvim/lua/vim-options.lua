local map = vim.api.nvim_set_keymap
local opts = { noremap = false, silent = true }

vim.keymap.set("n", "<A-->", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-+>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-->", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move block down" })
vim.keymap.set("v", "<A-+>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move block up" })

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"
map("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.cmd("set number")
vim.cmd("set relativenumber")
vim.opt.swapfile = false

vim.keymap.set("n", "<leader>n", function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
  end
end, { desc = "Toggle line numbers" })

local function rgfzf()
  local cmd = [[zsh -i -c 'rgfzf']]


  -- Run the shell function and capture its output
  local handle = io.popen(cmd, "r")
  if not handle then
    vim.notify("Failed to run rgfzf", vim.log.levels.ERROR)
    return
  end

  local result = handle:read("*a")
  handle:close()

  -- Trim whitespace
  result = vim.trim(result or "")
  if result == "" then
    vim.notify("No file selected", vim.log.levels.INFO)
    return
  end

  -- Extract filename and line number
  local filename, lineno = result:match("^(.-):(%d+)$")
  if not filename then
    filename = result
    lineno = nil
  end

  -- Open the file
  vim.cmd("edit " .. vim.fn.fnameescape(filename))

  -- Jump to line number if available
  if lineno then
    vim.cmd(tostring(lineno))
  end
end

-- Create a user command
vim.api.nvim_create_user_command("Rgfzf", rgfzf, {})

-- Optional keymap
vim.keymap.set("n", "<leader>r", rgfzf, { desc = "Run rgfzf search" })
