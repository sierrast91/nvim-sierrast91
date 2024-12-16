return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- "User Filepost"
	dependencies = {
		"folke/neodev.nvim",
		opts = {
			library = { plugins = { "nvim-dap-ui", "nvim-dap" }, types = true },
		},
	},
	config = function()
		dofile(vim.g.base46_cache .. "lsp")
		local lsp = require("lspconfig")

		local on_attach = function(_, bufnr)
			local function opts(desc)
				return { buffer = bufnr, desc = "LSP " .. desc }
			end
			local map = vim.keymap.set
			map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
			map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
			map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
			map("n", "gr", vim.lsp.buf.references, opts("Show references"))
			map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

			map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
			map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
			map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
			map("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts("List workspace folders"))

			map("n", "<leader>rn", function()
				require("nvchad.lsp.renamer")()
			end, opts("NvRenamer"))
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
		end
		local on_init = function(client, _)
			if client.supports_method("textDocument/semanticTokens") then
				client.server_capabilities.semanticTokensProvider = nil
			end
		end
		local caps = vim.lsp.protocol.make_client_capabilities()
		caps.textDocument.completion.completionItem = {
			documentationFormat = { "markdown", "plaintext" },
			snippetSupport = true,
			preselectSupport = true,
			insertReplaceSupport = true,
			labelDetailsSupport = true,
			deprecatedSupport = true,
			commitCharactersSupport = true,
			tagSupport = { valueSet = { 1 } },
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			},
		}

		local servers = {
			lua_ls = {
				settings = {
					Lua = { diagnostics = {
						globals = { "vim" },
						disable = { "missing-fields" },
					} },
				},
			},
			clangd = {
				filetypes = { "c", "cpp" },
				root_dir = lsp.util.root_pattern(".git", "compile_commands.json", "build"),
				cmd = { "clangd", "--compile-commands-dir=build" },
			},
			html = {
				filetypes = { "html", "gotmpl", "htmldjango", "erb", "mustache", "jinja", "twig" },
				root_dir = lsp.util.root_pattern(".git", "go.mod"),
			},
			cssls = {},
			ts_ls = {},
			tailwindcss = {
				filetypes = { "html", "tsx", "typescriptreact", "templ", "gotmpl", "pug" },
				root_dir = lsp.util.root_pattern(".git", "go.mod", "tailwindcss.json"),
			},
			gopls = {
				filetypes = { "go", "gomod", "gowork" },
				cmd = { "gopls" },
				root_dir = lsp.util.root_pattern("go.mod", ".git"),
			},
			pyright = {},
		}
		for server, config in pairs(servers) do
			config.on_attach = on_attach
			config.on_init = on_init
			config.capabilities = caps
			lsp[server].setup(config)
		end
	end,
}
