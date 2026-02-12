return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        branch = "main",
        config = function()
            require("nvim-treesitter").setup({

                indent = { enable = true },
                folds = { enable = true },

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
                }


            })
        end
    }
}
