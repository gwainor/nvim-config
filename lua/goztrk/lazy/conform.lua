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
					python = function(bufnr)
						if require("conform").get_formatter_info("ruff", bufnr).available then
							return { "ruff" }
						else
							return { "black", "isort" }
						end
					end,
					-- Use a sub-list to run only the first available formatter
					-- javascript = { { "biome", "prettierd" } },
					-- javascriptreact = { { "biome", "prettierd" } },
					-- typescript = { { "biome", "prettierd" } },
					-- typescriptreact = { { "biome", "prettierd" } },
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					html = { "prettierd" },
					htmldjango = { "prettierd" },
					css = { "prettierd" },
				},
			})
		end,
	},
}
