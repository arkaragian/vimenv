local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

-- First we define the key bindings to call telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Find in all files
vim.keymap.set('n', '<leader>gf', builtin.git_files, {}) -- Find in only git files
vim.keymap.set('n', '<leader>fb', builtin.buffers, {}) -- Find in open buffers

-- In the section bellow we perform telescope setup

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<esc>"] = actions.close,
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
