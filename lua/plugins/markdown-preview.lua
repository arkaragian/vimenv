return {
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
}
