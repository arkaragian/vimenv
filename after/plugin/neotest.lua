require("neotest").setup({
  adapters = {
    require("neotest-dotnet"),
    require("neotest-rust")
  }
})

vim.keymap.set("n" , "<leader>et" , function() require("neotest").run.run({strategy = "dap"}) end , {desc="Execute test"})
-- vim.keymap.set("n" , "<leader>et" , function() require("neotest").summary.open() end              , {desc="Open test explorer"})
