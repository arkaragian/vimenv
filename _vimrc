set tabstop=2

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
