local M = {}
M.adapter = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
		-- detached = false,
	},
}
M.config = {
	name = "launch codelldb",
	type = "codelldb",
	request = "launch",
	program = function()
		return vim.fn.input("path to exe: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntery = false,
}
return M
