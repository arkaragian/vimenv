-- Setup globals that I expect to be always available.
--  See `./lua/tj/globals.lua` for more information.
require("Globals")


local HomeDir = ""
if(jit.os == "Windows") then
    HomeDir = os.getenv("USERPROFILE")
else
    HomeDir = os.getenv("~")
end

--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Snippets support
Plug ('L3MON4D3/LuaSnip', {tag='v1.2.1'})

--Plug ('https://github.com/vim-latex/vim-latex.git', {tag='v1.10.0'})

--nvim api Autocompletion. Must be before lspconfig
Plug ('folke/neodev.nvim', {tag='v2.0.1'})

Plug ('https://github.com/neovim/nvim-lspconfig', {tag='v0.1.6'})


-- Solution nvim must be loaded before dap because in dap config we try to
-- see if there is a solution loaded.
Plug (HomeDir.."/source/repos/Solution.nvim")

--Plugins for debugging
Plug ('mfussenegger/nvim-dap', {tag='0.6.0'})
Plug ('rcarriga/nvim-dap-ui', {tag='v3.8.3'})




--Plugins for code completion. We use the cmp plugin. This also requires completion
--sources. For now we only use the lsp source
Plug 'hrsh7th/cmp-nvim-lsp' -- Source for internal nvim lua completion
Plug 'hrsh7th/cmp-buffer' -- Cmp source buffer
Plug 'onsails/lspkind.nvim' -- Formating of completion sources
Plug 'hrsh7th/cmp-nvim-lsp-signature-help' -- Signature help from lsp
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp' -- Autocompletion engine

-- Tree Sitter
Plug ('nvim-treesitter/nvim-treesitter',{['do'] = vim.fn[':TSUpdate'], tag = 'v0.9.2'})
-- Plug ('nvim-treesitter/playground') -- Deprecated since neovim 0.9
Plug ("nvim-treesitter/nvim-treesitter-textobjects")

-- Telescope dependencies and telescope
Plug ('nvim-lua/plenary.nvim', {tag='v0.1.3'})
Plug ('nvim-telescope/telescope.nvim',{tag='0.1.5'})


-- Tree viewer plugin. Configured automatically through after/plugin/nvim-tree.lua file
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

Plug ("tpope/vim-fugitive" , {tag ="v3.7"})

Plug ("godlygeek/tabular", {tag = "1.0.0"})
Plug ("akinsho/bufferline.nvim", {tag = "v3.1.0"})

-- This is a local directory pointed like that since the plugin is already under
-- development.
Plug ("rebelot/kanagawa.nvim", {commit= '4c8d48726621a7f3998c7ed35b2c2535abc22def'})
Plug ('mechatroner/rainbow_csv')
Plug ('lukas-reineke/indent-blankline.nvim', {tag='v2.20.3'})

Plug ('folke/which-key.nvim', {tag = 'v1.1.0'})
Plug ("Eandrju/cellular-automaton.nvim")

Plug ("tpope/vim-surround" ,{tag = "v2.2"})
Plug ("rcarriga/nvim-notify" ,{tag = "v3.11.0"})

Plug ("https://github.com/anuvyklack/hydra.nvim/", {commit="3ced42c0b6a6c85583ff0f221635a7f4c1ab0dd0"})

Plug ('https://github.com/nvim-neotest/neotest')
Plug ('https://github.com/Issafalcon/neotest-dotnet')
Plug ('https://github.com/rouge8/neotest-rust.git')

Plug ('https://github.com/numToStr/Comment.nvim.git',{commit='d9cfae1'}) -- This release is not tagget. Thus we point to the commit

Plug ('https://github.com/windwp/nvim-ts-autotag')


-- If you have nodejs
Plug ('iamcco/markdown-preview.nvim', { ['do']= "cd app && npx --yes yarn install" })


Plug ("https://github.com/mfussenegger/nvim-lint", {commit = "efc6fc8"})


-- For Future Installation
--Plug ("numToStr/Comment.nvim")
--Plug ("j-hui/fidget.nvim" ,{tag = "v2.2"})
--Plug ("https://github.com/AckslD/nvim-neoclip.lua")
--Plug ("https://github.com/luukvbaal/statuscol.nvim") -- Requires nvim 0.9
--Plug ("https://github.com/jbyuki/one-small-step-for-vimkind")
vim.call('plug#end')

------------------------------------------------------------------------------
--          M I N O R  P L U G I N S  C O N F I G U R A T I O N             --
------------------------------------------------------------------------------
vim.notify = require("notify")


------------------------------------------------------------------------------
--               N E O V I D E  C O N F I G U R A T I O N                   --
------------------------------------------------------------------------------
if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    -- vim.opt.guifont = { "Source Code Pro", "h14" } -- text below applies for VimScript
    -- Use neovide font definitions
    --
    --vim.opt.guifont = { "Cascadia Mono", "h10" } -- text below applies for VimScript
    vim.opt.guifont = "Cascadia_Mono:h10" -- text below applies for VimScript

    vim.keymap.set("i","<S-Insert>","<C-R>+", { noremap = true, silent = true })

    vim.opt.title = true
    vim.opt.titlestring = "Neovide - %<%F%=%l/%L-%P"
    vim.g.neovide_cursor_animate_in_insert_mode = true
    --vim.opt.titlestring = "Neovide - %F"
end
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
