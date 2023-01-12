local sol = require("solution")

SolutionConfig = {
    selection = "first",
    ext = ".csproj",
    conf = "Debug",
    arch = "x64"
}

sol.setup(SolutionConfig)

vim.keymap.set('n', '<leader>cc',sol.Compile,{}) -- Edit vim
