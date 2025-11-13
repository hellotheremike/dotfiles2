return {
  -- CodeLens to show references etc
  -- {
  --   'VidocqH/lsp-lens.nvim',
  --   config = function()
  --     require 'lsp-lens'.setup({
  --       enable = true,
  --       include_declaration = false, -- Reference include declaration
  --       sections = {
  --         definition = function(count)
  --           return "Definitions: " .. count
  --         end,
  --         references = function(count)
  --           return "References: " .. count
  --         end,
  --         implements = function(count)
  --           return "Implements: " .. count
  --         end,
  --         git_authors = function(latest_author, count)
  --           return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
  --         end,
  --       },
  --       ignore_filetype = {
  --         "prisma",
  --       },
  --     })
  --   end
  -- },
  -- Statusbar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            { "fileformat", "filetype" },
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "fugitive", "quickfix", "fzf", "lazy", "mason", "nvim-dap-ui", "oil", "trouble" },
      })
    end,
  },
  -- Theme
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  -- Highlights the occurance of a word automatically
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate")
    end,
  },
  -- Tmux hjkl navigation in nvim
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({})
      vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
      vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
      vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
      vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
    end,
  },
  -- Grep files plugin use of ripgrep
  {
    "duane9/nvim-rg",
  },
  -- Multi line select/edit
  {
    "mg979/vim-visual-multi",
  },
  -- Vim Game
  {
    "ThePrimeagen/vim-be-good",
  },
  -- full signature help, docs and completion for the nvim lua API.
  { "folke/neodev.nvim",                 event = "VeryLazy", opts = {} },
  -- Ger sidebar markers for your markers
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup({
        default_mappings = true,
      })
    end,
  },
  { "brenoprata10/nvim-highlight-colors" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules",
            },
          },
        },
      })
      vim.keymap.set("n", "<C-b>", ":Neotree toggle<CR>", {})
      vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
    end,
  },
}
