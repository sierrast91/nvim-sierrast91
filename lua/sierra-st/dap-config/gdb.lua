local M = {}

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
}

return M
