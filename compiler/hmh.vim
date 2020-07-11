if exists("current_compiler")
  finish
endif
let current_compiler = "hmh"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let &l:makeprg=findfile( 'code/build.sh', '.;' ) . ' $*'

" The build script echos the pushd/popd commands it runs, so recognise them for
" the paths in the compiler output
setlocal errorformat+=%Dpushd\ %f
setlocal errorformat+=%Xpopd

nnoremap <buffer> ∫ :<C-u>Make<CR>
nnoremap <buffer> ı :<C-u>Make --debug<CR>

