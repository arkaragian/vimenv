return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        lazy = false,
	-- Called buring startup
        init = function()
            vim.opt.termguicolors = true
        end,
	-- A table of options pased to setup function
        opts = {
        },
	
	-- Table of Keys defined by the plugin. similar to vim.keymap.set()
        keys = {
            {
                '<C-S-Right>',
                ':BufferLineMoveNext<CR>',
                "n",
                desc = "Moves a bufferline tab the the left",
                noremap = true,
                silent = true
            },
            {
                '<C-S-Left>' ,
                ':BufferLineMovePrev<CR>',
                "n",
                desc = "Moves a bufferline tab the the Right",
                noremap = true,
                silent = true
            }
        },
	-- Plugins loaded after this plugi
        dependencies = "nvim-tree/nvim-web-devicons"
    }
}
