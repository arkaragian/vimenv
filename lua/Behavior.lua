-- This file defines the behavior of neovim
-- Author: Aris Karagiannidis arkaragian@gmail.com
--
-- This file needs to be called first at the start of init.lua


-- Display invisible characters
vim.cmd.set("invlist")

-- Map Q to lowercase q since I make this mistake often.
vim.api.nvim_create_user_command("Q","q",{})
vim.api.nvim_create_user_command("Qa","qa",{})
vim.api.nvim_create_user_command("Wq","wq",{})


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
--TODO: Investigate this
opt.guitablabel="%t"

-- Set colorcolumn
opt.colorcolumn = "78,79,80,81,82"

--Display both relative and absolute numbers.
opt.number = true
--opt.relativenumber = true -- This would not fit my taste

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
vim.keymap.set("n", "<leader>mir", "<cmd>CellularAutomaton make_it_rain<CR>" , {desc = "Make it rain"})
vim.keymap.set("n", "<leader>gol", "<cmd>CellularAutomaton game_of_life<CR>" , {desc = "The Game of Live"})

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
vim.keymap.set('n','<S-Right>',vim.cmd.bnext, {desc = "Move to next buffer"})
vim.keymap.set('n','<S-Left>',vim.cmd.bprevious, {desc = "Move to previous buffer"})
--vim.keymap.set('n','<C-w>',vim.cmd.bdelete, {desc = "Delete current buffer"})
vim.keymap.set('n','<A-q>',vim.cmd.bdelete, {desc = "Delete current buffer"})

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
  command = ":setlocal spell spelllang=en_us,el",
  group = texGroup,
})

vim.keymap.set('n','<leader>xf', ':PlenaryBustedFile %<CR>',{desc = "Execute Lua spec file"})

-- greek layout keybindings ---
--
--

vim.keymap.set('n','<F5>', ':make<CR>', {desc = "Call make program"})

--- GREEK LAYOUT KEYBINDINGS---o
--assign keyboard commands while using the greek keyboard:
vim.keymap.set('n','Α', 'A')
vim.keymap.set('n','Β', 'B')
vim.keymap.set('n','Ψ', 'C')
vim.keymap.set('n','Δ', 'D')
vim.keymap.set('n','Ε', 'E')
vim.keymap.set('n','Φ', 'F')
vim.keymap.set('n','Γ', 'G')
vim.keymap.set('n','Η', 'H')
vim.keymap.set('n','Ι', 'I')
vim.keymap.set('n','Ξ', 'J')
vim.keymap.set('n','Κ', 'K')
vim.keymap.set('n','Λ', 'L')
vim.keymap.set('n','Μ', 'M')
vim.keymap.set('n','Ν', 'N')
vim.keymap.set('n','Ο', 'O')
vim.keymap.set('n','Π', 'P')
vim.keymap.set('n','Q', 'Q')

vim.keymap.set('n','Ρ','R')
vim.keymap.set('n','Σ','S')
vim.keymap.set('n','Τ','T')
vim.keymap.set('n','Θ','U')
vim.keymap.set('n','Ω','V')
vim.keymap.set('n','W','W')
vim.keymap.set('n','Χ','X')
vim.keymap.set('n','Υ','Y')
vim.keymap.set('n','Ζ','Z')
vim.keymap.set('n','α','a')
vim.keymap.set('n','β','b')
vim.keymap.set('n','ψ','c')
vim.keymap.set('n','δ','d')
vim.keymap.set('n','ε','e')
vim.keymap.set('n','φ','f')
vim.keymap.set('n','γ','g')
vim.keymap.set('n','η','h')
vim.keymap.set('n','ι','i')
vim.keymap.set('n','ξ','j')

vim.keymap.set('n','κ', 'k')
vim.keymap.set('n','λ', 'l')
vim.keymap.set('n','μ', 'm')
vim.keymap.set('n','ν', 'n')
vim.keymap.set('n','ο', 'o')
vim.keymap.set('n','π', 'p')
vim.keymap.set('n','q', 'q')
vim.keymap.set('n','ρ', 'r')
vim.keymap.set('n','σ', 's')
vim.keymap.set('n','τ', 't')
vim.keymap.set('n','θ', 'u')
vim.keymap.set('n','ω', 'v')
vim.keymap.set('n','ς', 'w')
vim.keymap.set('n','χ', 'x')
vim.keymap.set('n','υ', 'y')
vim.keymap.set('n','ζ', 'z')

-- Other greek mappings
vim.keymap.set('n','δδ', 'dd')
vim.keymap.set('n','υυ', 'yy')


vim.keymap.set('n','ψς', 'cw')
vim.keymap.set('n','δς', 'dw')
vim.keymap.set('n','ψας', 'caw')


--vim.api.nvim_create_user_command("ςσ","wq",{})
--vim.api.nvim_create_user_command("ς","w",{})





vim.keymap.set('n','<leader>gcc', ":TSHighlightCapturesUnderCursor<CR>",{ noremap = true, silent = false})
