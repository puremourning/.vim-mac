" use comma for commands
let mapleader=','

" enable syntax hilighting
syn on

"Vundle plugins
runtime! vundle_plugins

"Local packages
runtime! packages.vim

set nocompatible
set wildmode=longest:full,full
set wildmenu
" For gf and :find
set path+=**

set wildignore=*.pyc

" default to xterm behaviour
behave xterm

" enable my colour scheme
set background=dark
colorscheme solarized
set cursorline

" set the font
set guifont=Lucida_Console:h9:cDEFAULT

" visual selection copied to clipboard
set guioptions+=a

" set the height and width (might be broken columns for diff)
" set lines=50 columns=80

" Set up indenting, and searching
set shiftwidth=4 expandtab incsearch showmatch smartcase autoindent

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

" Split and next for vertical windows
command! -nargs=0 Vsn set columns=163 | set lines=80 | vsplit | next

command! DiffOrig vert new
     \ | set bt=nofile
     \ | r #
     \ | 0d_
     \ | diffthis
     \ | wincmd p
     \ | diffthis

" Highlight (textwidth? + 1)th colum
set colorcolumn=+1

" enable modelines
set modeline
set modelines=5

" always have spelling turned on, even if annoying
set spell

" Better mouse support
set mouse+=a
set ttymouse=sgr
set clipboard+=autoselect
set title

" don't indent namespaces
set cinoptions+=N-s
" align continuations within open parens with the start of the parens
set cinoptions+=(0
" but when the last char of the prev line is the open parens, just indent 1 sw
set cinoptions+=Ws
" line up close brackets on their own line like blocks
set cinoptions+=m1
" enable sane java and javascript indenting
set cinoptions+=j1,J1

" try and tidy up the default vim python indentation
let g:pyindent_continue = 'shiftwidth()'
let g:pyindent_nested_paren = 'shiftwidth()'
let g:pyindent_open_paren = 'shiftwidth()'
