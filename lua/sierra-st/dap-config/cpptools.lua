local openocd_handle

local openocd_start = function()
	openocd_handle = vim.loop.spawn("openocd", {
		args = { "-f", "interface/stlink.cfg", "-f", "target/stm32f4x.cfg" },
	}, function(code, signal)
		print("openocd exited with code", code, "and signal", signal)
	end)
end

local openocd_stop = function()
	if openocd_handle then
		openocd_handle:kill("sigterm")
		openocd_handle = nil
	end
end

local M = {}
M.name = "cpptools"
M.languages = { "c", "cpp", "asm" }

M.adapter = {
	name = M.name,
	id = "cppdbg",
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7.cmd",
	-- args = {
	-- 	"--interpreter=dap",
	-- 	"--quiet",
	-- 	-- "--eval-command=target extended-remote :3333",
	-- },
	options = {
		detached = false,
	},
}
M.configs = {
	{
		type = M.name,
		name = "attach to openocd using " .. M.name,
		request = "launch",

		-- MIMODE = "gdb",
		miDebuggerServerAddress = "localhost:3333",
		miDebuggerPath = "gdb-multiarch",

		program = function()
			-- return vim.fn.input("path to executable:", "./build/", "file")
			local cwd = vim.fn.getcwd()
			local build_dir = cwd .. "/build/"
			local project_name = vim.fn.fnamemodify(cwd, ":t")
			return build_dir .. project_name .. ".elf"
		end,

		-- setupCommands = {
		-- 	{ text = "set print pretty on" },
		-- },
		stopAtEntry = true,
		cwd = "${workspaceFolder}",
		preLaunchTask = openocd_start,
		postDebugTask = openocd_stop,

		-- runInTerminal = true,
	},
}
return M
