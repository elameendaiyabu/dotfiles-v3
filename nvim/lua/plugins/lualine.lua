return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "dokwork/lualine-ex" },
		{ "nvim-lua/plenary.nvim" },
		{ "kyazdani42/nvim-web-devicons" },
	},

	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
			},
		})
	end,
}
