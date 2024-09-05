-- ftdetect files are used before ft scripts. The files in this directory are
-- sourced in alphabetical order

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.xaml"},
    command = "setfiletype xml",
})
