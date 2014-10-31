set nocompatible
filetype plugin on
set encoding=utf-8
set fileencoding=utf-8
set nu      "Set line numbering
syntax on   "Set syntax highlight
set autochdir "Change to the directory of the file that is edited
set relativenumber

set tabstop=2    "Tab is equal to 2 columns
set shiftwidth=2 "Use 2 spaces when autoindenting
" Use _ as a word-separator
" set iskeyword-=_

set noswapfile "Disable any swap files

"set omnifunc=syntaxcomplete#Complete
"Set a more friendly code completion
"set wildmode=longest:full


set sessionoptions=blank


set completeopt=longest,menuone "Insert the longest common text even if there is only one match

set autoread "Set to auto read when a file is changed from an outside source

let mapleader = "\<Space>"

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
	"map <Leader>m :make

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

"Real men dont use arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

setlocal spell spelllang=en_us

"Set something special for a specific file type
"autocmd Filetype tex set nonu

augroup filetypedetect
	au BufNewFile,BufRead *.asy     setf asy
augroup END


"Code completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
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
filetype indent on	


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

"Edit vimrc
"Reload vimrc
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


function! IsRootDir(dir)
	"let working_directory = getcwd()
	let isRoot = 0
	if filereadable( a:dir . "/root.vim")
		let isRoot = 1
		"echom "Root Directory Found!"
	else
		"echom "Not the Root Directory" . a:dir
	endif
	return isRoot
endfunction

function! GetRootDir()
	let dir = getcwd()
	"Use a counter in order to break in case there is no root.vim found
	let counter = 1
	while IsRootDir(dir) == 0 && counter < 100
		let dir = fnamemodify( dir , ':h') "Get the parent directory
		let counter += 1
		"echom counter
	endwhile
	return dir
endfunction

let g:root_dir = GetRootDir()

function! GenerateTags()
	let tagexe  =  "C:\\ctags58\\ctags.exe "
	let tagopts = "--exclude=build --exclude=root.vim --exclude=*.txt  -R " . g:root_dir
	"let cmd     =  tagexe . tagopts --extra=+fq --fields=+iaS
	"let resp    = system(cmd)
	"execute "!" . g:potion_command . " " . bufname("%") 
	execute("!" . tagexe . tagopts)
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
try
	:source root.vim
catch
endtry
