return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.55,
					results_width = 0.8,
				},
				width = 0.7,
				height = 0.7,
				preview_cutoff = 120,
			},
		},
		pickers = {
			grep_string = {
				initial_mode = "normal",
			},
		},
		extension_list = { "fzf", "themes" },
	},
	config = function(_, opts)
		dofile(vim.g.base46_cache .. "telescope")
		local telescope = require("telescope")
		opts.defaults.mappings = {
			n = { ["q"] = require("telescope.actions").close },
		}
		telescope.setup(opts)
		for _, ext in ipairs(opts.extension_list) do
			telescope.load_extension(ext)
		end
	end,
}
