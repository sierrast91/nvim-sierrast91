local M = {}
<<<<<<< HEAD

M.languages = { 'c', 'cpp' }
M.name = 'gdb'

M.adapter = {
  name = M.name,
  type = 'executable',
  command = 'gdb',
  args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}

M.configs = {
  {
    type = M.name,
    request = 'launch',
    name = 'launch ' .. M.name,
    program = function()
      return vim.fn.input('path to execute: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubProgram = false,
  },
  {
    type = M.name,
    request = 'attach',
    name = 'attach ' .. M.name .. ' server',
    program = function()
      return vim.fn.input('path to execute ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
  },
=======
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
>>>>>>> origin/root
}

return M
