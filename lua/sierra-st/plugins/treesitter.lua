return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdate" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/playground",
	},
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
		extension = {
			gotmpl = "tmpl",
		},
		playground = {
			enable = true,
			updatetime = 50,
			persist_queries = false,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	},
	config = function(_, opts)
		pcall(function()
			dofile(vim.g.base46_cache .. "syntax")
			dofile(vim.g.base46_cache .. "treesitter")
		end)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
