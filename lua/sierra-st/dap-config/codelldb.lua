local M = {}
M.languages = { 'c', 'cpp' }
M.name = 'codelldb'

M.adapter = {
  name = M.name,
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
    args = { '--port', '${port}' },
    -- detached = false,
  },
}
M.configs = {
  {
    type = M.name,
    request = 'launch',
    name = 'launch ' .. M.name,
    program = function()
      return vim.fn.input('path to exe: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntery = false,
  },
}
return M
