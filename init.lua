--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'https://github.com/vim-latex/vim-latex.git'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'tomasiser/vim-code-dark'
--Plugins for debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
vim.call('plug#end')

require('behavior')
require('languageServer')
require('debugAdapter')
