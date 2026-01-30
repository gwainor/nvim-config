return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"olacin/telescope-gitmoji.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["<C-x>"] = actions.delete_buffer,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					i = {
						["<C-x>"] = actions.delete_buffer,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				gitmoji = {
					action = function(entry)
						local row, col = unpack(vim.api.nvim_win_get_cursor(0))
						local emoji = entry.value.value
						vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { emoji })
						vim.api.nvim_win_set_cursor(0, { row, col + 1 })
					end,
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[Telescope] Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[Telescope] Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[Telescope] Find in buffers" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[Telescope] Find keymaps" })
		vim.keymap.set(
			"n",
			"<leader>fs",
			builtin.current_buffer_fuzzy_find,
			{ desc = "[Telescope] Find in current buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>fj",
			'<cmd>lua require("telescope").extensions.gitmoji.gitmoji()<cr>',
			{ desc = "[Telescope] Find gitmoji" }
		)
	end,
}
