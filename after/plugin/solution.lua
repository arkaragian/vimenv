local solution = require("solution")

SolutionConfig = {
    ProjectSelectionPolicy = "first",  -- Compile the first project that we find.
    BuildConfiguration = "Debug",      -- What configuration to build with
    arch = "x64",                      -- What architecture to build with
    display = {
        removeCR = true,               -- Remove final CR characters on popup windows
        HideCompilationWarnings = true -- Hide compilation warnings
    }
}

solution.setup(SolutionConfig)

-- Need this for plugin development purposes.
vim.keymap.set('n' , '<leader>sss' , solution.FunctionTest  , {desc="Test a Plugin Function" , buffer=0 } )
vim.keymap.set('n' , '<leader>wp'  , solution.WriteSolution , {desc="Write project to disk"  , buffer=0 } )
vim.keymap.set('n' , '<leader>ws'  , solution.WriteSolution , {desc="Write project to disk"  , buffer=0 } )

function SetupSolutionNvimKeyBindings()
    vim.keymap.set('n' , '<leader>cc'        , solution.Compile             , {desc="C# Solution Compile"         , buffer=0 } )
    vim.keymap.set('n' , '<leader>cl'        , solution.Clean               , {desc="C# Solution clean"           , buffer=0 } )
    vim.keymap.set('n' , '<leader>st'        , solution.Test                , {desc="Test a Plugin Function"      , buffer=0 } )
    vim.keymap.set('n' , '<leader>ft'        , solution.GetTests            , {desc="Get Solution tests"          , buffer=0 } )
    vim.keymap.set('n' , '<leader><leader>c' , solution.SelectConfiguration , {desc="Select build configuration"  , buffer=0 } )
    --vim.keymap.set('n' , '<leader>ds' , solution.DisplaySolution , {desc="Select Compilation Platform" , buffer=0 } )
end

function TearDownSolutionNvimKeyBindings()
    print("Tearing down Solution.nvim mappings")
    vim.keymap.del('n' , '<leader>cc'        , { buffer=0 } )
    vim.keymap.del('n' , '<leader>cl'        , { buffer=0 } )
    vim.keymap.del('n' , '<leader>st'        , { buffer=0 } )
    vim.keymap.del('n' , '<leader>ft'        , { buffer=0 } )
    vim.keymap.set('n' , '<leader><leader>c' , { buffer=0 } )
    --vim.keymap.set('n' , '<leader>ds'  , { buffer=0 } )
end


-- Create a AU group. Make sure that is not executed repeatedly with the clear flag
local SolutionAutoCommandGroup = vim.api.nvim_create_augroup("SolutionCommands", { clear = true })

-- Maintain keybindings for .cs .csproj and .sln files, Through autocommands.
-- Set and delete the keybindings for the files that we care about.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*.cs, *.csproj, *.sln"},
  callback = SetupSolutionNvimKeyBindings,
  group = SolutionAutoCommandGroup,
})

-- This crashes when we try to call for example compile and use the BufLeave event
-- This might be the order of firing. Because compiling opens a new window we
-- actualy leave the buffer need to investigate the events.
vim.api.nvim_create_autocmd("BufWipeout", {
  pattern = {"*.cs, *.csproj, *.sln"},
  callback = TearDownSolutionNvimKeyBindings,
  group = SolutionAutoCommandGroup,
})

