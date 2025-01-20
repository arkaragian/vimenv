vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.cs"},
    command = "setlocal commentstring=//%s"
})
