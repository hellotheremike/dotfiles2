return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
      local null_ls = require("null-ls")

      local utils = require("null-ls.utils")

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      local root =
          utils.root_pattern(".git", "package.json", ".prettierrc", ".prettierrc.json")(vim.fn.expand("%:p"))

      null_ls.setup({
        root_dir = function()
          return root
        end,
        sources = {
          null_ls.builtins.formatting.prettier.with({
            --	extra_args = { "--plugin-search-dir=" .. root },

            extra_args = { "--plugin-search-dir=." },
            -- Optional: define the working directory (useful in monorepos)
            cwd = function(params)
              return utils.root_pattern(".git")(params.bufname)
            end,
            env = {
              PRETTIER_LOG_LEVEL = "debug",
            },
          }),
          require("none-ls.diagnostics.eslint_d"),
        },
      })
      local formatFile = function()
        vim.lsp.buf.format({
          async = false,
          filter = function(client)
            return client.name == "null-ls"
          end,
        })
      end

      -- map("n", "<leader>fm", formatFile, {})
      --      vim.keymap.set("n", "<leader>fm", formatFile, { desc = "Format file with null-ls" })
      vim.keymap.set("n", "<leader>fm", formatFile, { noremap = true, silent = true, desc = "Format file with null-ls" })


      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.tsx", "*.jsx", "*.html" },
        callback = function()
          formatFile()
        end,
      })
    end,
  },
}
