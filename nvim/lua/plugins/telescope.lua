return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  { "nvim-telescope/telescope-fzf-native.nvim", event = "VeryLazy", build = "make" },
  {
    "junegunn/fzf",
    event = "VeryLazy",
    build = ":call fzf#install()",
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",     -- ✅ use master branch instead of tag

    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".git",
            ".next"
          }
        },
        pickers = {
          find_files = {
            hidden = true
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

      require("telescope").load_extension("ui-select")
    end,
  },
}
