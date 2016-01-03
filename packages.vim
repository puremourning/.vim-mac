
" Options
let g:pyclewn_args = '--level=debug --file=~/.pyclewn_log' 
let g:pyclewn_terminal = 'terminal'

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
