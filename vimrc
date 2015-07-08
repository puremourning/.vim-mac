" use comma for commands
let mapleader=','

" enable syntax hilighting
syn on

"Vundle plugins
runtime! vundle_plugins

" default to xterm behaviour
behave xterm

" enable my colour scheme
set background=dark
if has('gui_running') 
    colorscheme solarized
else
    colorscheme darkblue
    set cursorline
endif

" set the font
set guifont=Lucida_Console:h9:cDEFAULT

" visual selection copied to clipboard
set guioptions+=a

" set the height and width (might be broken columns for diff)
" set lines=50 columns=80

" Allow tab-completion in the command line mode
cnoremap <TAB> <C-L>

" Set up indenting, and searching
set shiftwidth=4 smartindent expandtab incsearch showmatch smartcase

" use clever case searches when ignorecase is turned on
set smartcase

" use more stuff for the completions
set complete=.,w,b,u,i

" allow c++ like define macros
set define=^\\(#\\s*define\\|[a-z]*\\s*const\\s*[a-z]*\\)

" don't resize windows when splitting
set noequalalways

" have a status line for all windows
set laststatus=2

" don't count in octal for things like BEN001
set nrformats=hex

" always show where the cursor is
set ruler

" show partial commands
set showcmd

" default compatibility mode for vim6
set cpoptions=aABceFs

" use long messages
"set shortmess=

" make sure that there are always 5 lines of context when scrolling
set scrolloff=5

" Some shortcuts for commenting things
map ,! :s/^/!/<CR>  
map !, :s/^\([ ]*\)!/\1/<CR>
map ,db ma%:'a,.d<CR>
map ,c :s/^/\/\//<CR>  
map ,,c :s/^\([ ]*\)\/\//\1/<CR>

" Some windowsisms are hard to let go of
map  <S-Insert> "+gP
imap <S-Insert> <C-R>+
cmap <S-Insert> <C-R>+

" Lazy typing in caps can be a pain
imap <S-Del> <BS>

" enable automatic comment stuff
set textwidth=80
" enable carriage return auto-commenting
set formatoptions+=r

" use a fancy title for vim windows
"let hostname = expand("`hostname`")
"auto BufEnter * let &titlestring = hostname . "/" . expand("%:p")
"set title

" Split and next for vertical windows
command! -nargs=0 Vsn set columns=161 | set lines=80 | vsplit | next

command! DiffOrig vert new 
     \ | set bt=nofile 
     \ | r # 
     \ | 0d_ 
     \ | diffthis 
     \ | wincmd p 
     \ | diffthis

" Highlight (textwidth? + 1)th colum
set colorcolumn=+1

" YCM config
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=0
let g:ycm_confirm_extra_conf=0
let g:ycm_server_log_level='debug'

" enable modelines
set modeline
set modelines=5
