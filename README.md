# Introduction
The goal of this neovim configuration is to make a PDE(Personal Development Environment) based on the neovim editor.
The philosophy is not to make everything inside nvim but instead use a set of external tools to achieve all the features
offered by modern IDEs. Those should be:
1. Code completion
1. Code formatting
1. Debugging

## Dependencies
tree sitter requires a copiler. The LLVM toolchain is used for this reason

## Installation
This repo can be cloned in the appropriate locations. More specifically this can be used in the nvim folder located
### For Windows
```
~/AppData/Local/nvim
```
### For Linux
```
~/.config/nvim
```

In addition some 3rd party tools must be installed and be set up at specific paths. The path
that I choose to install those to is
```
%USERPROFILE%/bin
```
Those tools are:
1. For C#
    1. Omnisharp-roslyn used for lsp services
    1. netcoredbg from samsung that is used for dap debugging
    1. .net provides it's own cli tools to format the code thus those can be used. The command is `dotnet format`
1. For C/C++ we install the LLVM distribution:
    1. This provides `clangd` for lsp capabilities. This requires a `compile_commands.json` file. See bellow.
    1. `clang-format` for code formatting.

## Special Notes

### C/C++
In order for the LSP to work we need to have the `compile_commands.json` file that is normally generated by cmake.
Alternativelly we can keep track of this by hand but this is not quite easy unless we are dealing with a small project.

In order for the `cmake` to generate those commands we need to have the following:
```
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 /path/to/src -G 'Unix Makefiles'
```

Additional languages will be added as I continue to experiment with the neovim config

## Cheatsheet
1. `<leader>f` will perform a file formatting if the file extension supports such
formatting
2. `<leader>ff` will use telescope to find files
3. `<leader>fb` will list the open buffers
4. `bh` and `bl` are buffer previous and buffer next

### LSP Key Bindings
1. `gD` go to declaration
2. `gd` go to definition
3. `<leader>ca` perform code action
4. `<leader>rn` rename symbol

### Debug
1. `os` open debug
2. `cs` close debug
