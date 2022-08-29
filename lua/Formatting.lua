-- Define bindings for invoking external programs when formatting command has been called. This is still WIP.

--- Format a file using the appropriate third party tool. Assume that this tool is in our path.
function FormatFile()
  local filetype = vim.bo.filetype
  print("Filetype is " .. filetype)
  if filetype == "c" or filetype == "cpp" or filetype == ".h" then
    print("Formatiing using clang " .. vim.api.nvim_buf_get_name(0))

    -- I/O Pipe open execute clang. -i argument means format the file in place.
    io.popen("clang-format -i " .. vim.api.nvim_buf_get_name(0))
    return
  end

  print("No formating rule found. Doing nothing")
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

