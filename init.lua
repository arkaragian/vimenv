--Call the vim-plug using the vimscript methods since vim plug does not have native lua calls.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'https://github.com/vim-latex/vim-latex.git'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'tomasiser/vim-code-dark'
vim.call('plug#end')


vim.cmd('colorscheme codedark')
--Use the meta-accessor o (option) in order to get the option. this is the same as calling
--Other meta accessors are go(Global options), bo(buffer local option) wo(window local option)
--
--gvim.api.nvim_win_set_option(0, 'number', true)
--vim.wo.number = true

--Display both relative and absolute numbers. In order to do that we need
--to enable both options
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local omnisharp_bin = "C:\\Users\\Aris\\bin\\omnisharp-win-x64-net6.0\\OmniSharp.exe"

--Enable the LSP. This requires that the lsp is installed at the path
require'lspconfig'.omnisharp.setup {
    cmd = { omnisharp_bin }, --Arguments are added automatically from the nvim-lspconfig
    on_attach = on_attach,
    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

}
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--
-- The vim keymap set is as follows:
-- set({mode}, {lhs}, {rhs}, {opts})
-- {mode} is the vim mode line normal, visual, insert and so on
-- {lhs} Left hand side, what to map
-- {rhs} What to do
-- {opts} are additional options

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
