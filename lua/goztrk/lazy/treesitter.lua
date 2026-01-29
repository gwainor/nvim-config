return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"bash",
			"gitcommit",
			"gitignore",
			"vimdoc",
			"lua",
			"json",
			"json5",
			"javascript",
			"typescript",
			"tsx",
			"jsdoc",
			"sql",
			"make",
			"markdown",
			"python",
			"html",
			"css",
			"yaml",
		})
	end,
}
