-- Define bindings for invoking external programs when formatting command has
-- been called. This is still WIP.

--- Format the current buffer using the appropriate third party tool. Assume
--- that this tool is in our path.
function FormatFile()
  local filetype = vim.bo.filetype

  local fileFormatted = false

  print("Filetype is " .. filetype)
  if vim.bo.modified then
    print("File has unsaved changes! Save before formatting! Doing nothing!")
    return
  end
  if filetype == "c" or filetype == "cpp" or filetype == ".h" then
    print("Formating using clang " .. vim.api.nvim_buf_get_name(0))

    -- I/O Pipe open execute clang. -i argument means format the file in place.
    io.popen("clang-format -i -style=file " .. vim.api.nvim_buf_get_name(0))
    fileFormatted = true
  elseif filetype == "cs" then
    print("Formating using dotnet format " .. vim.api.nvim_buf_get_name(0))

    io.popen("dotnet format --include --no-restore" .. vim.api.nvim_buf_get_name(0))
    fileFormatted = true
  else
    print("No formating rule found. Doing nothing")
    return
  end

  if fileFormatted then
    -- Reload the current buffer
    vim.cmd.edit()
  end
end

-- The code bellow allows for the following to happen
-- 1) Define a function that sets up keybindings for file formatting. This will
--    be called when we enter a file that we support.
-- 2) Create an autocommand group specifically for formatting that is cleared 
-- 3) Register the group on 

-- Setup any keybindings we want for formating our file.
function SetupKeyBindings()
 vim.keymap.set('n','<leader>fo',FormatFile)
end

-- Register format autocommand group that helps us manage the group commands as
-- a whole. The clear flag clears the group when we enter the buffer again. This
-- helps us keep the same end state every time we execute this.
local FormatAutoGroup = vim.api.nvim_create_augroup("FormatAutoGroup", { clear = true })

-- Create autocommand in the BufEnter event that is matched against a pattern
-- BufEnter event is nice for setting options for a file type accoding to
-- vim documentation :h BufEnter. This command bellongs to our Formatting group
--
-- This means that when we enter a buffer with the specified pattern register
-- the commands that are defined in the SetupKeyBindings function.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*.h","*.c","*.cpp","*.cs"},
  callback = SetupKeyBindings, 
  group = FormatAutoGroup,
})

