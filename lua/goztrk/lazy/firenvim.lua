return {
	{
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		config = function()
      -- Hide status bar if started by firenvim
			if vim.g.started_by_firenvim == true then
				vim.o.laststatus = 0
			else
				vim.o.laststatus = 2
			end

      -- use markdown for github.com
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				pattern = "github.com_*.txt",
				command = "set filetype=markdown",
			})
		end,
	},
}
