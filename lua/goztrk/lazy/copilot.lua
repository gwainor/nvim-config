return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
		},
		enabled = true,
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					-- auto_refresh = true,
					-- layout = {
					-- 	position = "right",
					-- },
					-- keymap = {
					-- 	jump_prev = "[[",
					-- 	jump_next = "]]",
					-- 	accept = "<CR>",
					-- 	refresh = "gr",
					-- 	open = "<M-CR>",
					-- },
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<Tab>",
					},
				},
			})

			-- local cmp_status_ok, cmp = pcall(require, "cmp")
			-- if cmp_status_ok then
			-- 	cmp.event:on("menu_opened", function()
			-- 		vim.b.copilot_suggestion_hidden = true
			-- 	end)
			--
			-- 	cmp.event:on("menu_closed", function()
			-- 		vim.b.copilot_suggestion_hidden = false
			-- 	end)
			-- end
		end,
	},
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
