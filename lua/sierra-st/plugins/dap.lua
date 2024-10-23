return {
  'mfussenegger/nvim-dap',
  keys = '<leader>b<space>',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'jedrzejboczar/nvim-dap-cortex-debug',
  },
  config = function()
    --dofile(vim.g.base46_cache .. "dap")
    -- local defs
    local dap = require 'dap'
    local dapui = require 'dapui'
    -- config dapui
    dapui.setup {}
    -- open / close ui windows automatically
    dap.listeners.after.event_initialized.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    -- adaptern and configurations
    local dapInsert = function(dapconfig)
      dap.adapters[dapconfig.name] = dapconfig.adapter
      for _, lang in ipairs(dapconfig.languages) do
        dap.configurations[lang] = dap.configurations[lang] or {}
        for _, config in ipairs(dapconfig.configs) do
          table.insert(dap.configurations[lang], config)
        end
      end
    end
    dapInsert(require 'sierra-st.dap-config.gdb')
    dapInsert(require 'sierra-st.dap-config.codelldb')
  end,
}
