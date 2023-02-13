-- This file configures the Debug Adapter Prototol functionallity
local dap = require('dap')
dap.set_log_level('INFO')

local home
if(jit.os == "Windows") then
    home = os.getenv("USERPROFILE")
else
    home = os.getenv("HOME")
end

dap.adapters.csharp = {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode', '--engineLogging='..home..'/NetCoreDebugEnginelog.log'},
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

vim.keymap.set('n', '<Leader>b', ":lua require'dap'.toggle_breakpoint()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F1>', ":lua require'dap'.continue()<CR>") --Start the session
vim.keymap.set('n', '<F2>', ":lua require'dap'.step_over()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F3>', ":lua require'dap'.step_into()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F4>', ":lua require'dap'.step_out()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F9>', ":lua require'dap'.run_to_cursor()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F12>', ":lua require'dap'.terminate()<CR>") --Toggle Breakpoint
