return {
	{
		"stevearc/conform.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("conform").setup({
				formatters = {
					prettier = {
						require_cwd = true,
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "black", "isort" },
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
				},
			})
		end,
	},
}
