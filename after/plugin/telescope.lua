local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

--- Launch the telescope git files picker at the neovim configuration file.
-- This function sets up viewing options and then launches the picker with
-- those options.
local function EditNeovimConfiguration()
	local options

	-- Define options here
	options = {
		prompt_title = "Neovim Configuration Files",
		cwd = vim.api.nvim_list_runtime_paths()[1],
	}

	-- launch the picker
	builtin.git_files(options)
end


-- First we define the key bindings to call telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Find files"}) -- Find in all files
vim.keymap.set('n', '<leader>fg', builtin.git_files, {desc = "Find GIT files"}) -- Find in only git files
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Find open buffers"}) -- Find in open buffers
-- Symbols can be invoked with both find symbls and show symbols
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find LSP Symbols"}) -- Find symbols
vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = "Show LSP Symbols"}) -- Show symbols

-- Special keymaps
vim.keymap.set('n', '<leader>ev',EditNeovimConfiguration,{ desc = "Edit Neovim Configuration"}) -- Edit vim
vim.keymap.set('n', '<leader>en',EditNeovimConfiguration,{ desc = "Edit Neovim Configuration"}) -- Edit neovim
vim.keymap.set('n', '<leader>sc',builtin.commands,{ desc = "Show Builtin Commands"}) -- Show commands

-- In the section bellow we perform telescope setup
require('telescope').setup{
	defaults = {
		-- Setup the prompt prefix text
		-- prompt_prefix = ">"
		--
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<esc>"] = actions.close, -- Close telescope
--                ["<CR>"] = actions.select_tab -- Open selection to new tab
			}
		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--	 picker_config_key = value,
		--	 ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--	 extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}
