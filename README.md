# Introduction
The goal of this neovim configuration is to make a PDE(Personal Development Environment) based on the neovim editor.
The philosophy is not to make everything inside nvim but instead use a set of external tools to achieve all the features
offered by modern IDEs. Those should be:
1. Code completion
1. Code formatting
1. Debugging

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
    1. This provides `clangd` for lsp capabilities. This can also be installed individually.
    1. `clang-format` for code formatting.

Additional languages will be added as I continue to experiment with the neovim config
