--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

-- Similarly define the shell here because lazy will try to use our environment
if (string.lower(jit.os) == "windows") then
    -- Configure our shell to be able to execute the commands from within VIM
    -- even if we execute vim through bash
    opt.shell='cmd.exe'
else

local plugins = {
    {"rebelot/kanagawa.nvim", commit= "4c8d48726621a7f3998c7ed35b2c2535abc22def" , lazy=false, priority=1000}, -- Ok
    {"L3MON4D3/LuaSnip", tag="v1.2.1"}, -- Ok
    {"folke/neodev.nvim", tag="v2.0.1"}, -- Make this exeute before lspconfig
    {"neovim/nvim-lspconfig", tag="v0.1.5", dependencies = {"folke/neodev.nvim"}}      , -- Ok
    {"nvim-lua/plenary.nvim", tag="v0.1.2"}, -- Ok
    {"mfussenegger/nvim-dap", tag="0.4.0"}, -- Ok
    {"rcarriga/nvim-dap-ui", tag="v3.2.4", dependencies = {"mfussenegger/nvim-dap"}}  , --Ok
    {"hrsh7th/nvim-cmp"}, -- Autocompletion engine
    {"hrsh7th/cmp-nvim-lsp", dependencies = {"hrsh7th/nvim-cmp"}}, -- Source for internal nvim lua completion
    {"hrsh7th/cmp-buffer", dependencies = {"hrsh7th/nvim-cmp"}}, -- Cmp source buffer
    {"onsails/lspkind.nvim", dependencies = {"hrsh7th/nvim-cmp"}}, -- Formating of completion sources
    {"hrsh7th/cmp-nvim-lsp-signature-help", dependencies = {"hrsh7th/nvim-cmp"}}, -- Signature help from lsp
    {"saadparwaiz1/cmp_luasnip", dependencies = {"hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip"}},

    --{"nvim-treesitter/nvim-treesitter"   , {["do"] = vim.fn[":TSUpdate"]                      , tag = "v0.8.1"}}
    {"nvim-treesitter/nvim-treesitter", tag = "v0.8.1"},
    {"nvim-treesitter/playground", dependencies = {"nvim-treesitter/nvim-treesitter"}} ,
    {"nvim-telescope/telescope.nvim", tag="0.1.1", dependencies={"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"}} ,
    {"nvim-tree/nvim-web-devicons"},
    {"nvim-tree/nvim-tree.lua", dependencies={"nvim-tree/nvim-web-devicons"}},
    {"tpope/vim-fugitive", tag ="v3.7"},
    {"godlygeek/tabular", tag = "1.0.0"},
    {"akinsho/bufferline.nvim", tag = "v3.1.0", dependencies={"nvim-tree/nvim-web-devicons"}},
    {"mechatroner/rainbow_csv"},
    {"lukas-reineke/indent-blankline.nvim" , tag="v2.20.3"},
    {"folke/which-key.nvim", tag = "v1.1.0"},
    {Name="Solution.nvim", dir = "~/source/repos/Solution.nvim"}
}

require("lazy").setup(plugins)


--local Plug = vim.fn['plug#']
--vim.call('plug#begin')
---- Snippets support
--Plug ('L3MON4D3/LuaSnip', {tag='v1.2.1'})
--
----Plug ('https://github.com/vim-latex/vim-latex.git', {tag='v1.10.0'})
--
----nvim api Autocompletion. Must be before lspconfig
--Plug ('folke/neodev.nvim', {tag='v2.0.1'})
--
--Plug ('https://github.com/neovim/nvim-lspconfig', {tag='v0.1.5'})
--
----Plugins for debugging
--Plug ('mfussenegger/nvim-dap', {tag='0.4.0'})
--Plug ('rcarriga/nvim-dap-ui', {tag='v3.2.4'})
--
--
--
--
----Plugins for code completion. We use the cmp plugin. This also requires completion
----sources. For now we only use the lsp source
--Plug 'hrsh7th/cmp-nvim-lsp' -- Source for internal nvim lua completion
--Plug 'hrsh7th/cmp-buffer' -- Cmp source buffer
--Plug 'onsails/lspkind.nvim' -- Formating of completion sources
--Plug 'hrsh7th/cmp-nvim-lsp-signature-help' -- Signature help from lsp
--Plug 'saadparwaiz1/cmp_luasnip'
--Plug 'hrsh7th/nvim-cmp' -- Autocompletion engine
--
---- Tree Sitter
--Plug ('nvim-treesitter/nvim-treesitter',{['do'] = vim.fn[':TSUpdate'], tag = 'v0.8.1'})
--Plug 'nvim-treesitter/playground'
--
---- Telescope dependencies and telescope
--Plug ('nvim-lua/plenary.nvim', {tag='v0.1.2'})
--Plug ('nvim-telescope/telescope.nvim',{tag='0.1.1'})
--
--
---- Tree viewer plugin. Configured automatically through after/plugin/nvim-tree.lua file
--Plug 'nvim-tree/nvim-web-devicons'
--Plug 'nvim-tree/nvim-tree.lua'
--
--Plug ("tpope/vim-fugitive" , {tag ="v3.7"})
--
--Plug ("godlygeek/tabular", {tag = "1.0.0"})
--Plug ("akinsho/bufferline.nvim", {tag = "v3.1.0"})
--
---- This is a local directory pointed like that since the plugin is already under
---- development.
--Plug '~/source/repos/Solution.nvim'
--Plug ("rebelot/kanagawa.nvim", {commit= '4c8d48726621a7f3998c7ed35b2c2535abc22def'})
--Plug ('mechatroner/rainbow_csv')
--Plug ('lukas-reineke/indent-blankline.nvim', {tag='v2.20.3'})
--
--Plug ('folke/which-key.nvim', {tag = 'v1.1.0'})
--vim.call('plug#end')

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
