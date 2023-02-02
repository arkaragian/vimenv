local sol = require("solution")

SolutionConfig = {
    ProjectSelectionPolicy = "first",
    BuildConfiguration = "Debug",
    arch = "x64",
    display = {
        removeCR = true,
        HideCompilationWarnings = true
    }
}

sol.setup(SolutionConfig)

vim.keymap.set('n' , '<leader>cc' , sol.Compile , {desc="CS Solution Compile"})
vim.keymap.set('n' , '<leader>cl' , sol.Clean   , {desc="CS Solution clean"})
vim.keymap.set('n' , '<leader>st' , sol.Test   , {desc="Test a Plugin Function"})
vim.keymap.set('n' , '<leader>ft' , sol.GetTests   , {desc="Test a Plugin Function"})
vim.keymap.set('n' , '<leader>sss' , sol.FunctionTest   , {desc="Test a Plugin Function"})
