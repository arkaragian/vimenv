-- Define bindings for invoking external programs when formatting command has been called. This is still WIP.
function FormatFile()
  local filetype = vim.bo.filetype
  print("Filetype is " .. filetype)
  -- Implement here based on our filetype what command we should use to make this work.
end

-- Setup any keybindings we want for formating our file.
function SetupKeyBindings()
 vim.keymap.set('n','<leader>f',FormatFile)
end

-- Register format
local FormatAutoGroup = vim.api.nvim_create_augroup("FormatAutoGroup", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*.h","*.c","*.cpp"},
  callback = SetupKeyBindings, 
  group = FormatAutoGroup,
})

