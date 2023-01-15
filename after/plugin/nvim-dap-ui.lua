require("dapui").setup()

vim.keymap.set('n', 'sds', ":lua require'dapui'.open()<CR>") --Start debug session
vim.keymap.set('n', 'eds', ":lua require'dapui'.close()<CR>") --End debug session

function StartDebugSession()
  --TODO: Need to find a way to start and stop the session
  local dap = require('dap')
  dap.continue()
  local dapui = require('dapui')
  dapui.open()
end
