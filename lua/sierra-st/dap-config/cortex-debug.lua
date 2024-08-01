local M = {}
local dap_cortex_debug = require("dap-cortex-debug")
M.adapter = {
	debug = false,
	extension_path = vim.fn.stdpath("data") .. "/mason/packages/cortex-debug/extension",
	node_path = "node",
	dapui_rtt = true,
	dap_vscode_filetypes = { "c", "cpp" },
}
M.config = dap_cortex_debug.openocd_config({
	name = "openocd debug arm",
	cwd = "${workspaceFolder}",
	executable = require("sierra-st.utils").find_elf,
	configFiles = { "${workspaceFolder}/openocd.cfg" },
	gdbTarget = "localhost:3333",
	rttConfig = dap_cortex_debug.rtt_config(0),
	showDevDebugOutput = false,
})
return M
