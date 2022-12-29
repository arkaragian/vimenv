print("After nvim-tree loaded")
-- empty setup using defaults
require("nvim-tree").setup()

local api = require("nvim-tree.api")

-- Toggle Tree
vim.keymap.set("n","<leader>tt",api.tree.toggle)
