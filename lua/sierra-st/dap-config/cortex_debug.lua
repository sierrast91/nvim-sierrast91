local M = {}

local cortex_debug = require("dap-cortex-debug")
M.adapter = {
	debug = false, --log debug messages,
	extension_path = vim.fn.stdpath("data") .. "/mason/packages/cortex-debug/extension",
	lib_extension = nil,
	node_path = "node",
	dapui_rtt = true,
	dap_vscode_filetypes = { "c", "cpp" },
}
M.config = {
	name = "openocd debug",
	type = "cortex-debug",
	request = "launch",
	servetype = "openocd",
	serverpath = "openocd",
	gdpPath = "/usr/bin/gdb-multiarch",
	toolchainPath = "/usr/bin",
	toolchainPrefix = "arm-none-eabi",
	runToEntryPoint = "main",
	swoConfig = { enabled = true },
	showDevDebugOutput = false,
	gdbTarget = "localhost:3333",
	cwd = "${workspaceFolder}",
	executable = function()
		return vim.fn.input("path to exe: ", vim.fn.getcwd() .. "/build/", "file")
	end,
	configFiles = { "${workspaceFolder}/openocd.cfg" },
	rttConfig = {
		address = "auto",
		decodesr = {
			label = "RTT:0",
			port = 0,
			type = "console",
		},
		enabled = true,
	},
}
return M
