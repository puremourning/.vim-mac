
" Options
let s:pyclewn_terminal =
            \ 'PYCLEWN=' . 
            \ expand( '~/.vim/bundle/YouCompleteMe-Clean/third_party/ycmd/runtime' ) . 
            \ ', ' .
            \ expand( '~/.vim/run_terminal' )

if has( 'gui_running' )
  let g:pyclewn_terminal = s:pyclewn_terminal
endif

let g:pyclewn_args = '--level=debug --file=' . expand( '~/.pyclewn_log' ) 
            \ . ' --terminal "' . expand( '~/.vim/run_terminal' ) . '"'

" Configure packages

let s:pkg_root = expand( '~/.vim/package/' )
let s:packages = [ 'pyclewn' ]

" and load them

function! s:LoadPackages()
    for pkg in s:packages
        let pkgdir = s:pkg_root . pkg
        exe "set" "runtimepath+=" . pkgdir
    endfor
endfunction

call s:LoadPackages()
