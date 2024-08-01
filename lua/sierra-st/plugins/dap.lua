return {
	"mfussenegger/nvim-dap",
	keys = "<leader>b<space>",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"jedrzejboczar/nvim-dap-cortex-debug",
	},
	config = function()
		dofile(vim.g.base46_cache .. "dap")
		-- local defs
		local dap = require("dap")
		local dapui = require("dapui")
		require("nvim-dap-virtual-text").setup()
		-- config dapui
		dapui.setup({
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.1,
						},
						{ id = "breakpoints", size = 0.2 },
						{ id = "stacks", size = 0.1 },
						{ id = "watches", size = 0.3 },
						{ id = "rtt", size = 0.3 },
					},
					size = 40,
					position = "right", -- Can be "left" or "right"
				},
				{
					elements = {
						"repl",
					},
					size = 4,
					position = "top", -- Can be "bottom" or "top"
				},
			},
		})
		-- open / close ui windows automatically
		dap.listeners.after.event_initialized.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		-- adaptern and configurations
		dap.adapters.codelldb = require("sierra-st.dap-config.codelldb").adapter
		dap.adapters.gdb = require("sierra-st.dap-config.gdb").adapter
		require("dap-cortex-debug").setup(require("sierra-st.dap-config.cortex-debug").adapter)
		dap.configurations.c = {
			require("sierra-st.dap-config.codelldb").config,
			require("sierra-st.dap-config.gdb").config,
			require("sierra-st.dap-config.cortex-debug").config,
		}
	end,
}
