set tabstop=2

" Set to auto read when a file is changed from the outside
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
