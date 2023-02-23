require("neotest").setup({
  adapters = {
    require("neotest-dotnet")
  }
})

vim.keymap.set("n","<leader>et",function() require("neotest").run.run({strategy = "dap"}) end, {desc="Execute test"})
