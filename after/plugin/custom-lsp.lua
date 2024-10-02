local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references" , { clear = true })
local augroup_codelens  = vim.api.nvim_create_augroup("custom-lsp-codelens"   , { clear = true })

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  local function WorkspaceList()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n' , 'gD'         , vim.lsp.buf.declaration             , { desc="Go to declaration"          , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , 'gd'         , vim.lsp.buf.definition              , { desc="Go to definition"           , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , 'K'          , vim.lsp.buf.hover                   , { desc="Hover"                      , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , 'gi'         , vim.lsp.buf.implementation          , { desc="Go to implementation"       , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , '<C-k>'      , vim.lsp.buf.signature_help          , { desc="Display signature help"     , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , '<leader>wa' , vim.lsp.buf.add_workspace_folder    , { desc="Add workspace folder"       , noremap=true , silent=true , buffer=bufnr }) -- Shorthand for "workspace add"
  vim.keymap.set('n' , '<leader>wr' , vim.lsp.buf.remove_workspace_folder , { desc="Remove workspace folder"    , noremap=true , silent=true , buffer=bufnr }) -- Shorthand for "workspace remove"
  vim.keymap.set('n' , '<leader>D'  , vim.lsp.buf.type_definition         , { desc="Type Definition"            , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , '<leader>ca' , vim.lsp.buf.code_action             , { desc="Perform code action"        , noremap=true , silent=true , buffer=bufnr }) -- Shorthand for "Code Actions"
  vim.keymap.set('n' , '<leader>fr' , vim.lsp.buf.references              , { desc="Find References"            , noremap=true , silent=true , buffer=bufnr }) -- Shorthand for "Find references"
  vim.keymap.set('n' , '<leader>e'  , vim.diagnostic.open_float           , { desc="Open Diagnostic float"      , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , '[d'         , vim.diagnostic.goto_prev            , { desc="Go to next diagnostic"      , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , ']d'         , vim.diagnostic.goto_next            , { desc="Go to previous diagnostic"  , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , '<leader>q'  , vim.diagnostic.setloclist           , { desc="Set Location List"          , noremap=true , silent=true , buffer=bufnr })
  vim.keymap.set('n' , '<leader>rn' , vim.lsp.buf.rename                  , { desc="Rename symbol under cursor" , noremap=true , silent=true , buffer=bufnr }) -- Shorthand for "Rename". This will rename the symbol under the cursor
  vim.keymap.set('n' , '<leader>wl' , WorkspaceList                       , { desc="List workspace folders"     , noremap=true , silent=true , buffer=bufnr }) --Shorthand for "workspace list"
  vim.keymap.set('n' , '<leader>fo' , vim.lsp.buf.format                  , { desc="Format File with LSP"       , noremap=true , silent=true , buffer=bufnr }) --Shorthand for "FOrmat"


  --vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

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
    autocmd_clear { group = augroup_highlight , buffer = bufnr }
    autocmd       { "CursorHold"              , augroup_highlight , vim.lsp.buf.document_highlight , bufnr }
    autocmd       { "CursorMoved"             , augroup_highlight , vim.lsp.buf.clear_references   , bufnr }
  end

  --If the LSP provides codelens capabilites enable them.
  if  client.server_capabilities.codeLensProvider then
      autocmd_clear { group = augroup_codelens , buffer = bufnr }
      autocmd       { "BufEnter"                        , augroup_codelens  , vim.lsp.codelens.refresh , bufnr , once = true }
      autocmd       {{ "BufWritePost", "CursorHold" }   , augroup_codelens  , vim.lsp.codelens.refresh , bufnr }
  end


  local s = string.format("LSP server %s attached",client.name)
  vim.notify(s,vim.log.levels.INFO,{title = "Language Server Protocol"})
end

-- local on_error = function(code)
--         vim.notify(code, vim.log.levels.ERROR, {title="Custom LSP On Error"});
-- end
--
-- local client = vim.lsp.start_client ({
--     name = "custom_lsp",
--     cmd = {"C:/Users/Admin/source/repos/latex-lsp/LatexLSP/bin/Debug/net7.0/LatexLSP.exe"},
--     --TODO: This throws and error. Though it is a directory. Need to check what happens
--     --cmd_cwd = "C:/Users/Admin/source/repos/latex-lsp/LatexLSP/bin/Debug/net7.0/",
--     on_attach = on_attach,
--     on_error = on_error
-- })
--
-- if not client then
--     vim.notify("Client failed to start!", vim.log.levels.ERROR, {title="Custom LSP"});
--     return;
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--         -- if not client then
--         --     vim.notify("Hey no client",vim.log.levels.INFO)
--         -- else
--         --     vim.notify("Hey client!",vim.log.levels.INFO)
--         -- end
--         vim.lsp.buf_attach_client(0, client)
--     end,
-- })
