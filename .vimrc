map - /
map , :
set ts=4 " default tabstop
set nocompatible
set ignorecase
set incsearch
set hlsearch
set hidden
syntax enable
filetype plugin indent on
set number " show line numbers

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

colorscheme molokai
