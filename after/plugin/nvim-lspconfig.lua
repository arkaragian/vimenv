-- This file configures the LSP behavior of the editor
-- Author Aris Karagiannidis e-mail:arkaragian@gmail.com
--
-- Use an on_attach function to only map keys after the language server attaches to the current buffer
--
local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,{ desc="Go to declaration", noremap=true, silent=true, buffer=bufnr } )
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc="Go to definition", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc="Hover", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc="Go to implementation", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc="Display signature help", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc="Add workspace folder", noremap=true, silent=true, buffer=bufnr }) -- Shorthand for "workspace add"
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc="Remove workspace folder", noremap=true, silent=true, buffer=bufnr })-- Shorthand for "workspace remove"
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,{ desc="List workspace folders", noremap=true, silent=true, buffer=bufnr }) --Shorthand for "workspace list"
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,{ desc="Type Definition", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,{ desc="Perform code action", noremap=true, silent=true, buffer=bufnr }) -- Shorthand for "Code Actions"
  vim.keymap.set('n', '<leader>fr', vim.lsp.buf.references,{ desc="Find References", noremap=true, silent=true, buffer=bufnr })  -- Shorthand for "Find references"
  --vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,{ desc="Open Diagnostic float", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,{ desc="Go to next diagnostic", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next,{ desc="Go to previous diagnostic", noremap=true, silent=true, buffer=bufnr })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,{ desc="Set Location List", noremap=true, silent=true, buffer=bufnr } )
  
  -- Add some common functionallity here
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,{ desc="Rename symbol under cursor", noremap=true, silent=true, buffer=bufnr }) -- Shorthand for "Rename". This would rename the symbol under the cursor

  local autocmd_clear = vim.api.nvim_clear_autocmds
  local autocmd = function(args)
      local event = args[1]
      local group = args[2]
      local callback = args[3]

      vim.api.nvim_create_autocmd(event, {
          group = group,
          buffer = args[4],
          callback = function()
              callback()
          end,
          once = args.once,
      })
  end

    -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    autocmd_clear { group = augroup_highlight, buffer = bufnr }
    autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr }
    autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr }
  end

  --if false and client.server_capabilities.codeLensProvider then
  if false and client.server_capabilities.codeLensProvider then
      autocmd_clear { group = augroup_codelens, buffer = bufnr }
      autocmd { "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
      autocmd { { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
  end

end

local omnisharp_bin = "OmniSharp.exe"

--Enable the LSP. This requires that the lsp is installed at the path
require('lspconfig').omnisharp.setup {
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


local clangd_bin = "clangd.exe"
--Enable the LSP. This requires that the lsp is installed at the path
require('lspconfig').clangd.setup {
    --TODO: Configure the query driver
    cmd = { clangd_bin ,"--log=error","--pretty"}, --Arguments are added automatically from the nvim-lspconfig
    on_attach = on_attach,
}

-- To get builtin LSP running, do something like:
-- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
--require('nlua.lsp.nvim').setup(require('lspconfig'), {
--  on_attach = on_attach,

  -- Include globals you want to tell the LSP are real :)
  --globals = {
    -- Colorbuddy
  --  "Color", "c", "Group", "g", "s",
  --}
--})
-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

--require('lspconfig').lua_ls.setup
--Use the above live when we move to lspconfig v0.2
require('lspconfig').sumneko_lua.setup {
  cmd = {"lua-language-server.exe"},
  on_attach = on_attach,
 -- capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false -- Stop asking for luassert
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false, },
    },
  },
}

-- TODO:Evaluate those capabilities
--local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
--vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())





-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--
-- The vim keymap set is as follows:
-- set({mode}, {lhs}, {rhs}, {opts})
-- {mode} is the vim mode line normal, visual, insert and so on
-- {lhs} Left hand side, what to map
-- {rhs} What to do
-- {opts} are additional options
