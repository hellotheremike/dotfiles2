local map = vim.api.nvim_set_keymap
local opts = { noremap = false, silent = true }

vim.keymap.set("n", "<A-->", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-+>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-->", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move block down" })
vim.keymap.set("v", "<A-+>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move block up" })

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"
map("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.cmd("set number")
vim.cmd("set relativenumber")
vim.opt.swapfile = false
