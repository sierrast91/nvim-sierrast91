return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	keys = "<leader>fm",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cmake = { "cmakelang" },

			xml = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
