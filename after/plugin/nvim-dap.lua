-- This file configures the Debug Adapter Prototol functionallity
local dap = require('dap')
dap.set_log_level('INFO')

local home
if(jit.os == "Windows") then
    home = os.getenv("USERPROFILE")
else
    home = os.getenv("HOME")
end
-------------------------------------------------------------------------------
--                            A D A P T E R S                                --
-------------------------------------------------------------------------------
-- Adapters are the programs that speak to the actual debuggers. Those programs
-- accept DAP commands and integrate with the debugers. In many cases there is
-- no adapter needed since the debuger may be run in DAP mode and accept the
-- DAP coomands.


-- This is a debugger with DAP support
dap.adapters.netcoredbg= {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode', '--engineLogging='..home..'/NetCoreDebugEnginelog.log'},
}

-- This is a debugger with DAP support
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode', -- lldb-vscode is in our path
  name = 'lldb'
}

-- This was extracted from vscode C# extension and shoul be working similar with
-- netcoredbg. However this is not the case.
dap.adapters.vsdbg= {
  type = 'executable',
  command = 'vsdbg',
  args = {'--interpreter=vscode', '--engineLogging='..home..'/vsdbg.log'},
  options = {
  --    env = nil,
      cwd = "${workspaceFolder}",
  --    detached = nil,
  },
  --id = nil
}

--- Detects the output locations and provides formated results for the user
--to choose for debuging.
local function FindCSharpDllLocation()

    -- P(vim.g.SolutionPluginLoaded)
    local prog = nil
    if(vim.g.SolutionPluginLoaded == true) then
        local s = require("solution")
        prog = s.GetCSProgram()

        if(prog == nil) then
            P("Got a nil program")
        else
            P("Got the following CS Program: " .. prog)
        end
        vim.notify("dll: "..prog,vim.log.levels.INFO,{title="User Configuration DAP"})
        if(prog == nil) then
            prog = vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/', 'file')
        end
    else
        -- No Solution.nvim is loaded. Prompt the user for input
        prog = vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/', 'file')
    end

    return prog
end

dap.configurations.cs = {
    {
        type = "netcoredbg",
        request = "launch",
        name = "launch - netcoredbg",
        -- Point to function that calculates the program location and returns
        -- it as a string.
        program = FindCSharpDllLocation
    }
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
        -- TODO: Use Solution.nvim to launch specific configurations
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
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F4>', ":lua require'dap'.step_out()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F9>', ":lua require'dap'.run_to_cursor()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F12>', ":lua require'dap'.terminate()<CR>") --Toggle Breakpoint
local dapui = require("dapui")--

 local config = {
    controls = {
      element = "repl",
      enabled = false,
      icons = {
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    }
  }
dapui.setup(config)

vim.keymap.set('n', '<leader>td', ":lua require('dapui').toggle()<CR>",{desc="Toggle Debug Session"})
-- vim.keymap.set('n', 'sds', ":lua require('dapui').open()<CR>",{desc="Start Debug Session"})
-- vim.keymap.set('n', 'eds', ":lua require('dapui').close()<CR>",{desc="End Debug Session"})

