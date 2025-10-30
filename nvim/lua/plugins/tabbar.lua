return {
	{
		"stevearc/resession.nvim",
		opts = {},
		config = function()
			local resession = require("resession")
			resession.setup({
				autosave = {
					enabled = true,
					interval = 60,
					notify = true,
				},
			})

			-- Create one session per git branch
			local function get_session_name()
				local name = vim.fn.getcwd()
				local branch = vim.trim(vim.fn.system("git branch --show-current"))
				if vim.v.shell_error == 0 then
					return name .. branch
				else
					return name
				end
			end
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					-- Only load the session if nvim was started with no args
					if vim.fn.argc(-1) == 0 then
						resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
					end
				end,
			})
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					resession.save(get_session_name(), { dir = "dirsession", notify = false })
				end,
			})
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			vim.opt.sessionoptions:append("globals")
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "PersistedSavePre",
				group = vim.api.nvim_create_augroup("PersistedHooks", {}),
				callback = function()
					vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
				end,
			})
		end,
		opts = {
			version = "^1.0.0",
		},
	},
}
