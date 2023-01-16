-- This file defines the behavior of neovim
-- Author: Aris Karagiannidis arkaragian@gmail.com
--
-- This file needs to be called first at the start of init.lua


-- Display invisible characters
vim.cmd.set("invlist")

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
opt.tabstop = 4         -- Number of spaces that a <Tab> in the file counts for.
opt.softtabstop = 4     -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.


-- Control the identation side
opt.shiftwidth = 4      -- Number of characters that will be used for identation
opt.listchars = {
    tab ='<->',         -- This will make the tab appear as > <> or <-- (n-times for dash) -->
}

-- Use spaces instead of tabs when pressing the tab key. To insert a tab literally
-- Type CTRL+q (Swith to literal mode for the nex char) then 
opt.expandtab = true

--Set file ending to unix. This is important for bash scripts
opt.ff = "unix"

-- Define Some General keybindings
vim.keymap.set('n','bl',vim.cmd.bnext)
vim.keymap.set('n','bh',vim.cmd.bprevious)


vim.keymap.set('n','<leader>pu',':PlugUpdate<CR>')

-- Configure our shell to be able to execute the commands from within VIM
opt.shell='cmd.exe'


-- Configure CTRL+C in the clipboard register
vim.keymap.set('v','<C-c>','"+y')

local texGroup = vim.api.nvim_create_augroup("LatexSpellCheck", { clear = true })

-- Create autocommand in the BufEnter event that is matched against a pattern
-- BufEnter event is nice for setting options for a file type accoding to
-- vim documentation :h BufEnter. This command bellongs to our Formatting group
--
-- This means that when we enter a buffer with the specified pattern register
-- the commands that are defined in the SetupKeyBindings function.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*.tex"},
  command = ":setlocal spell spelllang=en_us",
  group = texGroup,
})
