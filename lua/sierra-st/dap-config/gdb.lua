local M = {}
M.name = "gdb"
M.languages = { "c", "cpp" }

M.adapter = {
	name = M.name,
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--quiet" },
	options = {
		detached = false,
	},
}
M.configs = {
	{
		type = M.name,
		name = "launch gdb",
		request = "launch",
		program = function()
			return vim.fn.input("path to executable:", "./build/", "file")
		end,
		cwd = "${workspaceFolder}",
		-- stopOnEntry = true,
		-- runInTerminal = true,
	},
}
return M
