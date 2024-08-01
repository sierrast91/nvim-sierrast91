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
	setupCommands = {
		{
			text = "-enable-pretty-printing",
			description = "enable pretty printing",
			ingoreFailures = false,
		},
	},
	preLaunchTask = function()
		vim.fn.jobstart("openocd", { detach = true })
	end,
	postRunCommnads = function()
		if vim.fn.has("win32") then
			return { "taskkill/IM openocd.exe /F" }
		end
		return { "killall openocd" }
	end,
}
return M
