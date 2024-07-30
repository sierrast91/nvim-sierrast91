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
		--dofile(vim.g.base46_cache .. "dap")
		-- local defs
		local dap = require("dap")
		local dapui = require("dapui")
		-- config dapui
		dapui.setup({})
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
		require("dap-cortex-debug").setup(require("sierra-st.dap-config.cortex_debug").adapter)
		dap.configurations.c = {
			require("sierra-st.dap-config.codelldb").config,
			require("sierra-st.dap-config.gdb").config,
			require("sierra-st.dap-config.cortex_debug").config,
		}
	end,
}
