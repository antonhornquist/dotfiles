set langmenu=en_US
let $LANG = 'en_US'

set nocompatible " use vim settings, must be first can change other options as a side effect

set shiftwidth=4
set tabstop=4 " default tabstop
"set ignorecase
set incsearch
set hlsearch
set hidden " this makes vim act like all other editors, buffers can exist in the background without being in a window.

set backspace=indent,eol,start

set wrap " wrap lines

set wildmode=longest,list " https://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names

syntax enable

filetype plugin on
filetype indent on

set number " show line numbers
"set nobackup
"set noswapfile

" set list listchars=tab:\ \ ,trail:· " Display tabs and trailing spaces visually

" -- mappings --
map - /
map _ ?
map , :

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

if has('gui_running')
	colorscheme desert
	set vb " visual bell
	set guioptions-=T " remove toolbar
	set guioptions+=a
	set keymodel-=stopsel " from windows vimrc...

	if has("macunix")
		set guifont=Monaco:h17
		set columns=100
		set lines=30
		set fuoptions=maxvert,maxhorz " expand macvim in fullscreen mode
	endif

	if has("gui_win32")
		set guifont=Consolas:h14:cANSI
		"set columns=130
		"set lines=45
	endif

	if $VIM=="/boot/common/data/vim" " we're probably in haiku
		set guifont=DejaVu_Sans_Mono/Regular/18
		set columns=80
		set lines=25
	endif
endif

set encoding=utf-8

let @z=':set guifont=Consolas:h9:cANSI'
let @x=':set guifont=Consolas:h14:cANSI'

