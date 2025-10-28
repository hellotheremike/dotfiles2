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
}
