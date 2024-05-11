local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}


parser_config.cpp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-cpp",
    revision = "e0c1678",
    files = { "src/parser.c" ,"src/scanner.c"  },
    branch = "main",
  },
}

parser_config.markdown = {
  install_info = {
    url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
    revision = "62516e8",
    files = { "tree-sitter-markdown/src/parser.c", "tree-sitter-markdown/src/scanner.c" },
    branch = "split_parser",
  },
  -- filetype = "markdown",
}

parser_config.markdown_inline = {
  install_info = {
    url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
    revision = "62516e8",
    files = { "tree-sitter-markdown-inline/src/parser.c", "tree-sitter-markdown-inline/src/scanner.c" },
    branch = "split_parser",
  },
  -- filetype = "markdown",
}

-- parser_config.razor = {
--   install_info = {
--     url = "https://github.com/arkaragian/tree-sitter-razor",
--     -- url ="C:/Users/Admin/source/repos/tree-sitter-razor",
--     files = { "src/parser.c" },
--     branch = "master",
--   },
--   filetype = "razor",
-- }

--require("vim.treesitter.query").set_query("c", "injections", "(comment) @comment")


require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "vim",
        "c",
        "lua",
        "rust",
        "c_sharp",
        --"razor",
        "latex",
        "cmake",
        "cpp",
        "json",
        "make",
        "python",
        "sql",
        "html",
        "javascript",
        "nu",
        "query" -- query parser for query editor highlighting
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    -- List of parsers to ignore installing (for "all")
    --ignore_install = { "javascript" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        --disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = { "html" , "xml" },
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
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
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            }
        },
    },
})
