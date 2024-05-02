return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},

		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("mason").setup({
				ensure_installed = {
					"black",
					"isort",
					"flake8",
					"prettierd",
					"html",
				},
				handlers = {
					["html"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.html.setup({
							capabilities = capabilities,
							filetypes = { "html", "templ" },
						})
					end,
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"gopls",
					"templ",
					"htmx",
					"pylsp",
					"tailwindcss",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,
				},
			})

			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover documentation" })
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Go to declaration" })
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Go to implementation" })
			vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "Go to type definition" })
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "Go to reference" })
			vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Show function signature" })
			vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol" })
			vim.keymap.set("n", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format file" })
			vim.keymap.set(
				"x",
				"<F3>",
				"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
				{ desc = "Format selection" }
			)
			vim.keymap.set(
				"n",
				"<leader>ca",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				{ desc = "Execute code action" }
			)
		end,
	},
}
