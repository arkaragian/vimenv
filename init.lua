--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug ('https://github.com/vim-latex/vim-latex.git', {tag='v1.10.0'})
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'Mofiqul/vscode.nvim'
--Plugins for debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

--nvim api Autocompletion
Plug 'tjdevries/nlua.nvim'

--Plugins for code completion. We use the cmp plugin. This also requires completion
--sources. For now we only use the lsp source
Plug 'hrsh7th/cmp-nvim-lsp' -- Source for internal nvim lua completion
Plug 'hrsh7th/cmp-buffer' -- Cmp source buffer
Plug 'onsails/lspkind.nvim' -- Formating of completion sources
Plug 'hrsh7th/nvim-cmp' -- Autocompletion engine

-- Tree Sitter
Plug ('nvim-treesitter/nvim-treesitter',{['do'] = vim.fn[':TSUpdate']})

-- Telescope fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim',{tag='0.1.0'})
vim.call('plug#end')

require('behavior')
require('LanguageServer')
require('debugAdapter')
require('completion')
require('TreeSitter')
require('Formatting')
require('ConfigTelescope')
