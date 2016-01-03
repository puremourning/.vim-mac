" Pyclewn run time file.
" Maintainer:   <xdegaye at users dot sourceforge dot net>

" Enable balloon_eval.
if has("balloon_eval")
    set ballooneval
    set balloondelay=100
endif

" The 'Pyclewn' command starts pyclewn and vim netbeans interface.
command -nargs=* -complete=file Pyclewn call pyclewn#start#StartClewn(<f-args>)
