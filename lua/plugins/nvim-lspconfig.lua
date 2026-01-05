local augroup_codelens  = vim.api.nvim_create_augroup("custom-lsp-codelens"   , { clear = true })
local on_attach_set_maps = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


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

  -- print("Server Capabilities")
  -- for k, v in pairs(client.server_capabilities) do
  --     print("Key:" .. k)
  --     print("Value:" .. vim.inspect(v))
  -- end

    -- Set autocommands conditional on server_capabilities
  -- if client.server_capabilities.documentHighlightProvider then
  --   autocmd_clear { group = augroup_highlight , buffer = bufnr }
  --   autocmd       { "CursorHold"              , augroup_highlight , vim.lsp.buf.document_highlight , bufnr }
  --   autocmd       { "CursorMoved"             , augroup_highlight , vim.lsp.buf.clear_references   , bufnr }
  -- end

  --If the LSP provides codelens capabilites enable them.
  --Note currently razor is not supported by codelens.
  if client.server_capabilities.codeLensProvider and vim.bo[bufnr].filetype ~= "razor" then
      autocmd_clear { group = augroup_codelens , buffer = bufnr }
      autocmd       { "BufEnter"                        , augroup_codelens  , vim.lsp.codelens.refresh , bufnr , once = true }
      autocmd       {{ "BufWritePost", "CursorHold" }   , augroup_codelens  , vim.lsp.codelens.refresh , bufnr }
  end


  local s = string.format("LSP server %s attached",client.name)
  vim.notify(s,vim.log.levels.INFO,{title = "Language Server Protocol"})
end

return {
    "neovim/nvim-lspconfig",
    version = "v2.5.0",
    -- dependencies = {
    --     {"seblyng/roslyn.nvim" },
    --     { "tris203/rzls.nvim", lazy = false } -- lazy-load on require("rzls.*")
    -- },
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = true,
      },
      -- Enable lsp cursor word highlighting
      document_highlight = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
              },
            },
          },
        },

         -- roslyn_ls = { },
         --

        -- roslyn_ls = {
        --     filetypes = {
        --         "cs",
        --         "razor"
        --     },
        --     cmd = {
        --         "Microsoft.CodeAnalysis.LanguageServer",
        --         "--logLevel",
        --         "Trace",
        --         "--extensionLogDirectory",
        --         "/tmp/roslyn_ls.log",
        --         "--stdio",
        --         "--razorSourceGenerator",
        --         "C:/Program Files/dotnet/sdk/9.0.302/Sdks/Microsoft.NET.Sdk.Razor/source-generators/Microsoft.CodeAnalysis.Razor.Compiler.dll",
        --         "--razorDesignTimePath",
        --         "C:/Program Files/dotnet/sdk/9.0.302/Sdks/Microsoft.NET.Sdk.Razor/targets/Microsoft.NET.Sdk.Razor.DesignTime.targets",
        --         "--extension",
        --         "C:/Users/Admin/bin/Microsoft.VisualStudioCode.RazorExtension.dll"
        --     },
        --     -- handlers = require("rzls.roslyn_handlers"),
        -- },

        -- roslyn_ls = {
        --   -- compose Roslyn's command with Razor args from Mason's rzls
        --   cmd = (function()
        --     local rz = vim.fn.expand("$MASON/packages/rzls/libexec")
        --     return {
        --       "roslyn", "--stdio",
        --       "--logLevel=Information",
        --       "--extensionLogDirectory", vim.fs.dirname(vim.lsp.get_log_path()),
        --       "--razorSourceGenerator=" .. vim.fs.joinpath(rz, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        --       "--razorDesignTimePath=" .. vim.fs.joinpath(rz, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
        --       "--extension", vim.fs.joinpath(rz, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
        --     }
        --   end)(),
        --   handlers = require("rzls.roslyn_handlers"),
        -- },


        omnisharp = {
            -- cmd = { "OmniSharp.exe" },
            cmd = {
              "OmniSharp.exe",
              "--languageserver",
              "--hostPID", vim.fn.getpid(),
            },
            --on_attach = on_attach_set_maps,
            settings = {
              FormattingOptions = {
                -- Enables support for reading code style, naming convention and analyzer
                -- settings from .editorconfig.
                EnableEditorConfigSupport = true,
                -- Specifies whether 'using' directives should be grouped and sorted during
                -- document formatting.
                OrganizeImports = true,
              },
              MsBuild = {
                -- If true, MSBuild project system will only load projects for files that
                -- were opened in the editor. This setting is useful for big C# codebases
                -- and allows for faster initialization of code navigation features only
                -- for projects that are relevant to code that is being edited. With this
                -- setting enabled OmniSharp may load fewer projects and may thus display
                -- incomplete reference lists for symbols.
                LoadProjectsOnDemand = nil,
              },
              RoslynExtensionsOptions = {
                -- Enables support for roslyn analyzers, code fixes and rulesets.
                EnableAnalyzersSupport = true,
                -- Enables support for showing unimported types and unimported extension
                -- methods in completion lists. When committed, the appropriate using
                -- directive will be added at the top of the current file. This option can
                -- have a negative impact on initial completion responsiveness,
                -- particularly for the first few completion sessions after opening a
                -- solution.
                EnableImportCompletion = true,
                -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                -- true
                AnalyzeOpenDocumentsOnly = true,
              },
              Sdk = {
                -- Specifies whether to include preview versions of the .NET SDK when
                -- determining which version to use for project loading.
                IncludePrereleases = true,
              },
            },
        },

        -- Just add a "blank" server entry in order to call the default setup
        texlab = {
        },

        rust_analyzer = {
        },

        clangd = {
        }

      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
  config = function(_, opts)

    -- Configure the nvim diagnostics from the items defined in the opts.
    vim.diagnostic.config(opts.diagnostics);


    -- Merge multiple capabilites tables:
    local total_capabilities = vim.tbl_deep_extend(
      "force",
      {}, -- An empy table
      vim.lsp.protocol.make_client_capabilities(), -- The neovim capacilites
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {} --capabilites given from opt
    )

    -- for key, val in pairs(total_capabilities) do
    --     print("Key   " .. key)
    --     print("Value " .. vim.inspect(val))
    -- end

    -- for server, server_opts in pairs(opts.servers) do
    --     print("Server is " .. server)
    --     print("With Options: " .. vim.inspect(server_opts))
    -- end

    local function setup_server(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(total_capabilities),
      }, opts.servers[server] or {})
      if server_opts.enabled == false then
        return
      end

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end

      -- Old-style server available?
      local ok = pcall(require, "lspconfig.server_configurations." .. server)
      if ok then
        require("lspconfig")[server].setup(server_opts)           -- legacy path
      else
        vim.lsp.config(server, server_opts)                       -- new path (0.11+)
        vim.lsp.enable(server)
      end
    end

    for server, server_opts in pairs(opts.servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled ~= false then
            setup_server(server)
        end
      end
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach_set_maps(client, bufnr)
        end
    })

  end,
}
