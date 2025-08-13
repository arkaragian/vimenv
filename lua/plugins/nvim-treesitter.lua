return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- version = "v0.9.2",
        -- At this commit all the tests were working
        commit = "d26ce0126694283cf32bf1f4192ef37ef404c037",
        lazy = false,
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts_extend = { "ensure_installed" },
        opts = {
            highlight = {
                enable = true,
                -- Disable the highlighting here in order
                -- to let rainbow csv to take over.
                disable = { "csv" }
            },
            ensure_installed = {
                "vim",
                "c",
                "lua",
                "rust",
                "c_sharp",
                "razor",
                "latex",
                "cmake",
                "cpp",
                "json",
                "make",
                "python",
                "sql",
                "html",
                "javascript",
                --"nu",
                "query" -- query parser for query editor highlighting
            },
            sync_install = false,
            auto_install = true,
            -- incremental_selection = {
            --     enable = true,
            --     keymaps = {
            --         init_selection = "<C-space>",
            --         node_incremental = "<C-space>",
            --         scope_incremental = false,
            --         node_decremental = "<bs>",
            --     },
            -- },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["am"] = "@function.outer",
                        ["im"] = "@function.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@conditional.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },

                        ["av"] = { query = "@variable.outer", desc = "Select outer variable"},
                        ["iv"] = { query = "@variable.inner", desc = "Select inner variable"},

                        -- For latex
                        ["ae"] = { query = "@block.outer", desc = "Select outer environment"},
                        ["ie"] = { query = "@block.inner", desc = "Select inner environment"},

                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = true,
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        --
                        -- You can use regex matching and/or pass a list in a "query" key to group multiple queires.
                        ["]o"] = "@loop.*",
                        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                        --
                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" }, <-- This interferes with spell check
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                    -- The bindings bellow are used for lsp move to next diagnostic. Thus
                    -- we have them disabled
                    -- Below will go to either the start or the end, whichever is closer.
                    -- Use if you want more granular movements
                    -- Make it even more gradual by adding multiple queries and regex.
                    -- goto_next = {
                    --     ["]d"] = "@conditional.outer",
                    -- },
                    -- goto_previous = {
                    --     ["[d"] = "@conditional.outer",
                    -- }
                },
            },
        },
         config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
          end,
    },
    {
        "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        }
    }
}
