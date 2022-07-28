--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
--Plug 'https://github.com/vim-latex/vim-latex.git'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'tomasiser/vim-code-dark'
--Plugins for debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

--Plugins for code completion. We use the cmp plugin. This also requires completion
--sources. For now we only use the lsp source
Plug 'hrsh7th/cmp-nvim-lsp' -- Source for internal nvim lua completion
Plug 'hrsh7th/cmp-buffer' -- Cmp source buffer
Plug 'onsails/lspkind.nvim' -- Formating of completion sources
Plug 'hrsh7th/nvim-cmp' -- Autocompletion engine
vim.call('plug#end')

require('behavior')
require('languageServer')
require('debugAdapter')
require('completion')
