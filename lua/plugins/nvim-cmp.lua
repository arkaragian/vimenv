return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    main =  "cmp",
    -- This is not lazy but can be loaded with a low priority
    -- priority = 100,
    opts = function()
        -- We need logic to construct the options here. Thus just createa a function
        -- that returns the options. Those options are then passed by lazy nvim to the
        -- the setup automatically.
        --


        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        ls.config.set_config {
            -- This tells LuaSnip to remember to keep around the last snippet.
            -- You can jump back into it even if you move outside of the selection
            history = false,

            -- This one is cool cause if you have dynamic snippets, it updates as you type!
            updateevents = "TextChanged,TextChangedI",

            -- Autosnippets:
            enable_autosnippets = true,


                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { " « ", "NonTest" } },
                        },
                    },
                },
            }

            require("luasnip.loaders.from_lua").lazy_load()

            ------------------------------------------------------------------------------
            ---                  K E Y M A P   D E F I N I T I O N S                   ---
            ------------------------------------------------------------------------------

            -- <c-k> is my expansion key
            -- this will expand the current item or jump to the next item within the snippet.
            local function Expand()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end
            vim.keymap.set({ 'i', 's' }, '<c-k>', Expand, { silent = true })

            -- <c-j> is my jump backwards key.
            -- this always moves to the previous item within the snippet
            vim.keymap.set({ 'i', 's' }, '<c-j>', function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })

            -- <c-l> is selecting within a list of options.
            -- This is useful for choice nodes (introduced in the forthcoming episode 2)
            vim.keymap.set('i', '<c-l>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)

            vim.keymap.set('i', '<c-u>', require 'luasnip.extras.select_choice')

            --local sourcePath = os.getenv("NVCONF") .. "/after/plugin/luasnip.lua"
            local sourcePath = vim.api.nvim_list_runtime_paths()[1] .. "/after/plugin/luasnip.lua"

            -- shorcut to source my luasnips file again, which will reload my snippets
            vim.keymap.set('n', '<Leader>L', '<Cmd>lua require("luasnip.loaders.from_lua").load()<CR>',{desc = "Reload Lua snippets"})



            vim.opt.completeopt = { "menu", "menuone", "noselect" }

            -- Don't show the dumb matching stuff.
            vim.opt.shortmess:append "c"

            -- Complextras.nvim configuration
            vim.api.nvim_set_keymap(
                "i",
                "<C-x><C-m>",
                [[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
                { noremap = true }
            )

            vim.api.nvim_set_keymap(
                "i",
                "<C-x><C-d>",
                [[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
                { noremap = true }
            )

            local lspkind = require("lspkind")
            lspkind.init()

            local cmp = require('cmp')
            return {
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-d>"] = cmp.mapping.scroll_docs( -4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<c-y>"] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        },
                        { "i", "c" }
                    ),

                    ["<c-space>"] = cmp.mapping {
                        i = cmp.mapping.complete(),
                        c = function(
                            _ --[[fallback]]
                        )
                        if cmp.visible() then
                            if not cmp.confirm { select = true } then
                                return
                            end
                        else
                            cmp.complete()
                        end
                    end,
                },

                -- ["<tab>"] = false,
                ["<tab>"] = cmp.config.disable,

                -- Testing
                ["<c-q>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },

            },
            sources = {
                { name = "gh_issues" },

                -- Could enable this only for lua using an autocommand, but nvim_lua handles that already.
                { name = "nvim_lua" },

                { name = "nvim_lsp" }, -- Suggestions from the lsp client
                { name = 'nvim_lsp_signature_help' }, -- LSP signature help
                { name = "path" }, -- We don't use path suggestions
                { name = "luasnip" }, --We use luasnip
                { name = "buffer",                 keyword_length = 5 },
            },
            sorting = {
                -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,

                    -- copied from cmp-under, but I don't think I need the plugin for this.
                    -- I might add some more of my own.
                    function(entry1, entry2)
                        local _, entry1_under = entry1.completion_item.label:find "^_+"
                        local _, entry2_under = entry2.completion_item.label:find "^_+"
                        entry1_under = entry1_under or 0
                        entry2_under = entry2_under or 0
                        if entry1_under > entry2_under then
                            return false
                        elseif entry1_under < entry2_under then
                            return true
                        end
                    end,

                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            -- Youtube: mention that you need a separate snippets plugin
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            formatting = {
                -- Youtube: How to set up nice formatting for your sources.
                format = lspkind.cmp_format {
                    with_text = true,
                    menu = {
                        buffer = "[buf]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[api]",
                        path = "[path]",
                        luasnip = "[snip]",
                        gh_issues = "[issues]",
                        tn = "[TabNine]",
                    },
                },
            },
        }
    end,
    -- load cmp on InsertEnter
    -- event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    config = function(_, opts)
        require("cmp").setup(opts)
    end,
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "saadparwaiz1/cmp_luasnip",
    }
}
