local solution = require("solution")

SolutionConfig = {
    SolutionSelectionPolicy = "first",  -- Compile the first project that we find.
    DefaultBuildConfiguration = "Debug",      -- What configuration to build with
    DefaultBuildPlatform = "Any CPU",
    Display = {
        RemoveCR = true,               -- Remove final CR characters on popup windows
        HideCompilationWarnings = false -- Hide compilation warnings
    }
}

solution.setup(SolutionConfig)

-- Need this for plugin development purposes. (not buffer local at startup)
vim.keymap.set('n' , '<leader>sss' , solution.FunctionTest  , {desc="Test a Plugin Function" } )
vim.keymap.set('n' , '<leader>wp'  , solution.WriteSolution , {desc="Write project to disk"  } )
vim.keymap.set('n' , '<leader>ws'  , solution.WriteSolution , {desc="Write Solution to disk" } )

function SetupSolutionNvimKeyBindings(args)
    if vim.b[args.buf].solution_keymaps_set then
        return
    end
    vim.b[args.buf].solution_keymaps_set = true

    vim.keymap.set('n'   , '<leader>cc'        , solution.Compile                  , {desc="C# Solution Compile"         , buffer=args.buf } )
    vim.keymap.set('n'   , '<leader>cl'        , solution.Clean                    , {desc="C# Solution clean"           , buffer=args.buf } )
    vim.keymap.set('n'   , '<leader>st'        , solution.Test                     , {desc="Test a Plugin Function"      , buffer=args.buf } )
    vim.keymap.set('n'   , '<leader>ft'        , solution.PickTests                , {desc="Select Test"                 , buffer=args.buf } )
    vim.keymap.set('n'   , '<leader>et'        , solution.PickTests                , {desc="Execute Test"                , buffer=args.buf } )
    vim.keymap.set('n'   , '<leader><leader>c' , solution.SelectBuildConfiguration , {desc="Select build configuration"  , buffer=args.buf } )
    vim.keymap.set('n'   , '<leader><leader>x' , solution.LaunchSolution           , {desc="Launch Solution"             , buffer=args.buf } )
    --vim.keymap.set('n' , '<leader>ds'        , solution.DisplaySolution          , {desc="Select Compilation Platform" , buffer=0 } )
end

function TearDownSolutionNvimKeyBindings(args)
    local buf = args.buf
    if not vim.b[buf].solution_keymaps_set then
        return
    end

    print("Tearing down Solution.nvim mappings")
    vim.keymap.del('n' , '<leader>cc'        , { buffer=buf } )
    vim.keymap.del('n' , '<leader>cl'        , { buffer=buf } )
    vim.keymap.del('n' , '<leader>st'        , { buffer=buf } )
    vim.keymap.del('n' , '<leader>ft'        , { buffer=buf } )
    vim.keymap.del('n' , '<leader>et'        , { buffer=buf } )
    vim.keymap.del('n' , '<leader><leader>c' , { buffer=buf } )
    vim.keymap.del('n' , '<leader><leader>x' , { buffer=buf } )
    --vim.keymap.set('n' , '<leader>ds'        , { buffer=0 } )
end


-- Create a AU group. Make sure that is not executed repeatedly with the clear flag
local SolutionAutoCommandGroup = vim.api.nvim_create_augroup("SolutionCommands", { clear = true })


-- nvim_create_autocmd passes an argument ti the callback

-- Maintain keybindings for .cs .csproj and .sln files, Through autocommands.
-- Set and delete the keybindings for the files that we care about.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.cs", "*.csproj", "*.sln" },
  callback = SetupSolutionNvimKeyBindings,
  group = SolutionAutoCommandGroup,
})


-- This crashes when we try to call for example compile and use the BufLeave event
-- This might be the order of firing. Because compiling opens a new window we
-- actualy leave the buffer need to investigate the events.
vim.api.nvim_create_autocmd("BufWipeout", {
  pattern = {"*.cs", "*.csproj", "*.sln"},
  callback = TearDownSolutionNvimKeyBindings,
  group = SolutionAutoCommandGroup,
})

