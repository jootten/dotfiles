return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mfussenegger/nvim-dap-python',
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
  },
  config = function ()
    local dap = require('dap')
    dap.defaults.fallback.terminal_win_cmd = 'vsplit new'

    -- Python Debugging Setup
    local dap_python = require('dap-python')
    dap_python.setup()
    dap_python.test_runner = 'pytest'
    table.insert(dap.configurations.python, {
      type = 'python';
      request = 'launch';
      name = 'Debug current module';
      module = function()
        local file = vim.fn.expand('%')  -- get current file relative to wd
        file = file:gsub('/', '.'):gsub('.py', '')  -- make module
        return file
      end;
      console = "integratedTerminal";
    })
    table.insert(dap.configurations.python, {
      type = 'python';
      request = 'launch';
      name = 'Debug current module with arguments';
      module = function()
        local file = vim.fn.expand('%')  -- get current file relative to wd
        file = file:gsub('/', '.'):gsub('.py', '')  -- make module
        return file
      end;
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end;
      console = "integratedTerminal";
    })
    vim.keymap.set('n', '<leader>dn', dap_python.test_method, {silent = true})
    vim.keymap.set('n', '<leader>df', dap_python.test_class, {silent = true})
    vim.keymap.set('v', '<leader>ds', dap_python.debug_selection, {silent = true})

  end
}
