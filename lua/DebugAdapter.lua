-- This file configures the Debug Adapter Prototol functionallity
local dap = require('dap')
dap.set_log_level('INFO')
dap.adapters.csharp = {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode', '--engineLogging='..os.getenv("HOME")..'/NetCoreDebugEnginelog.log'},
}


dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode', -- lldb-vscode is in our path
  name = 'lldb'
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

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/a.exe', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- Use the same configuration for C and rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set('n', '<space>b', ":lua require'dap'.toggle_breakpoint()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F12>', ":lua require'dap'.step_out()<CR>", opts) --Toggle Breakpoint
vim.keymap.set('n', '<F1>', ":lua require'dap'.terminate()<CR>", opts) --Toggle Breakpoint
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
