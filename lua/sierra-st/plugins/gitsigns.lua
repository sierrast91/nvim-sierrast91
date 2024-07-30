return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- "User FilePost"
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" },
		},
	},
	config = function(_, opts)
		dofile(vim.g.base46_cache .. "git")
		require("gitsigns").setup(opts)
	end,
}
