"Escape the msbuild path because it contains spaces
let g:msbuild = "\"C:\\Program Files (x86)\\MSBuild\\12.0\\Bin\\msbuild.exe\""
"The path of the project relative to the root directory
let g:project_rel_path = "\\build\\tests\\"
let g:project = "test.vcxproj"

function! BuildProject()
	let project_path = g:root_dir.g:project_rel_path.g:project
	execute("!".g:msbuild." ".project_path)
endfunction!

function! RunExecutable()
	let g:root_dir = GetRootDir()
	execute("!" . "cd " . g:root_dir . "\\build"." && "."C:\\cmake-3.0.2-win32-x86\\cmake-3.0.2-win32-x86\\bin\\cmake.exe " . g:root_dir)
endfunction!

map <Leader>b :call BuildProject()<cr>
map <Leader>r :!build\xmlGenerator\tetris.exe<cr>
