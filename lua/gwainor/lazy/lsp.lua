return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		opts = function()
			--@class PluginLspOpts
			local ret = {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
						-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
						-- prefix = "icons",
					},
					severity_sort = true,
				},
				inlay_hints = { enabled = true },
			}
			return ret
		end,
		config = function()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("mason").setup({
				ensure_installed = {
					"prettierd",
					"html",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					--
					-- Python
					"ty",
					-- "basedpyright",
					"ruff",
					--
					-- Node
					"vtsls",
					"tailwindcss",
					-- "rust_analyzer",
					-- "gopls",
					-- "templ",
					-- "htmx",
				},
				handlers = {
					function(server_name)
						vim.lsp.config(server_name, { capabilities = capabilities })
					end,
				},
				-- ["lua_ls"] = function()
				-- 	vim.lsp.config("lua_ls", {
				-- 		capabilities = capabilities,
				-- 		settings = {
				-- 			Lua = {
				-- 				runtime = {
				-- 					version = "LuaJIT",
				-- 				},
				-- 				diagnostics = {
				-- 					globals = {
				-- 						"vim",
				-- 						"require",
				-- 					},
				-- 				},
				-- 				workspace = {
				-- 					library = vim.api.nvim_get_runtime_file("", true),
				-- 				},
				-- 				telemetry = { enable = false },
				-- 				format = {
				-- 					enable = true,
				-- 					-- Put format options here
				-- 					-- NOTE: the value should be STRING!!
				-- 					defaultConfig = {
				-- 						indent_style = "space",
				-- 						indent_size = "2",
				-- 					},
				-- 				},
				-- 			},
				-- 		},
				-- 	})
				-- end,
				["tailwindcss"] = function()
					vim.lsp.config("tailwindcss", {
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"heex",
						},
					})
				end,
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})

			vim.diagnostic.config({
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
}
