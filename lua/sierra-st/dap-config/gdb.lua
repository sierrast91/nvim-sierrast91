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
		local delim = "/"
		if vim.fn.has("win32") then
			delim = "\\"
		end
		return vim.fn.input("path to exe: ", vim.fn.getcwd() .. delim, "file")
	end,
	cwd = "${workspaceFolder}",
}
return M
