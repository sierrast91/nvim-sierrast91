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

		dap.set_log_level("DEBUG")

		-- adapter and configurations
		local dapInsert = function(dap_module)
			dap.adapters[dap_module.name] = dap_module.adapter
			for _, lang in ipairs(dap_module.languages) do
				dap.configurations[lang] = dap.configurations[lang] or {}
				for _, config in ipairs(dap_module.configs) do
					table.insert(dap.configurations[lang], config)
				end
			end
		end
		dapInsert(require("sierra-st.dap-config.arm-gdb"))
		dapInsert(require("sierra-st.dap-config.gdb"))
		dapInsert(require("sierra-st.dap-config.cpptools"))

		dap.default_external_terminal_command = "cmd"
		dap.defaults.gdb.log = true
	end,
}
