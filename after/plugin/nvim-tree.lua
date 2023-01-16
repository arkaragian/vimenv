local ViewOptions = {
    side = "right" -- Open the treeview on the right side
}
-- empty setup using defaults but override the view options
require("nvim-tree").setup({view = ViewOptions})

local api = require("nvim-tree.api")

-- Toggle Tree
vim.keymap.set("n","<leader>tt",api.tree.toggle)
