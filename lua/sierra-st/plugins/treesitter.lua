return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdate" },
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		ensure_installed = {
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"printf",
			"lua",
			"luadoc",
			"c",
		},
		highlight = { enable = true, use_languagetree = true },
		indent = { enable = true },
	},
	config = function(_, opts)
		pcall(function()
			dofile(vim.g.base46_cache .. "syntax")
			dofile(vim.g.base46_cache .. "treesitter")
		end)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
