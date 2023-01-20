-- This file defines the behavior of neovim
-- Author: Aris Karagiannidis arkaragian@gmail.com
--
-- This file needs to be called first at the start of init.lua


-- Display invisible characters
vim.cmd.set("invlist")

-- Map Q to lowercase q since I make this mistake often.
vim.api.nvim_create_user_command("Q","q",{})


-- Set the vim options as a local variable so that i can easily change it later if needed.
local opt = vim.opt

if (string.lower(jit.os) == "windows") then
    opt.makeprg = "gnumake"

    -- Configure our shell to be able to execute the commands from within VIM
    opt.shell='cmd.exe'
else
    opt.makeprg = "make"
end

-- Always show the tabline
opt.showtabline = 2

-- Set colorcolumn
opt.colorcolumn = "79"

--Display both relative and absolute numbers.
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
vim.keymap.set('n','<leader>bl',vim.cmd.bnext, {desc = "Move to next buffer"})
vim.keymap.set('n','<leader>bh',vim.cmd.bprevious, {desc = "Move to previous buffer"})

vim.keymap.set('n','<leader>pu',':PlugUpdate<CR>', {desc = "Update plugins"})



-- Configure CTRL+C in the clipboard register
vim.keymap.set('v','<C-c>','"+y',{desc = "Copy to system clipboard"})

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
