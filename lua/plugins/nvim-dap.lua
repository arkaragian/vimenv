-- return {
--     "rcarriga/nvim-dap-ui",
--     dependencies = {
--         "mfussenegger/nvim-dap",
--         "nvim-neotest/nvim-nio"
--     }
-- }

return {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
        "rcarriga/nvim-dap-ui",
        -- virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
    },

    -- stylua: ignore
    keys = {
        { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },

    config = function()
        -- -- load mason-nvim-dap here, after all adapters have been setup
        -- if LazyVim.has("mason-nvim-dap.nvim") then
        --     require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
        -- end
        --
        -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        --
        -- for name, sign in pairs(LazyVim.config.icons.dap) do
        --     sign = type(sign) == "table" and sign or { sign }
        --     vim.fn.sign_define(
        --     "Dap" .. name,
        --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        --     )
        -- end
        --
        -- -- setup dap config by VsCode launch.json file
        -- local vscode = require("dap.ext.vscode")
        -- local json = require("plenary.json")
        -- vscode.json_decode = function(str)
        --     return vim.json.decode(json.json_strip_comments(str))
        -- end
        --
        --
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
          name = 'lldb',
          --MIMode = 'gdb',
          --MIDebuggerPath = 'gdb.exe',
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
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/a.exe', 'file')
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
    end,
}
