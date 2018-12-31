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

" Persistent undo
set undofile

set wildignore=*.pyc

" default to xterm behaviour
behave xterm

" enable my colour scheme
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
set background=dark
let s:cs = 'apprentice_low'
if s:cs == 'solarized'
  colorscheme solarized
elseif s:cs == 'apprentice'
  set termguicolors
  colorscheme apprentice
elseif s:cs == 'apprentice_low'
  colorscheme apprentice
elseif s:cs == 'solarized8'
  set termguicolors
  colorscheme solarized8
endif
set cursorline
set noshowmode

" set the font
set guifont=Lucida_Console:h9:cDEFAULT

" visual selection copied to clipboard
set guioptions+=a

" set the height and width (might be broken columns for diff)
" set lines=50 columns=80

" Set up indenting, and searching
set shiftwidth=2 expandtab incsearch showmatch smartcase autoindent

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
if !has( 'nvim' )
  set ttymouse=sgr
  set clipboard+=autoselect
else
  let g:python_host_prog = '/usr/bin/python2.7'
  let g:ycm_path_to_python_interpreter = '/usr/bin/python2.7'
endif
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

" So i can see hard tabs
set listchars=tab:>-
set list

nnoremap <A-S-}> :tabnext<CR>
nnoremap <A-S-{> :tabprevious<CR>

nnoremap <leader>W :botright vertical terminal ++cols=100 ++close
      \ env TERM=xterm-256color weechat<CR>

let s:modemap = {
      \ 'n':  'NORMAL',
      \ 'no': 'NORMAL',
      \ 'v':  'VISUAL',
      \ 'V':  'VISUAL',
      \ '': 'VISUAL',
      \ 's':  'SELECT',
      \ 'S':  'SELECT',
      \ 'i':  'INSERT',
      \ 'ic': 'INSERT',
      \ 'ix': 'INSERT',
      \ 'R':  'REPLACE',
      \ 'Rc': 'REPLACE',
      \ 'Rx': 'REPLACE',
      \ 'Rb': 'REPLACE',
      \ 'c':  'COMMAND',
      \ 'cv': 'COMMAND',
      \ 'ce': 'COMMAND',
      \ 'r':  'COMMAND',
      \ 'rm': 'COMMAND',
      \ 'r?': 'COMMAND',
      \ '!':  'SHELL',
      \ 't':  'SHELL+'
      \ }


function! BenGetMode()
  let l:m=mode()
  if has_key( s:modemap, l:m )
    return s:modemap[ l:m ]
  endif
  return "ERROR"
endfunction

set statusline=
set statusline+=%1*
set statusline+=\ %{BenGetMode()}\ 
set statusline+=%2*
set statusline+=\ %<%f
set statusline+=%(\ [%M%R%H]%)
set statusline+=%=
set statusline+=%3*
set statusline+=\ %y
set statusline+=\ %l:%c/%L
set statusline+=\ 

hi! link User1 PmenuSel
hi! link User2 CursorLineNr
hi! link User3 ModeMsg

set shortmess+=c
set noshowmode

" OK i'm sick of typing : now
nnoremap ; :
" OK i'm also scik of typing escape just typing in insert mode is 
inoremap jk <ESC>

" :help emacs-keys
" start of line
cnoremap <C-A>         <Home>
" back one character
cnoremap <C-B>         <Left>
" delete character under cursor
cnoremap <C-D>         <Del>
" end of line
cnoremap <C-E>         <End>
" forward one character
cnoremap <C-F>         <Right>
" recall newer command-line
cnoremap <C-N>         <Down>
" recall previous (older) command-line
cnoremap <C-P>         <Up>
" back one word
cnoremap <Esc><C-B>    <S-Left>
" forward one word
cnoremap <Esc><C-F>    <S-Right>
