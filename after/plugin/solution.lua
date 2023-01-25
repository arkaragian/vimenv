local sol = require("solution")

SolutionConfig = {
    selection = "first",
    ext = ".csproj",
    conf = "Debug",
    arch = "x64",
    display = {
        removeCR = true
    }
}

sol.setup(SolutionConfig)

vim.keymap.set('n' , '<leader>cc' , sol.Compile , {desc="CS Solution Compile"})
vim.keymap.set('n' , '<leader>cl' , sol.Clean   , {desc="CS Solution clean"})
vim.keymap.set('n' , '<leader>st' , sol.Test   , {desc="Test a Plugin Function"})
