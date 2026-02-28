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

-- ---Returns the code for the given struct
-- ---@param structname string
-- local function get_symbol_source(structname)
--     local current_buffer = 0
--     local params = vim.lsp.util.make_position_params(current_buffer, "utf-8")
--
--     vim.lsp.buf_request_all(current_buffer, 'textDocument/typeDefinition', params, function(result)
--
--         if(result.error ~= nil) then
--             print("Got Error")
--         end
--
--         local uri = result[1].uri
--
--         -- call csnip as this:
--         -- /path/to/csnip uri structname
--         -- Get the result and return it
--
--
--
--     end)
--
--
-- end
--
-- --TODO: Refactor this to get the name under the cursoe
-- vim.keymap.set("n", "<leader>ss", get_symbol_source)


---Run external command and capture stdout/stderr.
---@param cmd string[]
---@param on_done fun(code: integer, stdout: string, stderr: string)
local function run(cmd, on_done)
    vim.system(cmd, { text = true }, function(obj)
        local code = obj.code or -1
        local stdout = obj.stdout or ""
        local stderr = obj.stderr or ""
        vim.schedule(function()
            on_done(code, stdout, stderr)
        end)
    end)
end

---Pick first successful LSP response from buf_request_all.
---@param responses table
---@return any|nil
local function first_lsp_result(responses)
    for _, resp in pairs(responses or {}) do
        if resp and resp.error == nil and resp.result ~= nil then
            return resp.result
        end
    end
    return nil
end

---Normalize LSP typeDefinition result into a single location.
---LSP can return Location, Location[], or LocationLink[]
---@param r any
---@return table|nil location
local function first_location(r)
    if r == nil then
        return nil
    end
    if vim.islist(r) then
        return r[1]
    end
    return r
end

---Extract URI from Location or LocationLink
---@param loc table
---@return string|nil
local function location_uri(loc)
    return loc.uri or (loc.targetUri)
end

---Returns the code for the given struct (async; result handled in callback)
---@param structname string|nil
function get_symbol_source(structname)

    if structname == nil or structname == "" then
        structname = vim.fn.expand("<cword>")
    end

    local current_buffer = 0
    local params = vim.lsp.util.make_position_params(current_buffer, "utf-8")

    vim.lsp.buf_request_all(current_buffer, "textDocument/typeDefinition", params, function(responses)
        local r = first_lsp_result(responses)
        if r == nil then
            vim.notify("No typeDefinition result from any LSP client", vim.log.levels.WARN)
            return
        end

        local loc = first_location(r)
        if loc == nil then
            vim.notify("typeDefinition returned empty locations", vim.log.levels.WARN)
            return
        end

        local uri = location_uri(loc)
        if uri == nil then
            vim.notify("Could not extract URI from typeDefinition location", vim.log.levels.ERROR)
            return
        end

        -- Call: csnip uri structname
        -- You can replace "csnip" with an absolute path if needed.
        run({ "D:/source/repos/CSnip/build/csnip", uri, structname }, function(code, stdout, stderr)
            if code ~= 0 then
                vim.notify(("csnip failed (%d): %s"):format(code, stderr), vim.log.levels.ERROR)
                return
            end

            -- Minimal: just print
            -- print(stdout)

            -- Better UX: open in a scratch buffer
            local lines = vim.split(stdout, "\n", { plain = true })
            vim.cmd("vnew")
            local bufnr = vim.api.nvim_get_current_buf()
            vim.bo[bufnr].buftype = "nofile"
            vim.bo[bufnr].bufhidden = "wipe"
            vim.bo[bufnr].swapfile = false
            vim.bo[bufnr].filetype = "csharp" -- or whatever csnip returns
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            vim.api.nvim_buf_set_name(bufnr, ("csnip://%s"):format(structname))
        end)
    end)
end

local function gss()
    -- pas nill to use cword
    get_symbol_source(nil);
end

vim.keymap.set("n", "<leader>ss", gss ,{ desc = "Show source for type under cursor via csnip" })
