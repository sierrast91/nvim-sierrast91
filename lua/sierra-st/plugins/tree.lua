return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependecies = "nvim-tree/nvim-web-devicons",
	opts = {
		hijack_cursor = true,
		hijack_netrw = true,
		disable_netrw = true,
		filters = {
			dotfiles = false,
			git_ignored = false,
			custom = { "^\\.git$", "node_modules" },
		},
		git = { enable = true },
		diagnostics = { enable = true },
		renderer = {
			highlight_git = true,
			highlight_opened_files = "none",
			indent_markers = { enable = true },
			group_empty = true,
			root_folder_label = false,
		},
		view = {
			number = true,
			width = 40,
		},
	},
	config = function(_, opts)
		dofile(vim.g.base46_cache .. "nvimtree")
		require("nvim-tree").setup(opts)
	end,
}
