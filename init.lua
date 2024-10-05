-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup globals that I expect to be always available.
--  See `./lua/tj/globals.lua` for more information.
require("Globals")

-- Source personal configurations
require("Behavior") -- Generic keybindings
-- require("Completion") -- Code completion Configuration
require("Formatting") -- Custom code formatting methods



HomeDir = ""
if(jit.os == "Windows") then
    HomeDir = os.getenv("USERPROFILE")
else
    HomeDir = os.getenv("~")
end

-- Setup lazy.nvim
require("lazy").setup({
  -- spec = {
  --   -- add your plugins here
  -- },
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- -- --Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
-- -- local Plug = vim.fn['plug#']
-- -- vim.call('plug#begin')
-- -- -- Snippets support
-- -- Plug ('L3MON4D3/LuaSnip', {tag='v2.3.0'})
-- -- 
-- -- --Plug ('https://github.com/vim-latex/vim-latex.git', {tag='v1.10.0'})
-- -- 
-- -- --nvim api Autocompletion. Must be before lspconfig
-- -- -- TODO: Replace with neodev
-- -- Plug ('folke/neodev.nvim', {tag='v2.0.1'})
-- -- 
-- -- Plug ('https://github.com/neovim/nvim-lspconfig', {tag='v1.0.0'})
-- -- 
-- -- 
-- -- -- Solution nvim must be loaded before dap because in dap config we try to
-- -- -- see if there is a solution loaded.
-- -- Plug (HomeDir.."/source/repos/Solution.nvim")
-- -- 
-- -- --Plugins for debugging
-- -- Plug ('mfussenegger/nvim-dap', {tag='0.8.0'})
-- -- Plug ('rcarriga/nvim-dap-ui', {tag='v4.0.0'})
-- -- 
-- -- 
-- -- 
-- -- 
-- -- --Plugins for code completion. We use the cmp plugin. This also requires completion
-- -- --sources. For now we only use the lsp source
-- -- Plug 'hrsh7th/cmp-nvim-lsp' -- Source for internal nvim lua completion
-- -- Plug 'hrsh7th/cmp-buffer' -- Cmp source buffer
-- -- Plug 'onsails/lspkind.nvim' -- Formating of completion sources
-- -- Plug 'hrsh7th/cmp-nvim-lsp-signature-help' -- Signature help from lsp
-- -- Plug 'saadparwaiz1/cmp_luasnip'
-- -- Plug 'hrsh7th/nvim-cmp' -- Autocompletion engine
-- -- 
-- -- -- Tree Sitter
-- -- Plug ('nvim-treesitter/nvim-treesitter',{['do'] = vim.fn[':TSUpdate'], tag = 'v0.9.2'})
-- -- Plug ("nvim-treesitter/nvim-treesitter-textobjects")
-- -- 
-- -- -- Telescope dependencies and telescope
-- -- Plug ('nvim-lua/plenary.nvim', {tag='v0.1.4'})
-- -- Plug ('nvim-telescope/telescope.nvim',{tag='0.1.8'})
-- -- 
-- -- 
-- -- -- Tree viewer plugin. Configured automatically through after/plugin/nvim-tree.lua file
-- -- Plug 'nvim-tree/nvim-web-devicons'
-- -- Plug ('nvim-tree/nvim-tree.lua', {tag="nvim-tree: v1.7.1"})
-- -- 
-- -- Plug ("tpope/vim-fugitive" , {tag ="v3.7"})
-- -- 
-- -- Plug ("godlygeek/tabular", {tag = "1.0.0"})
-- -- Plug ("akinsho/bufferline.nvim", {tag = "v4.7.0"})
-- -- 
-- -- -- This is a local directory pointed like that since the plugin is already under
-- -- -- development.
-- -- Plug ("rebelot/kanagawa.nvim", {commit= 'f491b0fe68fffbece7030181073dfe51f45cda81'})
-- -- Plug ('mechatroner/rainbow_csv')
-- -- Plug ('lukas-reineke/indent-blankline.nvim', {tag='v3.7.2'})
-- -- 
-- -- Plug ('folke/which-key.nvim', {tag = 'v3.13.3'})
-- -- Plug ("Eandrju/cellular-automaton.nvim")
-- -- 
-- -- Plug ("tpope/vim-surround" ,{tag = "v2.2"})
-- -- Plug ("rcarriga/nvim-notify" ,{tag = "v3.14.0"})
-- -- 
-- -- Plug ("https://github.com/anuvyklack/hydra.nvim/", {tag="v1.0.2"})
-- -- 
-- -- 
-- -- Plug ("nvim-neotest/nvim-nio", {tag = "v1.10.0"})
-- -- Plug ("https://github.com/nvim-neotest/neotest", {tag = "v5.6.0"})
-- -- Plug ("https://github.com/Issafalcon/neotest-dotnet", {tag = "v1.6.5"})
-- -- Plug ('https://github.com/rouge8/neotest-rust.git')
-- -- 
-- -- Plug ('https://github.com/numToStr/Comment.nvim.git',{tag="v0.8.0"}) -- This release is not tagget. Thus we point to the commit
-- -- 
-- -- Plug ('https://github.com/windwp/nvim-ts-autotag')
-- -- 
-- -- 
-- -- -- If you have nodejs
-- -- Plug ('iamcco/markdown-preview.nvim', { ['do']= "cd app && npx --yes yarn install" })
-- -- 
-- -- 
-- -- Plug ("https://github.com/mfussenegger/nvim-lint", {commit = "efc6fc8"})
-- -- 
-- -- 
-- -- -- For Future Installation
-- -- --Plug ("numToStr/Comment.nvim")
-- -- --Plug ("j-hui/fidget.nvim" ,{tag = "v2.2"})
-- -- --Plug ("https://github.com/AckslD/nvim-neoclip.lua")
-- -- --Plug ("https://github.com/luukvbaal/statuscol.nvim") -- Requires nvim 0.9
-- -- --Plug ("https://github.com/jbyuki/one-small-step-for-vimkind")
-- -- vim.call('plug#end')

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
vim.cmd.colorscheme("kanagawa")
