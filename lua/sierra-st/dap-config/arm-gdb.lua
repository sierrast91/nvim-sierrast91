local M = {}
M.name = "gdb-multiarch"
M.languages = { "c", "cpp", "asm" }

M.adapter = {
	name = M.name,
	type = "executable",
	command = "gdb-multiarch",
	args = {
		"--interpreter=dap",
		"--quiet",
	},
	options = {
		detached = false,
	},
}
M.configs = {
	{
		type = M.name,
		name = "launch gdb-multiarch with openocd",
		request = "launch",
		-- target = ":3333",
		program = function()
			-- return vim.fn.input("path to executable:", "./build/", "file")
			local cwd = vim.fn.getcwd()
			local build_dir = cwd .. "/build/"
			local project_name = vim.fn.fnamemodify(cwd, ":t")
			print(project_name)
			return build_dir .. project_name .. ".elf"
		end,
		cwd = "${workspaceFolder}",
		-- initCommands = {
		-- 	"target extended-remote :3333",
		-- 	"monitor reset halt",
		-- },
		-- runInTerminal = true,
	},
}
return M
