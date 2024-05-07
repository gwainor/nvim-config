return {
	{
		"akinsho/bufferline.nvim",
		event = "ColorScheme",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
    enabled = function()
      return not vim.g.started_by_firenvim
    end,
		config = function()
			require("bufferline").setup({
				highlights = require("rose-pine.plugins.bufferline"),
        options = {
          persist_buffer_sort = false,
        },
			})
		end,
	},
}
