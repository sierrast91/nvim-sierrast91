return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	opts = {
		PATH = "skip",
		ui = {
			icons = {
				package_pending = " ",
				package_installed = " ",
				package_uninstalled = " ",
			},
			width = 0.6,
			height = 0.6,
			border = "single",
		},
		max_concurrent_installers = 10,
	},
	config = function(_, opts)
		dofile(vim.g.base46_cache .. "mason")
		require("mason").setup(opts)
	end,
}
