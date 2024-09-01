vim.opt.termguicolors = true
require("bufferline").setup{
}
vim.api.nvim_set_keymap('n', '<C-S-Right>', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Left>', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
 -- " These commands will move the current buffer backwards or forwards in the bufferline
 --    nnoremap <silent><mymap> :BufferLineMoveNext<CR>
 --    nnoremap <silent><mymap> :BufferLineMovePrev<CR>
