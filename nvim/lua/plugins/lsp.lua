return {

  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            function(entry1, entry2)
              local l1 = entry1.completion_item.label or ""
              local l2 = entry2.completion_item.label or ""
              local s1 = entry1.source.name
              local s2 = entry2.source.name

              -- Boost console.log *snippets* specifically
              local c1 = s1 == "luasnip" and l1:match("^console%.log")
              local c2 = s2 == "luasnip" and l2:match("^console%.log")

              if c1 and not c2 then
                return true
              elseif c2 and not c1 then
                return false
              end
            end,
            function(entry1, entry2)
              if entry1.source.name == "luasnip" and entry2.source.name ~= "luasnip" then
                return true
              elseif entry2.source.name == "luasnip" and entry1.source.name ~= "luasnip" then
                return false
              end
            end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = {

      opts = {
        -- Defaults
        enable_close = true,           -- Auto close tags
        enable_rename = true,          -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ["html"] = {
          enable_close = false,
        },
      },
    },
  },
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
      local capabilites = require("cmp_nvim_lsp").default_capabilities()

      -- Create reusable on_attach for keymaps
      local function on_attach(client, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        local map = vim.keymap.set
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>gd", vim.lsp.buf.definition, opts)
        map("n", "<leader>gr", function()
            require('telescope.builtin').lsp_references({
              fname_width = 100,
              path_display = {
                filename_first = {
                  reverse_directories = false
                }
              },
            })
          end,
          opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>fd", vim.diagnostic.open_float, opts)
        map("n", "[d", vim.diagnostic.goto_prev, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)

        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })
      end

      -- Define each server BEFORE enabling
      vim.lsp.config("ts_ls", {
        capabilites = capabilites,
        on_attach = on_attach,
        --root_dir = require("lspconfig.util").root_pattern("tsconfig.json", ".git"),
        settings = {
          typescript = {
            suggest = {
              completeFunctionCalls = true,
            },
          },
        },
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
