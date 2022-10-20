-- This file defines the behavior of neovim
-- Author: Aris Karagiannidis arkaragian@gmail.com
--
-- This file needs to be called first at the start of init.lua

--First define a colorscheme
--local success = (pcall(vim.cmd,'colorscheme codedark'))
--if not sucess then
--    print("Could not apply colorscheme. Reverting to default")
--end
local c = require('vscode.colors')
require('vscode').setup({
    italic_comments = true,
})

-- Display invisible characters
vim.cmd('set invlist')

-- Set the vim options as a local variable so that i can easily change it later if needed.
local opt = vim.opt

-- Set colorcolumn
opt.colorcolumn = "79"

--Now define options for that use the meta-accessor o (option) in order to get the option.
--This is the same as calling:
--
--gvim.api.nvim_win_set_option(0, 'number', true)
--
--other meta accessors are go(Global options), bo(buffer local option) wo(window local option)

--Display both relative and absolute numbers. In order to do that we need to enable both options
opt.number = true
opt.relativenumber = true

--Disable wraping when the line is too large
opt.wrap = false

--Set encoding
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

--Disable swapfile
opt.swapfile = false

--Aumaticaly read the file from disk what it changes
opt.autoread = true

-- Set leader to spacebar
vim.g.mapleader = ' '

--Add two characters when typing the tab key
opt.tabstop = 2
opt.softtabstop = 2
-- Control the identation side
opt.shiftwidth = 2
opt.listchars = {
	tab ='->',
}
-- Use spaces instead of tabs when pressing the tab key
opt.expandtab = true

--Set file ending to unix. This is important for bash scripts
opt.ff = "unix"
