-- Define bindings for invoking external programs when formatting command has
-- been called. This is still WIP.

--- Return the parent directory for a given path
-- @param path The input path
-- @param seperator The directory seperator
function GetParrentDirectory(path,seperator)
    -- TODO: Handle windows
    if(string.lower(jit.os) == "windows") then
        -- If we have reached the drive. such as: C:\ Z:\ or whatever
        if(string.sub(path,1,3) == path) then
            return path
        end
    else
        if(path == "/") then
            return path
        end
    end

    local lastSeperatorIndex = 0;
    for i=1,string.len(path) do
        -- Get a character
        local c = string.sub(path,i,i)
        if(c == seperator) then
            lastSeperatorIndex = i
        end
    end
    return string.sub(path,1,lastSeperatorIndex-1)
end

--- Determines if the given directory contains any files of the given extension
-- @param dir The directory path to check
-- @param extension The extension to check for
function DirectoryContainsExtension(directory,extension)
    local dir_sep
    if package.config:sub(1,1) == '/' then
        dir_sep = '/'
    else
        dir_sep = '\\'
    end
    -- TODO: Hande windows and linux here
    local command = 'dir "' .. directory .. dir_sep .. '*.' .. extension .. '" /b'
    --for file in io.popen('dir "' .. dir .. dir_sep .. '*.' .. extension .. '" /b'):lines() do
    -- search for files in the directory that have the given extension
    for file in io.popen(command):lines() do
        print(file)
        -- file was found, return true
        return true
    end
    -- no files were found, return false
    return false
end

function GetFilesByExtension(directory,extension)
    --TODO: if windows or linux
    local files = {}
    local command
    if(string.lower(jit.os) == "windows") then
        --List only the files of a given extension
        command = "dir " .. directory .. "*." .. extension .. "/b"
    else
        -- TODO: Specify directory
        command = "ls -1 " .. directory .. "/*." .. extension
    end

    local counter = 1
    for file in io.popen(command):lines() do
        files[counter] = file
        counter = counter + 1
    end
    return files
end

--- Find the given filename starting from cwd and moving upwards
-- @param filename The filename to look for
function FindFile(filename)
    local cur_dir = vim.fn.getcwd()
    local dir_sep = nil
    -- Determine the seperator for our operating system
    if package.config:sub(1,1) == '/' then
        dir_sep = '/'
    else
        dir_sep = '\\'
    end

    if(dir_sep == nil) then
        print("Your system directory seperator is not supported. Supported systems are unix like operating systems")
        return nil;
    end

    while true do
        -- fileOrPattern is a specific filename, check if it exists
        local file_path = cur_dir .. dir_sep .. filename
        local f = io.open(file_path)
        if f ~= nil then
            -- file was found, set the flag to true and return the current directory
            f:close()
            return file_path
        else
            -- If the file does not reside in the root folder then the file does not exist
            -- return nil
            -- TODO: C:\ is not always true in windows. Could be Z:\
            if(cur_dir == '/' or cur_dir == 'C:\\') then
                return nil
            end
            cur_dir = GetParrentDirectory(cur_dir, dir_sep)
        end
    end
end

--- Retuens the first file that exists within our path with the given extension
-- @param extension The extension of the file
function FindFirstOccurenceOfExtension(extension)
    local cur_dir = vim.fn.getcwd()
    local dir_sep = nil
    -- Determine the seperator for our operating system
    if package.config:sub(1,1) == '/' then
        dir_sep = '/'
    else
        dir_sep = '\\'
    end

    if(dir_sep == nil) then
        print("Your system directory seperator is not supported. Supported systems are unix like operating systems")
        return nil;
    end

    while true do
        -- fileOrPattern is a specific filename, check if it exists
        local file_path = cur_dir .. dir_sep .. extension
        if(DirectoryContainsExtension(cur_dir,extension)) then
            local files = GetFilesByExtension(cur_dir,extension)
            -- file was found, set the flag to true and return the current directory
            return files[1]
        else
            -- If the file does not reside in the root folder then the file does not exist
            -- return nil
            -- TODO: C:\ is not always true in windows. Could be Z:\
            if(cur_dir == '/' or cur_dir == 'C:\\') then
                return nil
            end
            cur_dir = GetParrentDirectory(cur_dir, dir_sep)
        end
    end
end

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
    print("Formating " .. vim.api.nvim_buf_get_name(0) .." using dotnet format")

    local containsProj = DirectoryContainsExtension(vim.fn.getcwd(), "csproj")
    print("Contains is:"..tostring(containsProj))
    --This assumes that there is a csproj file at the same level as the file specified.
    --We need to handle this.
    if(containsProj) then
        io.popen("dotnet format --include --no-restore" .. vim.api.nvim_buf_get_name(0))
        fileFormatted = true
    else
        local file = FindFirstOccurenceOfExtension("csproj")
        if(file) then
            io.popen("dotnet format --include ".. vim.api.nvim_buf_get_name(0) .. "--no-restore" .. file)
        end
    end
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
 --vim.keymap.set('n','<leader>fo',FormatFile, {desc = "Format File"})
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

