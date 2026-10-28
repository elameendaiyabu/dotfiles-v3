-- Colorschemes used by the system themes (see lua/system-theme.lua).
-- Themes without a dedicated plugin are rendered with mini.base16.
return {
	{ "gbprod/nord.nvim", lazy = true },
	{ "Mofiqul/dracula.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true, opts = { style = "night" } },
	{
		"https://codeberg.org/evergarden/nvim",
		name = "evergarden",
		lazy = true,
		opts = { theme = { variant = "fall", accent = "green" } },
	},
}
