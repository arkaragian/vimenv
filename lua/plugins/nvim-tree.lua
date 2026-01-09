return {
    {
        "https://github.com/nvim-tree/nvim-tree.lua.git",
        tag = "v1.14.0",
        lazy = true,
        opts = {
            view = {
                side = "right",
            },
        },
        keys =  {
            { mode = "n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "Toogle Tree View" }
        }
    },
}
