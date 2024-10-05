return {
    {
        "https://github.com/nvim-tree/nvim-tree.lua.git",
        tag = "v1.7.1"
    },

    {
        "tpope/vim-fugitive",
        tag = "v3.7"
    },
    {
        "godlygeek/tabular",
        tag = "1.0.0"
    },
    { "mechatroner/rainbow_csv" },
    {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v3.7.2"
    },
    {
        "folke/which-key.nvim",
        tag = "v3.13.3"
    },
    { "Eandrju/cellular-automaton.nvim" },
    {
        "tpope/vim-surround",
        tag = "v2.2"
    },
    {
        "rcarriga/nvim-notify",
        tag = "v3.14.0",
        lazy = false,
        priority = 900
    },
    {
        "nvim-neotest/nvim-nio",
        tag = "v1.10.0"
    },
    {
        "https://github.com/nvim-neotest/neotest",
        tag = "v5.6.0"
    },
    {
        "https://github.com/Issafalcon/neotest-dotnet",
        tag = "v1.6.5"
    },
    { "https://github.com/rouge8/neotest-rust.git" },
    {
        "https://github.com/numToStr/Comment.nvim.git",
        tag = "v0.8.0"
    },
    { "https://github.com/windwp/nvim-ts-autotag" },
    -- install without yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        version = "v0.0.10",
        build = function()
            require("lazy").load { plugins = { "markdown-preview.nvim" } }
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "https://github.com/mfussenegger/nvim-lint",
        commit = "efc6fc8"
    },
    {
        dir = HomeDir .. "/source/repos/Solution.nvim"
    }
}
