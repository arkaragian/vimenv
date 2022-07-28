-- This file configures the Debug Adapter Prototol functionallity
local dap = require('dap')
dap.set_log_level('INFO')
dap.adapters.csharp = {
  type = 'executable',
  command = 'C:\\Users\\Aris\\bin\\netcoredbg\\netcoredbg.exe',
  args = {'--interpreter=vscode',
	  '--engineLogging=C:\\Users\\Aris\\enginelog.log',
	 },
}

dap.configurations.cs = {
  {
    type = "csharp",
    name = "launch - netcoredbg",
    request = "launch",
    --TODO: make the /bin/Debug configurable
    program = function()
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net6.0/test.dll', 'file')
    end,
  },
}


vim.keymap.set('n', '<space>b', ":lua require'dap'.toggle_breakpoint()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F12>', ":lua require'dap'.step_out()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', 'os', ":lua require'dapui'.open()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', 'cs', ":lua require'dapui'.close()<CR>", opts) --Toggle Breakpoint

require("dapui").setup()

function StartDebugSession()
				--TODO: Need to find a way to start and stop the session
				local dap = require('dap')
				dap.continue()
				local dapui = require('dapui')
				dapui.open()
end
