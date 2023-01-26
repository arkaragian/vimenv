--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Snippets support
Plug ('L3MON4D3/LuaSnip', {tag='v1.1.0'})

--Plug ('https://github.com/vim-latex/vim-latex.git', {tag='v1.10.0'})

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

Plug ("tpope/vim-fugitive" , {tag ="v3.7"})

Plug ("godlygeek/tabular", {tag = "1.0.0"})

-- This is a local directory pointed like that since the plugin is already under
-- development.
Plug '~/source/repos/Solution.nvim'
Plug ("rebelot/kanagawa.nvim", {commit= '4c8d48726621a7f3998c7ed35b2c2535abc22def'})
Plug ('mechatroner/rainbow_csv')
vim.call('plug#end')

------------------------------------------------------------------------------
--        C O L O R S C H E M E  T E X  C O N F I G U R A T I O N           --
------------------------------------------------------------------------------
local default_colors = require("kanagawa.colors").setup()

local tex_color_overrides = {
    -- create a new hl-group using default palette colors and/or new ones
    -- This matches the names returned from :TSHighlightCapturesUnderCursor
    -- The colors are selected after looking alot in the kanagawa repository.
    ["@text.environment"] = { fg = default_colors.co },
    ["@text.environment.name"] = { fg = default_colors.st },
    -- Variables use color fg
}

-- TODO: Maybe make this adjustment based on the filetype
require'kanagawa'.setup({ overrides = tex_color_overrides})


vim.cmd.colorscheme("kanagawa")

-- Source personal configurations
require('Behavior') -- Generic keybindings
require('Completion') -- Code completion Configuration
require('Formatting') -- Custom code formatting methods
