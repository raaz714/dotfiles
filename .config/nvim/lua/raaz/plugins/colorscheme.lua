return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			integrations = {
				nvimtree = true,
				barbar = false,
			},
		})
		vim.cmd("colorscheme catppuccin-macchiato")
	end,
}
