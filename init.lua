-- For troubleshooting reasons
-- vim.opt.runtimepath:remove(vim.fn.stdpath("config") .. "/after")
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
-- require("Formatting") -- Custom code formatting methods



HomeDir = ""
if(jit.os == "Windows") then
    HomeDir = os.getenv("USERPROFILE")
else
    HomeDir = os.getenv("~")
end

-- Setup lazy.nvim
require("lazy").setup({
  -- Import spec by file. Note. At this point solution depends on
  -- dap, notify and telescope.
  -- spec = {
  --
  --     require('plugins.kanawaga'),
  --     require('plugins.nvim-dap'),
  --     require('plugins.nvim-notify'),
  --     require('plugins.solution'),
  --     require('plugins.telescope'),
  --
  --     require('plugins.blankline'),
  --     require('plugins.bufferline'),
  --     require('plugins.fugitive'),
  --     require('plugins.hydra'),
  --     require('plugins.lazydev'),
  --     --
  --     require('plugins.markdown-preview'),
  --     -- This may be problematic
  --     require('plugins.nvim-cmp'),
  --     require('plugins.nvim-lspconfig'),
  --     --
  --     require('plugins.nvim-tree'),
  --     require('plugins.nvim-treesitter'),
  --     require('plugins.oil'),
  --     require('plugins.rainbow-csv'),
  --     --
  --     require('plugins.remote-plugins'),
  --     require('plugins.tabular'),
  --     require('plugins.vim-surround'),
  --     require('plugins.which-key'),
  -- },
  -- or import your plugins by directory
  spec = {
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


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
local function set_colorscheme(name)
    local ok, err = pcall(vim.cmd.colorscheme, name)
    print("Could not set the color scheme " .. err);
    return ok
end

if not set_colorscheme("kanagawa") then
    vim.cmd.colorscheme("default")
end
