return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = false
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<Tab>", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
		keymap.set("n", "<S-Tab>", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
		keymap.set("n", "<A-x>", "<cmd>BufferClose<CR>", { desc = "Close buffer" })
	end,
	opts = {
		-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		-- animation = true,
		-- insert_at_start = true,
		-- …etc.
	},
	version = "^1.0.0", -- optional: only update when a new 1.x version is released

	config = function()
		require("barbar").setup({
			animation = false,
			icons = {
				preset = "powerline",
			},
			sidebar_filetypes = {
				NvimTree = true, -- default event and text
				["neo-tree"] = { event = "BufWipeout", text = "neo-tree" }, -- custom event and text
			},
		})
	end,
}
