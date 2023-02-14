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

local csProgram = nil

--- Detects the output locations and provides formated results for the user
--to choose for debuging.
local function FindCSharpDllLocation()
    csProgram = nil
    if(vim.g.SolutionPluginLoaded == true) then
        local s = require("solution")
        local locs = s.GetOutputLocations()
        if(locs == nil) then
            vim.notify("No output location detected. Requesting manual prompt",vim.log.levels.ERROR,{title="User DAP Configuration"})
            csProgram = vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/', 'file')
        elseif(#locs > 1) then
            -- We have more than one ouptut location. Ask the user to select one.
            local opts = {
                prompt = "Select Output to Debug:"
            }

            local Projects = {}
            local maxLeftLength = 1
            local maxRightLength = 1

            -- Iterate once through the results to find the results dimensions.
            -- We want to make the results easier to select so we need to format
            -- them correctly
            for _,v in ipairs(locs) do
                maxLeftLength  = math.max(maxLeftLength,string.len(v[1]))
                maxRightLength = math.max(maxRightLength,string.len(v[2]))
            end

            -- Generate the formated results
            for i,v in ipairs(locs) do
                -- Max field length is 99. Don't know why
                local formatProvider
                -- The right length will always be bigger than the leeft lenght
                -- and almost always bigger than 99 characters.
                if(maxLeftLength > 99) then
                    formatProvider = "%s ----> %s"
                else
                    formatProvider = "%-"..maxLeftLength.."s ----> %s"
                end
                local s2 = string.format(formatProvider,v[1],v[2])
                Projects[i] = s2
            end

            -- Present to the user for selection
            vim.ui.select(Projects,opts,function(item,index)
                if not item then
                    --return vim.fn.input('Path to dll: ', locs[1][2], 'file') -- Nothing selected set the first input
                    csProgram = locs[1][2]
                else
                    --return vim.fn.input('Path to dll: ', locs[index][2] .. '/bin/', 'file')
                    csProgram = locs[index][2]
                end
            end)
        else
            --return vim.fn.input('Path to dll: ', locs[1][2], 'file') -- Nothing selected set the first input
            csProgram = locs[1][2]
        end
    else
        -- No Solution.nvim is loader. Prompt the user for input
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/', 'file')
    end
end

dap.configurations.cs = {
    {
        type = "csharp",
        name = "launch - netcoredbg",
        request = "launch",
        --TODO: make the /bin/Debug configurable
        program = function()
            -- This will populate the csProgram
            FindCSharpDllLocation()
            return csProgram
        end
    }
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
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F4>', ":lua require'dap'.step_out()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F9>', ":lua require'dap'.run_to_cursor()<CR>") --Toggle Breakpoint
vim.keymap.set('n', '<F12>', ":lua require'dap'.terminate()<CR>") --Toggle Breakpoint
