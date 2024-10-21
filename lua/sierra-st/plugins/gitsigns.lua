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
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local opts = function(desc)
				return { buffer = bufnr, desc = "gitsigns: " .. desc }
			end
			local map = vim.keymap.set
			map("n", "<leader>hr", gs.reset_hunk, opts("hunk reset"))
			map("n", "<leader>hp", gs.reset_hunk, opts("hunk preview"))
			map("n", "<leader>hb", gs.blame_line, opts("hunk blame"))
		end,
	},
	config = function(_, opts)
		dofile(vim.g.base46_cache .. "git")
		require("gitsigns").setup(opts)
	end,
}
