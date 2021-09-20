" TODO: integrate sensible.vim settings

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

	"set background=light
	let hour = str2nr(strftime("%H"))

	if 7 < hour && hour < 16
		set background=light
	else
		set background=dark
	endif
	colorscheme solarized
	let g:solarized_contrast="high"
	" colorscheme desert
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
		set guifont=Consolas:h8:cANSI
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

map <A-a> :call SCSendToReplAndEvaluate("~vimkey.value('a')")<cr>
map <A-s> :call SCSendToReplAndEvaluate("~vimkey.value('s')")<cr>
map <A-d> :call SCSendToReplAndEvaluate("~vimkey.value('d')")<cr>
map <A-f> :call SCSendToReplAndEvaluate("~vimkey.value('f')")<cr>
map <A-g> :call SCSendToReplAndEvaluate("~vimkey.value('g')")<cr>
map <A-h> :call SCSendToReplAndEvaluate("~vimkey.value('h')")<cr>
map <A-j> :call SCSendToReplAndEvaluate("~vimkey.value('j')")<cr>
map <A-k> :call SCSendToReplAndEvaluate("~vimkey.value('k')")<cr>
map <A-l> :call SCSendToReplAndEvaluate("~vimkey.value('l')")<cr>

map <A-q> :call SCSendToReplAndEvaluate("~vimkey.value('q')")<cr>
map <A-w> :call SCSendToReplAndEvaluate("~vimkey.value('w')")<cr>
map <A-e> :call SCSendToReplAndEvaluate("~vimkey.value('e')")<cr>
map <A-r> :call SCSendToReplAndEvaluate("~vimkey.value('r')")<cr>
map <A-t> :call SCSendToReplAndEvaluate("~vimkey.value('t')")<cr>
map <A-y> :call SCSendToReplAndEvaluate("~vimkey.value('y')")<cr>
map <A-u> :call SCSendToReplAndEvaluate("~vimkey.value('u')")<cr>
map <A-i> :call SCSendToReplAndEvaluate("~vimkey.value('i')")<cr>
map <A-o> :call SCSendToReplAndEvaluate("~vimkey.value('o')")<cr>

map <C-0> :call SCSendToRepl()<cr>
map <C-Enter> :call SCSendToRepl()<cr>
imap <C-Enter> <Esc>:call SCSendToRepl()<cr>
map <C-Space> :call SCSendHardStopToRepl()<cr>
imap <C-Space> <Esc>:call SCSendHardStopToRepl()<cr>a
map <C-BS> :call SCClearPostWindow()<cr>
imap <C-BS> <Esc>:call SCClearPostWindow()<cr>a

map <Leader>o :only<cr>
" map <C-H> :call SCSetPostWindowLeftLayout()<cr>
map <Leader>h :call SCSetPostWindowLeftLayout()<cr>
" map <C-J> :call SCSetPostWindowBelowLayout()<cr>
map <Leader>j :call SCSetPostWindowBelowLayout()<cr>
" map <C-K> :call SCSetPostWindowAboveLayout()<cr>
map <Leader>k :call SCSetPostWindowAboveLayout()<cr>
" map <C-L> :call SCSetPostWindowRightLayout()<cr>
map <Leader>l :call SCSetPostWindowRightLayout()<cr>

map <Leader>s :call SCStopRepl()<cr>
map <Leader>r :call SCSendRecompileToRepl()<cr>
map <Leader>b :call SCSendBootServerToRepl()<cr>
map <Leader>q :call SCSendQuitServerToRepl()<cr>
map <Leader>n :call SCSendQueryAllNodesToRepl()<cr>
map <Leader>. :call SCSendHardStopToRepl()<cr>
map <Leader>z :call SCSendRecordToRepl()<cr>
map <Leader>x :call SCSendStopRecordToRepl()<cr>
map <Leader>u :call SCEditStartupFile()<cr>

let g:sc_change_nowExecutingPath = v:true

function! SCSendToRepl()
	if !SCReplIsStarted()
		call SCSetPostWindowBelowLayout()
	endif

	let saved_pos = getpos(".")
	" consider using n option - see search helpfile
	let [lnum,col] = searchpairpos('^($', '', '^)$')

	if lnum == 0
		let line = getline(".")
		" echom "evaluate line: " . line
		call SCSendToReplAndEvaluate(line)
	else
		let end = lnum
		execute(end)
		execute("normal %")
		let start = getpos(".")[1]
		call setpos(".", saved_pos)
		let lines = getline(start, end)
		let content = ""
		for line in lines
			" let content = content . line . "\r"
			let content = content . line . "\n"
		endfor
		" echom "evaluate content: " . content
		call SCSendToReplAndEvaluate(content)
	endif
endfunction

function! SCClearPostWindow()
	if SCReplIsStarted()
		let current_buf = buffer_number()
		execute("buffer " . g:sc_buf)
		execute("normal gg")
		execute("normal VG")
		execute("normal d")
		execute("buffer " . current_buf)
	else
		echom "SuperCollider REPL is not running"
	endif
endfunction

function! SCSendHardStopToRepl()
	call SCSendToReplAndEvaluate("thisProcess.hardStop;")
endfunction

function! SCSendQueryAllNodesToRepl()
	call SCSendToReplAndEvaluate("s.queryAllNodes(true);")
endfunction

function! SCSendRecompileToRepl()
	call SCSendToReplAndEvaluate("thisProcess.recompile;")
endfunction

function! SCSendBootServerToRepl()
	call SCSendToReplAndEvaluate("s.boot;")
endfunction

function! SCSendQuitServerToRepl()
	call SCSendToReplAndEvaluate("s.quit;")
endfunction

function! SCSendRecordToRepl()
	call SCSendToReplAndEvaluate("s.record;")
endfunction

function! SCSendStopRecordToRepl()
	call SCSendToReplAndEvaluate("s.stopRecording;")
endfunction

function! SCEditStartupFile()
	" windows location
	let sc_startup_file_path = "C:/Users/Thinkpad X250/AppData/Local/SuperCollider/startup.scd"
	execute("edit " . sc_startup_file_path)
endfunction

function! SCEditUserExtensionDir()
	" windows location
	let sc_startup_file_path = "C:/Users/Thinkpad X250/AppData/Local/SuperCollider"
	execute("edit " . sc_startup_file_path)
endfunction

function! SCSendToReplAndEvaluate(string)
	if g:sc_change_nowExecutingPath
		let filepath = '"' . expand('%:p') . '"'

		" below only relevant on windows (for file paths)
		let filepath = substitute(filepath, '\', '/', 'g')

		if filepath == '""'
			let str = substitute(a:string, "thisProcess.nowExecutingPath", "nil", "g")
		else
			let str = substitute(a:string, "thisProcess.nowExecutingPath", filepath, "g")
		endif
	else
		let str = a:string
	endif

	if g:sc_repl_type == "job"
		" echom str
		call ch_sendraw(g:sc_job, str . "\f")
	else
		call term_sendkeys(g:sc_buf, "\r\r" . str . "\r\f\r")
	endif
endfunction

function! SCSetPostWindowBelowLayout()
	if !SCReplIsStarted()
		call SCStartREPL()
	endif

	execute("only")
	execute("belowright split")
	execute("buffer " . g:sc_buf)
	execute("wincmd k")
endfunction

function! SCSetPostWindowRightLayout()
	if !SCReplIsStarted()
		call SCStartREPL()
	endif

	execute("only")
	execute("vertical rightbelow split")
	execute("buffer " . g:sc_buf)
	execute("wincmd h")
endfunction

function! SCReplIsStarted()
	return exists("g:sc_buf")
endfunction

function! SCStartREPL()
	" call SCStartTerminalREPL()
	call SCStartJobREPL()
endfunction

function! SCStartTerminalREPL()
	let buf_name = 'sc_post_window'
	" let g:sc_buf = term_start('C:\\Program Files\\SuperCollider-3.9.3\\sclang.exe -d "C:\\Program Files\\SuperCollider-3.9.3"', {"hidden": 1})
	let g:sc_buf = term_start('C:\\Program Files\\SuperCollider-3.11.1\\sclang.exe -d "C:\\Program Files\\SuperCollider-3.11.1"', {"hidden": 1})
	let g:sc_job = term_getjob(g:sc_buf)
	let g:sc_repl_type = "terminal"
endfunction

function! SCStartJobREPL()
	let buf_name = 'sc_post_window'
	" let g:sc_job = job_start('C:\\Program Files\\SuperCollider-3.9.3\\sclang.exe -d "C:\\Program Files\\SuperCollider-3.9.3"',
	" 			\ {'out_io': 'buffer', 'out_name': buf_name})
	let g:sc_job = job_start('C:\\Program Files\\SuperCollider-3.11.1\\sclang.exe -d "C:\\Program Files\\SuperCollider-3.11.1"',
				\ {'out_io': 'buffer', 'out_name': buf_name})
	let g:sc_buf = buf_name
	let g:sc_repl_type = "job"
endfunction

function! SCStopRepl()
	if SCReplIsStarted()
		call job_stop(g:sc_job)
		if g:sc_repl_type == "terminal"
			call term_wait(g:sc_buf, 100)
		endif
		execute("bd " . g:sc_buf)
		unlet g:sc_buf
		unlet g:sc_job
		unlet g:sc_repl_type
	else
		echom "SuperCollider REPL is not running"
	endif
endfunction

let @z=':set guifont=Consolas:h8:cANSI'
let @x=':set guifont=Consolas:h10:cANSI'
let @c=':set guifont=Consolas:h12:cANSI'
let @v=':set guifont=Consolas:h14:cANSI'

map <Leader>f :!start "\Program Files\love\love.exe" .<cr>
