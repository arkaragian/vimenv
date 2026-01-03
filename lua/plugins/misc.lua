return {
    {
        "https://github.com/nvim-tree/nvim-tree.lua.git",
        tag = "v1.14.0",
        opts = {
            view = {
                side = "left", -- "left" | "right"
            },
        }
    },

    {
        "tpope/vim-fugitive",
        tag = "v3.7"
    },
    {
        "godlygeek/tabular",
        tag = "1.0.0"
    },
    -- { "mechatroner/rainbow_csv" },
    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },
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
    -- {
    --     "https://github.com/nvim-neotest/neotest",
    --     tag = "v5.6.0",
    --     dependencies = {
    --         { "nvim-neotest/nvim-nio" },
    --         { "nvim-lua/plenary.nvim" },
    --         { "antoinemadec/FixCursorHold.nvim" },
    --         { "nvim-treesitter/nvim-treesitter" },
    --         {
    --             "https://github.com/Issafalcon/neotest-dotnet",
    --             tag = "v1.6.5",
    --             opts = {
    --                 dap = {
    --                     -- Extra arguments for nvim-dap configuration
    --                     -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
    --                     args = { justMyCode = false },
    --                     -- Enter the name of your dap adapter, the default value is netcoredbg
    --                     adapter_name = "netcoredbg"
    --                 },
    --                 -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
    --                 -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
    --                 custom_attributes = {
    --                     xunit = { "MyCustomFactAttribute" },
    --                     nunit = { "MyCustomTestAttribute" },
    --                     mstest = { "MyCustomTestMethodAttribute" }
    --                 },
    --                 -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
    --                 dotnet_additional_args = {
    --                     "--verbosity detailed"
    --                 },
    --                 -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
    --                 -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
    --                 --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
    --                 discovery_root = "project" -- Default
    --             },
    --             config = function(_, opts)
    --                 require("neotest-dotnet")(opts)
    --             end
    --         },
    --         { "https://github.com/rouge8/neotest-rust.git" },
    --     },
    --     opts = {
    --         adapters = {
    --             "neotest-dotnet"
    --         }
    --     }
    -- },
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
}
