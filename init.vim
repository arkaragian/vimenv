"This file should be used for neovim. Named init.vim it should be placed in ~/AppData/Local/nvim

set nocompatible "This is always true for nvim

" Plugins are managed through the use of vim-plug. A minimalist plugin manager
" https://github.com/junegunn/vim-plug
"
" In order for the plugins to be installed the :PlugInstall Command needs to
" be issued
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()
Plug 'lervag/vimtex'
call plug#end()

"filetype off
"
"set rtp+= ~/.vim/bundle/Vundle.vim
"call vundle#begin()
"
"
"Plugin 'gmarik/Vundle.vim'
"
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
filetype plugin indent on    " required


let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-pdfxe',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ]
      \}

let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instace -forward-search @tex @line @pdf'

set ff=dos
set wrap
set encoding=utf-8
set fileencoding=utf-8
set textwidth=0 wrapmargin=0
set nu      "Set line numbering
syntax on   "Set syntax highlight
set autochdir "Change to the directory of the file that is edited

set tabstop=2    "Tab is equal to 2 columns
set shiftwidth=2 "Use 2 spaces when autoindenting
" Use _ as a word-separator
" set iskeyword-=_

set noswapfile "Disable any swap files

set omnifunc=syntaxcomplete#Complete
"Set a more friendly code completion
set wildmode=longest:full


set sessionoptions=blank


set completeopt=longest,menuone "Insert the longest common text even if there is only one match

set autoread "Set to auto read when a file is changed from an outside source

let mapleader = "\<Space>"
let maplocalleader = ","



map <LocalLeader>ls :VimtexCompileSS<CR>

"Try to set the colorscheme
try
	colorscheme adrian 
catch
	colorscheme torte
endtry

" A syntax for placeholders
" Pressing Control-j jumps to the next match.
" INSERT mode only
inoremap <c-j> <Esc>/<++><CR><Esc>cf>

"Deal with hostile environments
if has("win64") || has("win32") || has("win16")
	"Disable beeping!
	set vb t_vb=

	"Fix backspace to work as expected in windows
	set backspace=indent,eol,start

	"Set mingw32 for windows
	"set makeprg=mingw32-make
	"map <Leader>m :make<cr>

	"Set a proper font and make the window bigger
	if has("gui_running")
		set lines=999 columns=999
		set guifont=Consolas:h10
		"Set format of the titles in the tabs
		set guitablabel=\[%N\]\ %t\ %M
	endif
endif

if has("clipboard")
	vmap <C-c> "+yi
	imap <C-v> <ESC>"+p
endif


setlocal spell spelllang=en_us

"Set something special for a specific file type
"autocmd Filetype tex set nonu

augroup filetypedetect
	au BufNewFile,BufRead *.asy     setf asy
augroup END


"Code completion
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
"autocmd Filetype java setlocal omnifunc=javacomplete#Complete 

"Set highlighting when searching, use :noh to remove it
"after you are done
set hlsearch



function! InsertJSFunction(...)
	let fun = "function <++>(<++>){\n\t<++>}"
	put=fun
	:normal kk<c-j>
endfunction

function! DotToGTDot(...) range
	:s/\./->/g
endfunction


"A kind of a personal colorsheme
set background=dark

"Change the highlight of code completion popup menu
highlight Pmenu    guibg=yellow guifg=black  gui=bold ctermbg=yellow  ctermfg=black    term=bold
highlight PmenuSel guibg=black  guifg=yellow gui=bold ctermbg=black   ctermfg=yellow   term=bold


"if has("autocmd")
"  autocmd BufRead,BufNewFile *.html* :echom "Reading, or writing HTML file"
"endif

"Map irritating commands added ! in order to overwrite them in case they exist
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

"Easily move between splits
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

"Edit vimrc and reload vimrc
map <Leader>rc      :tabnew ~\_vimrc<cr>
noremap <Leader>rrc :source ~\_vimrc<cr>

map <c-t> :tabnew<cr>
map ; :

map <Leader>z :noh<cr>
" assign keyboard commands while using the greek keyboard:
map Α A
map Β B
map Ψ C
map Δ D
map Ε E
map Φ F
map Γ G
map Η H
map Ι I
map Ξ J
map Κ K
map Λ L
map Μ M
map Ν N
map Ο O
map Π P
map Q Q

map Ρ R
map Σ S
map Τ T
map Θ U
map Ω V
map W W
map Χ X
map Υ Y
map Ζ Z
map α a
map β b
map ψ c
map δ d
map ε e
map φ f
map γ g
map η h
map ι i
map ξ j

map κ k
map λ l
map μ m
map ν n
map ο o
map π p
map q q
map ρ r
map σ s
map τ t
map θ u
map ω v
map ς w
map χ x
map υ y
map ζ z

"other greek mappings
map δδ dd
map υυ yy

"let g:root_dir = GetRootDir()
"let g:proj_dir = GetProjectDir()

map <Leader>sr :echom g:root_dir<cr>

""We need to set the executable here for the cmake
"function! GenerateTags()
"	let g:root_dir = GetRootDir()
"	let tagexe  =  "C:\\ctags58\\ctags.exe "
"	let tagopts = "--exclude=build --exclude=root.vim --exclude=*.py --exclude=*.txt --tag-relative=yes --fields=+iaS -R -f " . g:root_dir . "\\tags"
"	"let cmd     =  tagexe . tagopts --extra=+fq --fields=+iaS
"	"let resp    = system(cmd)
"	"execute "!" . g:potion_command . " " . bufname("%") 
"	execute("!cd " . g:root_dir ." && " . tagexe . tagopts)
"endfunction
"
"function! RenameFile()
"	let old_name = expand('%')
"	let new_name = input('New file name: ', expand('%'), 'file')
"	if new_name != '' && new_name != old_name
"		exec ':saveas ' . new_name
"		exec ':silent !rm ' . old_name
"		redraw!
"	endif
"endfunction
"
""Find the root directory, cd to the build directory(which is assumed to be inside the root) and execute cmake
"function! Cmake()
"	let g:root_dir = GetRootDir()
"	execute("!" . "cd " . g:root_dir . "\\build"." && "."C:\\cmake-3.0.2-win32-x86\\cmake-3.0.2-win32-x86\\bin\\cmake.exe " . g:root_dir)
"endfunction!
"
":command! Cmake :call Cmake()
"
""Not working
"function! CreateCPPProject()
"	let g:root_dir = getcwd()
"	let mainContents =['#include<iostream>', ' ', 'int main(){', 'std::cout <<
"	''Hello World'' << std::endl;', ' }']
"	call writefile(mainContents,g:root_dir . "\\main.cpp")		
"endfunction
"
"
"set tags=./tags;



"Examples of root.vim contents
"map <Leader>b :!"C:\Program Files (x86)\MSBuild\12.0\Bin\msbuild.exe" build\tetris.vcxproj<cr>
"map <Leader>r :!build\Debug\tetris.exe<cr>
