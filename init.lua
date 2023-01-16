--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Snippets support
Plug ('L3MON4D3/LuaSnip', {tag='v1.1.0'})

Plug ('https://github.com/vim-latex/vim-latex.git', {tag='v1.10.0'})

--nvim api Autocompletion. Must be before lspconfig
Plug ('folke/neodev.nvim', {tag='v2.0.0'})

Plug ('https://github.com/neovim/nvim-lspconfig', {tag='v0.1.5'})

--Plugins for debugging
Plug ('mfussenegger/nvim-dap', {tag='0.4.0'})
Plug ('rcarriga/nvim-dap-ui', {tag='v2.6.0'})




--Plugins for code completion. We use the cmp plugin. This also requires completion
--sources. For now we only use the lsp source
Plug 'hrsh7th/cmp-nvim-lsp' -- Source for internal nvim lua completion
Plug 'hrsh7th/cmp-buffer' -- Cmp source buffer
Plug 'onsails/lspkind.nvim' -- Formating of completion sources
Plug 'hrsh7th/cmp-nvim-lsp-signature-help' -- Signature help from lsp
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp' -- Autocompletion engine

-- Tree Sitter
Plug ('nvim-treesitter/nvim-treesitter',{['do'] = vim.fn[':TSUpdate'], tag = 'v0.8.1'})
Plug 'nvim-treesitter/playground'

-- Telescope dependencies and telescope
Plug ('nvim-lua/plenary.nvim', {tag='v0.1.2'})
Plug ('nvim-telescope/telescope.nvim',{tag='0.1.1'})


-- Tree viewer plugin. Configured automatically through after/plugin/nvim-tree.lua file
Plug 'nvim-tree/nvim-tree.lua'

-- This is a local directory pointed like that since the plugin is already under
-- development.
Plug '~/source/repos/Solution.nvim'
Plug ("rebelot/kanagawa.nvim", {commit= '4c8d48726621a7f3998c7ed35b2c2535abc22def'})
vim.call('plug#end')


vim.cmd.colorscheme("kanagawa")

-- Source personal configurations
require('Behavior') -- Generic keybindings
require('Completion') -- Code completion Configuration
require('Formatting') -- Custom code formatting methods
