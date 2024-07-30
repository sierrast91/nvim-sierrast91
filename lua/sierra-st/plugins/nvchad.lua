return {
	{
		"NvChad/base46",
		branch = "v2.5",
		dependencies = "nvim-lua/plenary.nvim",
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"NvChad/ui",
		branch = "v2.5",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("nvchad")
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},
}
