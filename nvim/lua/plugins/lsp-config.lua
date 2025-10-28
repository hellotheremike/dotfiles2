return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "html",
        "lua_ls",
        "ts_ls",
      },
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilites = require("cmp_nvim_lsp").default_capabilites

      -- Create reusable on_attach for keymaps
      local function on_attach(client, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        local map = vim.keymap.set
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>gd", vim.lsp.buf.definition, opts)
        map("n", "<leader>gr", vim.lsp.buf.references, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>fd", vim.diagnostic.open_float, opts)
        map("n", "[d", vim.diagnostic.goto_prev, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)
      end

      -- Define each server BEFORE enabling
      vim.lsp.config("ts_ls", {
        capabilites = capabilites,
        on_attach = on_attach,
        settings = {},
      })

      vim.lsp.config("html", {
        capabilites = capabilites,
        on_attach = on_attach,
      })

      vim.lsp.config("lua_ls", {
        capabilites = capabilites,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Enable after all configs are defined
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("html")
      vim.lsp.enable("lua_ls")
    end,
  },
}
