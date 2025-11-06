-- Auto-create unique socket name for this Neovim instance
if vim.fn.empty(vim.fn.getenv("NVIM_LISTEN_ADDRESS")) == 1 then
  local socket_dir = "/tmp/nvim-sockets"
  vim.fn.mkdir(socket_dir, "p")

  local socket_path = socket_dir .. "/nvim-" .. vim.fn.getpid() .. ".sock"
  vim.fn.setenv("NVIM_LISTEN_ADDRESS", socket_path)
  vim.fn.serverstart(socket_path)

  print("Neovim socket started at " .. socket_path)

  -- If we're inside tmux, record this socket path for the current pane
  if vim.fn.exists("$TMUX") == 1 then
    local pane_id = vim.fn.system("tmux display -p '#{pane_id}'"):gsub("\n", "")
    -- Store this socket in a tmux environment variable unique to this pane
    local cmd = { "tmux", "setenv", "NVIM_SOCKET_" .. pane_id, socket_path }
    vim.fn.system(cmd)
  end
end


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("vim-options")
require("lazy").setup("plugins")
require("bar-options")

io.write(vim.fn.stdpath("run"))
