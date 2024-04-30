return {
	{
		"akinsho/bufferline.nvim",
		event = "ColorScheme",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				highlights = require("rose-pine.plugins.bufferline"),
			})
		end,
	},
}
