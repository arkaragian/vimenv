"Escape the msbuild path because it contains spaces
let g:build_exe = "\"C:\\Program Files (x86)\\MSBuild\\12.0\\Bin\\msbuild.exe\""
let g:build_opts = ""
"The path of the project relative to the root directory
let g:project_rel_path = "\\build\\tests\\"
let g:project_name = "market_lib_test.vcxproj"
let g:ex_name = "Debug\\market_lib_test.exe"

echom "root.vim sourced"
