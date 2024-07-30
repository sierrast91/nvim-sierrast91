local M = {}
M.adapter = {
	type = "executable",
	command = "/usr/bin/gdb",
	args = { "-i", "dap" },
}
M.config = {
	name = "launch gdb",
	type = "gdb",
	request = "launch",
	program = function()
		return vim.fn.input("path to exe: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
}
return M
