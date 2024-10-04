return  {
    "hrsh7th/nvim-cmp",
    -- opts = function(_, opts)
    --   opts.sources = opts.sources or {}
    --   table.insert(opts.sources, {
    --     name = "lazydev",
    --     group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    --   })
    -- end,
    lazy = false,
    priority = 100,
    -- load cmp on InsertEnter
    -- event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    config = function()
        require("Completion")
    end,
    dependencies = {
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
    }
}
