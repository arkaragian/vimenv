vim.keymap.set('n' , '<leader>gs' , ":Git status<CR>" , {desc = "Git Status"}                      )
vim.keymap.set('n' , '<leader>gd' , ":Gdiffsplit<CR>" , {desc = "Git diff"}                        )
vim.keymap.set('n' , '<leader>gc' , ":Git commit<CR>" , {desc = "Git Commit"}                      )
vim.keymap.set('n' , '<leader>ga' , ":Git add %<CR>"  , {desc = "Git add current file for commit"} )
