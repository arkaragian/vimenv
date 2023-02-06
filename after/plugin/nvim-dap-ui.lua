local dapui = require("dapui")--

 local config = {
    controls = {
      element = "repl",
      enabled = false,
      icons = {
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    }
  }
dapui.setup(config)

vim.keymap.set('n', 'sds', ":lua require('dapui').open()<CR>",{desc="Start Debug Session"})
vim.keymap.set('n', 'eds', ":lua require('dapui').close()<CR>",{desc="End Debug Session"})

