-- This file defines the behavior of neovim
-- Author: Aris Karagiannidis arkaragian@gmail.com
--
-- This file needs to be called first at the start of init.lua

--First define a colorscheme
vim.cmd('colorscheme codedark')

--Now define options for that use the meta-accessor o (option) in order to get the option.
--This is the same as calling:
--
--gvim.api.nvim_win_set_option(0, 'number', true)
--
--other meta accessors are go(Global options), bo(buffer local option) wo(window local option)

--Display both relative and absolute numbers. In order to do that we need to enable both options
vim.o.number = true
vim.o.relativenumber = true

--Disable wraping when the line is too large
vim.o.wrap = false

--Set encoding
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

--Disable swapfile
vim.o.swapfile = false

--Aumaticaly read the file from disk what it changes
vim.o.autoread = true

vim.g.mapleader = ' '

vim.o.tabstop = 2
