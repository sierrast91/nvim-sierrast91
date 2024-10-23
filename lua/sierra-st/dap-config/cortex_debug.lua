local cortex_debug = require 'nvim-cortex-debug'

local M = {}

M.name = 'cortex-debug'
M.languages = { 'c', 'cpp' }

M.adapter = {
  name = M.name,
  type = 'executable',
  command = 'arm-none-eabi-gdb',
  args = {},
}
M.configs = {
  {
    type = M.name,
    request = 'launch',
    name = 'launch ' .. M.name,
    program = function()
      vim.fn.input('path to execute: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${werkspaceFolder}',
    stopAtEntry = true,
  },
}

return M
