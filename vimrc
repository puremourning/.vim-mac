runtime defaults.vim

" use comma for commands
let mapleader=','

if has( 'win32' )
  set encoding=utf-8
endif

if has( 'nvim' )
  if exists( '$PYENV_ROOT' )
    let g:python_host_prog=expand( '$PYENV_ROOT/versions/nvim2/bin/python' )
    let g:python3_host_prog=expand( '$PYENV_ROOT/versions/nvim3/bin/python' )
  elseif isdirectory( '$HOME/.pyenv' )
    let g:python_host_prog=expand( '$HOME/.pyenv/versions/nvim2/bin/python' )
    let g:python3_host_prog=expand( '$HOME/.pyenv/versions/nvim3/bin/python' )
  endif
endif

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

function! BenGetCustomHighlighting()
  " This is sufficient to make StatusLine _set_ and _different from
  " StatusLineNC_, so that our statusline settings are applied sensibly to
  " non-current windows
  if !has( 'gui_running' ) && !&termguicolors
    hi clear StatusLine
    hi StatusLine gui=bold cterm=bold term=bold
  endif

  hi! link User1 PmenuSel
  hi! link User2 CursorLineNr
  hi! link User3 ModeMsg

  " Make comments a bit more readable in Apprentice
  if s:cs =~ "^apprentice"
    hi Comment ctermfg=101 guifg=#87875f
  endif

endfunction

augroup BenCustomHighlighting
  autocmd!
  autocmd ColorScheme * call BenGetCustomHighlighting()
augroup END

let s:cs = 'apprentice'

if has( 'win32' )
  set t_Co=256
  let s:cs = 'apprentice_low'
endif

if exists( '$TMUX' )
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if s:cs ==# 'solarized'
  silent! colorscheme solarized
elseif s:cs ==# 'apprentice'
  if $TERM_PROGRAM !=# 'Apple_Terminal'
    set termguicolors
  endif
  silent! colorscheme apprentice
elseif s:cs ==# 'apprentice_low'
  silent! colorscheme apprentice
elseif s:cs ==# 'solarized8'
  if $TERM_PROGRAM !=# 'Apple_Terminal'
    set termguicolors
  endif
  silent! colorscheme solarized8
endif
set cursorline
set noshowmode

" set the font
set guifont=Lucida_Console:h9:cDEFAULT

" visual selection copied to clipboard
set guioptions=at

" set the height and width (might be broken columns for diff)
" set lines=50 columns=80

" Set up indenting, and searching
set shiftwidth=2 expandtab incsearch showmatch smartcase autoindent

" use clever case searches when ignorecase is turned on
set smartcase

" use more stuff for the completions
set complete=.,w,b,u,i

" Use a popup for the completion preview window if available
try
  set completeopt+=popup
  set completepopup=height:10,width:60,highlight:PmenuSbar,border:off
catch /.*/
endtry

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

" Highlight (textwidth? + 1)th colum
set colorcolumn=+1

" enable modelines
set modeline
set modelines=5

" don't have spelling turned on, it's too annoying
" set spell

" Better mouse support
set mouse+=a
if !has( 'nvim' )
  set ttymouse=sgr
  set clipboard+=autoselect
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

set shortmess+=c
set noshowmode

" OK i'm sick of typing : now
nnoremap ; :
" OK i'm also sick of typing escape just typing in insert mode is
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

command! YcmLogErr :botright vertical 75YcmToggleLogs ycmd*stderr*

let g:netrw_liststyle = 3
" let g:netrw_list_hide = netrw_gitignore#Hide()

" Make ctrl-space work in terminal
tnoremap <Nul> <C-Space>

if !has( 'nvim' )
  augroup BenTerminal
    autocmd!
    autocmd TerminalWinOpen * setlocal signcolumn=no textwidth=0 nonumber
  augroup END
endif
