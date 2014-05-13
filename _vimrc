set tabstop=2
set encoding=utf-8
set noswapfile
filetype plugin on

"Set a more friendly code completion
set wildmode=longest:full

set spell

" Set to auto read when a file is changed from an outside source
set autoread

"Try to set the colorscheme
try
    colorscheme adrian 
catch
    colorscheme torte
endtry

set nu		"line numbering
syntax on	"Syntax highlight

"Gui size
if has("gui_running")
	set lines=30 columns=120
endif

"Deal with hostile environments
if has("win64") || has("win32") || has("win16")
	"Disable beeping!
	set vb t_vb=

	"Fix backspace to work as expected in windows
	set backspace=indent,eol,start

	"Set a proper font
	if has("gui_running")
		set guifont=Consolas:h10
	endif
endif

"Map the tabs to be like common browser usage
"By default it is Ctrl + Page Up|Down

"Map the open and closing tab keys
map <C-t> :tabnew<CR>
map <C-w> :tabclose<CR>

"Map the navigation keys
map <C-Tab> :tabn<CR>
map <C-S-Tab> :tabp<CR>

"Map the Control-arrow keys for easy navigation when a window is split
"map <C-Up>

"Map autocompletion to control space(This is done in insert mode hence the imap)
imap <C-Space> <C-n>


"Alt and arrows, can now navigate in split windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


"cd C:\Users\Aris\
