return {
	-- {
	--   "rose-pine/neovim",
	--   priority = 100,
	--   name = "rose-pine",
	--   config = function()
	--     require("rose-pine").setup({
	--       --- @usage 'auto'|'main'|'moon'|'dawn'
	--       variant = "main",
	--       --- @usage 'main'|'moon'|'dawn'
	--       dark_variant = "main",
	--       bold_vert_split = false,
	--       dim_inactive_windows = false,
	--       dim_nc_background = false,
	--       disable_background = true,
	--       disable_float_background = false,
	--       disable_italics = false,
	--
	--       enable = {
	--         terminal = true,
	--         -- Improve compatibility for previous versions of Neovim
	--         legacy_highlights = true,
	--         -- Handle deprecated options automatically
	--         migrations = true,
	--       },
	--
	--       styles = {
	--         bold = true,
	--         italic = true,
	--         transparency = true,
	--       },
	--
	--       --- @usage string hex value or named color from rosepinetheme.com/palette
	--       groups = {
	--         border = "muted",
	--         link = "iris",
	--         panel = "surface",
	--
	--         error = "love",
	--         hint = "iris",
	--         info = "foam",
	--         note = "pine",
	--         todo = "rose",
	--         warn = "gold",
	--
	--         git_add = "foam",
	--         git_change = "rose",
	--         git_delete = "love",
	--         git_dirty = "rose",
	--         git_ignore = "muted",
	--         git_merge = "iris",
	--         git_rename = "pine",
	--         git_stage = "iris",
	--         git_text = "rose",
	--         git_untracked = "subtle",
	--
	--         h1 = "iris",
	--         h2 = "foam",
	--         h3 = "rose",
	--         h4 = "gold",
	--         h5 = "pine",
	--         h6 = "foam",
	--       },
	--
	--       -- https://github.com/rose-pine/neovim/wiki/Recipes
	--       highlight_groups = {
	--         StatusLine = { fg = "love", bg = "love", blend = 10 },
	--         StatusLineNC = { fg = "subtle", bg = "surface" },
	--
	--         TelescopeBorder = { fg = "highlight_high", bg = "base" },
	--         TelescopeNormal = { bg = "base" },
	--         TelescopePromptNormal = { bg = "base" },
	--         TelescopeResultsNormal = { fg = "subtle", bg = "base" },
	--         TelescopeSelection = { fg = "text", bg = "base" },
	--         TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
	--       },
	--     })
	--     vim.cmd([[colorscheme rose-pine]])
	--   end,
	-- },
	-- {
	--   "catppuccin/nvim",
	--   name = "catppuccin",
	--   priority = 1000,
	--   config = function()
	--     require("catppuccin").setup({
	--       flavor = "mocha",
	--       transparent_background = true,
	--       show_end_of_buffer = true,
	--       custom_highlights = function(colors)
	--         return {
	--           StatusLine = { fg = colors.base0, bg = colors.surface0 },
	--           StatusLineNC = { fg = colors.base0, bg = colors.base4 },
	--         }
	--       end,
	--       integrations = {
	--         cmp = true,
	--         flash = true,
	--         fidget = true,
	--       },
	--     })
	--     -- vim.cmd([[colorscheme catppuccin]])
	--   end,
	-- },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				style = "moon",
				transparent = true,
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = prompt,
					}
					hl.TelescopePromptBorder = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
